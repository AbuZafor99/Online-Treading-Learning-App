import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../controllers/marketplace_controller.dart';

class InvoiceWebViewScreen extends StatefulWidget {
  final String invoiceUrl;
  final String? transactionId; // Pass transaction ID from payment creation
  const InvoiceWebViewScreen({
    super.key,
    required this.invoiceUrl,
    this.transactionId,
  });

  @override
  State<InvoiceWebViewScreen> createState() => _InvoiceWebViewScreenState();
}

class _InvoiceWebViewScreenState extends State<InvoiceWebViewScreen> {
  WebViewController? _controller;
  bool _isReady = false;
  String? _extractedInvoiceId;
  Timer? _urlCheckTimer;
  bool _paymentProcessed = false;
  bool _paymentWasSuccessful = false;

  @override
  void initState() {
    super.initState();
    _extractInvoiceIdFromUrl();

    // Delay controller creation until after first frame to avoid platform
    // channel race conditions on some Android devices / engine states.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final ctrl = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (String url) {
                print('[InvoiceWebView] Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('[InvoiceWebView] Page finished loading: $url');
                print('[InvoiceWebView] About to check for payment completion...');
                _checkForPaymentCompletion(url);
                print('[InvoiceWebView] Finished checking for payment completion');
              },
              onNavigationRequest: (NavigationRequest request) {
                print('[InvoiceWebView] Navigation request: ${request.url}');
                print('[InvoiceWebView] About to check navigation URL for payment completion...');
                _checkForPaymentCompletion(request.url);
                print('[InvoiceWebView] Finished checking navigation URL');
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.invoiceUrl));

        setState(() {
          _controller = ctrl;
          _isReady = true;
        });
        
        // Start periodic URL checking after controller is ready
        _startPeriodicUrlCheck();
      } catch (e) {
        // If controller init fails, keep screen functional and show error
        setState(() {
          _controller = null;
          _isReady = false;
        });
      }
    });
  }

  void _startPeriodicUrlCheck() {
    print('[InvoiceWebView] Starting periodic URL check');
    _urlCheckTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (_controller != null && !_paymentProcessed) {
        try {
          // Check current URL
          final currentUrl = await _controller!.currentUrl();
          if (currentUrl != null) {
            print('[InvoiceWebView] Periodic check - Current URL: $currentUrl');
            _checkForPaymentCompletion(currentUrl);
          }
          
          // Also check page content for payment status indicators
          await _checkPageContent();
        } catch (e) {
          print('[InvoiceWebView] Error during periodic check: $e');
        }
      }
    });
  }

  Future<void> _checkPageContent() async {
    if (_controller == null) return;
    
    try {
      // Check for common payment completion indicators in the page
      final result = await _controller!.runJavaScriptReturningResult('''
        (function() {
          var bodyText = document.body.innerText.toLowerCase();
          var url = window.location.href;
          
          // Check for success indicators
          if (bodyText.includes('payment successful') || 
              bodyText.includes('payment complete') || 
              bodyText.includes('transaction successful') ||
              bodyText.includes('thank you') ||
              bodyText.includes('success') ||
              url.includes('success') ||
              url.includes('complete')) {
            return 'SUCCESS';
          }
          
          // Check for failure indicators  
          if (bodyText.includes('payment failed') || 
              bodyText.includes('payment rejected') ||
              bodyText.includes('transaction failed') ||
              bodyText.includes('failed') ||
              bodyText.includes('error') ||
              url.includes('fail') ||
              url.includes('error')) {
            return 'FAILED';
          }
          
          return 'PENDING';
        })();
      ''');
      
      String status = result.toString().replaceAll('"', '');
      print('[InvoiceWebView] Page content check result: $status');
      
      if (status == 'SUCCESS' || status == 'FAILED') {
        print('[InvoiceWebView] Payment completion detected via page content: $status');
        _handlePaymentCompletion(status == 'SUCCESS');
      }
    } catch (e) {
      print('[InvoiceWebView] Error checking page content: $e');
    }
  }

  Future<void> _confirmPaymentOnServer() async {
    if (_extractedInvoiceId == null) {
      print('[InvoiceWebView] Cannot confirm payment - no invoice ID extracted');
      return;
    }

    try {
      print('[InvoiceWebView] Confirming payment on server for invoice: $_extractedInvoiceId');
      
      // Get the marketplace controller
      final marketplaceController = Get.find<MarketplaceController>();
      
      // Call the confirm payment API
      final success = await marketplaceController.confirmPayment(
        invoiceId: _extractedInvoiceId!,
      );
      
      if (success) {
        print('[InvoiceWebView] Payment confirmation successful');
      } else {
        print('[InvoiceWebView] Payment confirmation failed');
      }
    } catch (e) {
      print('[InvoiceWebView] Error confirming payment: $e');
    }
  }

  @override
  void dispose() {
    _urlCheckTimer?.cancel();
    super.dispose();
  }

  void _extractInvoiceIdFromUrl() {
    try {
      final uri = Uri.parse(widget.invoiceUrl);
      // Extract invoice ID from Xendit URL path
      // URL format: https://checkout-staging.xendit.co/web/{invoiceId}
      final pathSegments = uri.pathSegments;
      if (pathSegments.length >= 2 && pathSegments[0] == 'web') {
        _extractedInvoiceId = pathSegments[1];
        print('[InvoiceWebView] Extracted Invoice ID: $_extractedInvoiceId');
      }
    } catch (e) {
      print('[InvoiceWebView] Error extracting invoice ID: $e');
    }
  }

  void _checkForPaymentCompletion(String url) {
    print('[InvoiceWebView] Checking URL for payment completion: $url');
    print('[InvoiceWebView] Original invoice URL: ${widget.invoiceUrl}');

    // Check for Xendit payment completion patterns (more comprehensive)
    bool isSuccess = false;
    bool isFailure = false;

    // Check success patterns
    if (url.contains('success') ||
        url.contains('completed') ||
        url.contains('paid') ||
        url.contains('checkout/success') ||
        url.contains('payment-success') ||
        url.contains('status=paid') ||
        url.contains('status=completed') ||
        url.contains('result=success')) {
      isSuccess = true;
      print('[InvoiceWebView] SUCCESS pattern matched in URL: $url');
    }

    // Check failure patterns
    if (url.contains('failed') ||
        url.contains('cancelled') ||
        url.contains('error') ||
        url.contains('checkout/failed') ||
        url.contains('payment-failed') ||
        url.contains('status=failed') ||
        url.contains('status=cancelled') ||
        url.contains('result=failed')) {
      isFailure = true;
      print('[InvoiceWebView] FAILURE pattern matched in URL: $url');
    }

    // Handle results
    if (isSuccess) {
      print('[InvoiceWebView] Payment SUCCESS detected from URL: $url');
      _handlePaymentCompletion(true);
    } else if (isFailure) {
      print('[InvoiceWebView] Payment FAILED detected from URL: $url');
      _handlePaymentCompletion(false);
    } else {
      print('[InvoiceWebView] No payment completion pattern found in URL: $url');
    }

    // Also check if the URL has changed significantly from the original invoice URL
    // This could indicate a redirect after payment completion
    if (!url.contains('checkout') && !url.startsWith(widget.invoiceUrl)) {
      print(
        '[InvoiceWebView] URL changed significantly, might indicate completion: $url',
      );
      print('[InvoiceWebView] Consider this as a potential payment completion signal');
      
      // For testing purposes, if URL changes significantly and doesn't contain checkout,
      // let's assume it's a success (you can modify this logic based on actual Xendit behavior)
      if (!url.startsWith('https://checkout-staging.xendit.co/') && 
          !url.contains('xendit.co')) {
        print('[InvoiceWebView] URL redirected away from Xendit, assuming payment completion');
        _handlePaymentCompletion(true);
      }
    }
  }

  void _handlePaymentCompletion(bool isSuccess) {
    // Prevent multiple triggers
    if (!mounted || _paymentProcessed) return;
    
    _paymentProcessed = true;
    _paymentWasSuccessful = isSuccess; // Track the result
    _urlCheckTimer?.cancel(); // Stop periodic checking

    print(
      '[InvoiceWebView] Handling payment completion: ${isSuccess ? 'SUCCESS' : 'FAILED'}',
    );
    print('[InvoiceWebView] Transaction ID: ${widget.transactionId}');
    print('[InvoiceWebView] Invoice ID: $_extractedInvoiceId');

    // Show a brief message and redirect to home page
    Get.snackbar(
      isSuccess ? 'Payment Successful!' : 'Payment Failed!',
      isSuccess
          ? 'Your payment has been processed successfully.'
          : 'Your payment could not be processed.',
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );

    // Redirect to home page after a brief delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _redirectToHome();
      }
    });
  }

  void _redirectToHome() {
    try {
      // Go back to marketplace details screen instead of home
      Get.back();
      
      // Show payment result dialog after a brief delay to ensure we're back on marketplace screen
      Future.delayed(const Duration(milliseconds: 500), () {
        _showPaymentResultDialog();
      });
    } catch (e) {
      try {
        // Fallback: Use Navigator to go back
        Navigator.of(context).pop();
        Future.delayed(const Duration(milliseconds: 500), () {
          _showPaymentResultDialog();
        });
      } catch (e2) {
        // Last resort: Go directly to home
        Get.offAll(() => const HomeScreen());
      }
    }
  }

  void _showPaymentResultDialog() {
    // Use the tracked payment result
    final bool wasSuccessful = _paymentWasSuccessful;
    
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Row(
          children: [
            Icon(
              wasSuccessful ? Icons.check_circle : Icons.error,
              color: wasSuccessful ? Colors.green : Colors.red,
              size: 32,
            ),
            const SizedBox(width: 12),
            Text(
              wasSuccessful ? 'Congratulations!' : 'Payment Failed',
              style: TextStyle(
                color: wasSuccessful ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              wasSuccessful 
                ? 'Your payment has been processed successfully! Thank you for your purchase.'
                : 'Your payment could not be processed. Please try again or contact support.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            if (wasSuccessful) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.download_done, color: Colors.green.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Your purchase is now available in your account.',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // Confirm payment on server before staying
              await _confirmPaymentOnServer();
              Get.back(); // Close dialog
            },
            child: const Text(
              'Stay Here',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Confirm payment on server before going home
              await _confirmPaymentOnServer();
              Get.back(); // Close dialog
              Get.offAll(() => const HomeScreen()); // Go to home
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: wasSuccessful ? Colors.green : Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Back to Home'),
          ),
        ],
      ),
      barrierDismissible: false, // User must click a button
    );
  }

  // UI/dialogs removed from this screen. Caller should present any confirmation UI.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Minimal screen: only the webview (full screen). No app bar or extra UI.
      body: _isReady && _controller != null
          ? SafeArea(child: WebViewWidget(controller: _controller!))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
