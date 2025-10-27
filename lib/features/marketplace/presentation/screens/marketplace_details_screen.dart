import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/controllers/marketplace_controller.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/screens/invoice_webview_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';

class MarketplaceDetailsScreen extends StatefulWidget {
  const MarketplaceDetailsScreen({super.key});

  @override
  State<MarketplaceDetailsScreen> createState() =>
      _MarketplaceDetailsScreenState();
}

class _MarketplaceDetailsScreenState extends State<MarketplaceDetailsScreen> {
  late MarketplaceController marketplaceController;
  String? itemId;

  @override
  void initState() {
    super.initState();
    marketplaceController = Get.find<MarketplaceController>();
    itemId = Get.arguments as String?;

    if (itemId != null) {
      marketplaceController.fetchMarketplaceItemById(itemId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // React to loading and selected item changes
      final isLoading = marketplaceController.isLoadingDetails.value;
      final item = marketplaceController.selectedItem.value;

      // AppBar title comes from selected item when available
      return Scaffold(
        appBar: AppBar(
          title: Text(
            item?.title ?? 'Marketplace Item',
            style: const TextStyle(
              color: AppColors.appBarTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : (item == null
                    ? const Center(
                        child: Text(
                          'Item not found!',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textColorBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: item.image.isNotEmpty
                                        ? Image.network(
                                            item.image,
                                            width: double.infinity,
                                            height: 250,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    width: double.infinity,
                                                    height: 250,
                                                    color: Colors.grey.shade200,
                                                    child: Icon(
                                                      Icons.image,
                                                      color:
                                                          Colors.grey.shade400,
                                                      size: 80,
                                                    ),
                                                  );
                                                },
                                          )
                                        : Container(
                                            width: double.infinity,
                                            height: 250,
                                            color: Colors.grey.shade200,
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.grey.shade400,
                                              size: 80,
                                            ),
                                          ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Type Badge and Title Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (item.displayType.isNotEmpty)
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            color: _getTypeColor(item.type),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 8,
                                            ),
                                            child: CustomText(
                                              item.displayType,
                                              style: const TextStyle(
                                                color: AppColors.titleTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),

                                      // Title
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: CustomText(
                                            item.title,
                                            style: const TextStyle(
                                              color: AppColors.titleTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // Extended description if needed
                                  CustomText(
                                    item.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.text,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
        ),
        // Fixed payment bar anchored to bottom
        bottomNavigationBar: (isLoading || item == null)
            ? null
            : Container(
                color: AppColors.paymentColor,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              'Total',
                              style: TextStyle(
                                color: AppColors.titleTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CustomText(
                              item.displayPrice,
                              style: const TextStyle(
                                color: AppColors.titleTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(
                            child: context.secondaryButton(
                              borderColor: AppColors.buttonColor,
                              onPressed: () {},
                              text: 'Add to Cart',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: context.primaryButton(
                              textColor: AppColors.appBarTitle,
                              onPressed: () async {
                                // If free, you might do a different flow
                                if (item.isFree) {
                                  // handle free item (not implemented)
                                  return;
                                }

                                // Create payment via controller
                                // Get current user id from profile controller if available
                                String userId = '';
                                try {
                                  final profileController = Get.find<ProfileController>();
                                  userId = profileController.userInfo.value?.id ?? '';
                                } catch (_) {
                                  userId = '';
                                }

                                final priceNum = double.tryParse(item.price) ?? 0.0;

                                final paymentDetails = await marketplaceController.createPaymentForItem(
                                  userId: userId,
                                  price: priceNum,
                                  productId: item.id,
                                  type: 'product',
                                );

                                if (paymentDetails != null && paymentDetails['invoiceUrl'] != null) {
                                  final invoiceUrl = paymentDetails['invoiceUrl']!;
                                  final transactionId = paymentDetails['transactionId'];
                                  
                                  // Open webview with invoiceUrl and transactionId
                                  Get.to(() => InvoiceWebViewScreen(
                                    invoiceUrl: invoiceUrl,
                                    transactionId: transactionId,
                                  ));
                                } else {
                                  // Show error feedback
                                  Get.snackbar('Payment Error', 'Unable to create invoice.');
                                }
                              },
                              text: item.isFree ? 'Get Free' : 'Shop Now',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
      );
    });
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'best seller':
        return AppColors.bestSellerBoxColor;
      case 'free':
        return Colors.green.shade100;
      case 'recommended':
        return Colors.blue.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}
