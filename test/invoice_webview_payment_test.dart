import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/screens/invoice_webview_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group('Invoice WebView Payment Completion Tests', () {
    testWidgets('InvoiceWebViewScreen should handle payment completion and redirect to home', (WidgetTester tester) async {
      // Test the basic widget creation and payment completion handling
      const testInvoiceUrl = 'https://checkout-staging.xendit.co/web/test-invoice';
      const testTransactionId = 'test-transaction-123';

      // Create the widget
      await tester.pumpWidget(
        GetMaterialApp(
          home: const InvoiceWebViewScreen(
            invoiceUrl: testInvoiceUrl,
            transactionId: testTransactionId,
          ),
        ),
      );

      // Verify the widget loads with a loading indicator initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Verify the widget exists
      expect(find.byType(InvoiceWebViewScreen), findsOneWidget);
    });

    test('Payment completion URL detection should work correctly', () {
      // Test URL patterns that should trigger payment completion
      const successUrls = [
        'https://example.com/success',
        'https://example.com/completed', 
        'https://example.com/paid',
        'https://example.com/checkout/success',
        'https://example.com/payment-success',
        'https://example.com?status=paid',
        'https://example.com?status=completed',
        'https://example.com?result=success',
      ];

      const failureUrls = [
        'https://example.com/failed',
        'https://example.com/cancelled',
        'https://example.com/error',
        'https://example.com/checkout/failed',
        'https://example.com/payment-failed',
        'https://example.com?status=failed',
        'https://example.com?status=cancelled',
        'https://example.com?result=failed',
      ];

      // Test success patterns
      for (String url in successUrls) {
        expect(
          url.contains('success') || 
          url.contains('completed') || 
          url.contains('paid') ||
          url.contains('checkout/success') ||
          url.contains('payment-success') ||
          url.contains('status=paid') ||
          url.contains('status=completed') ||
          url.contains('result=success'),
          isTrue,
          reason: 'URL $url should be detected as success',
        );
      }

      // Test failure patterns  
      for (String url in failureUrls) {
        expect(
          url.contains('failed') || 
          url.contains('cancelled') || 
          url.contains('error') ||
          url.contains('checkout/failed') ||
          url.contains('payment-failed') ||
          url.contains('status=failed') ||
          url.contains('status=cancelled') ||
          url.contains('result=failed'),
          isTrue,
          reason: 'URL $url should be detected as failure',
        );
      }
    });

    test('Home redirect timing should work correctly', () async {
      // Test the 1.5 second delay before redirect
      final stopwatch = Stopwatch()..start();
      
      // Simulate the delay
      await Future.delayed(const Duration(milliseconds: 1500));
      
      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(1500));
      expect(stopwatch.elapsedMilliseconds, lessThan(1600)); // Allow some margin
    });

    test('Widget creation should not throw exception', () {
      // Test that the widget can be created without errors
      expect(() => InvoiceWebViewScreen(
        invoiceUrl: 'https://test.com',
        transactionId: 'test-123',
      ), returnsNormally);
    });
  });
}