import 'package:get/get.dart';

import '../../domain/marketplace_repository.dart';
import '../../models/marketplace_item_api_model.dart';

class MarketplaceController extends GetxController {
  final MarketplaceRepository repository;
  MarketplaceController({required this.repository});

  final marketplaceItems = <MarketplaceItemApiModel>[].obs;
  final isLoading = false.obs;
  final selectedItem = Rxn<MarketplaceItemApiModel>();
  final isLoadingDetails = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMarketplaceItems();
  }

  Future<void> fetchMarketplaceItems() async {
    try {
      isLoading.value = true;
      final result = await repository.fetchAllMarketplaceItems();

      result.fold(
        (failure) {
          print('[MarketplaceController] failure: ${failure.message}');
          marketplaceItems.clear();
        },
        (success) {
          print(
            '[MarketplaceController] success.data length: ${success.data.length}',
          );
          if (success.data.isNotEmpty) {
            print(
              '[MarketplaceController] first item: ${success.data.first.title}',
            );
          }
          marketplaceItems.assignAll(success.data);
          print(
            '>>>>>>> API MARKETPLACE ITEMS loaded: ${marketplaceItems.length}',
          );
        },
      );
    } catch (e, st) {
      print('[MarketplaceController] fetchMarketplaceItems exception: $e\n$st');
      marketplaceItems.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMarketplaceItemById(String id) async {
    try {
      isLoadingDetails.value = true;
      selectedItem.value = null;
      print(
        '[MarketplaceController] calling repository.fetchMarketplaceItemById($id)',
      );
      final result = await repository.fetchMarketplaceItemById(id);
      print(
        '[MarketplaceController] repository returned type for details: ${result.runtimeType}',
      );

      result.fold(
        (failure) {
          print('[MarketplaceController] details failure: ${failure.message}');
          selectedItem.value = null;
        },
        (success) {
          print(
            '[MarketplaceController] details success: ${success.data.title}',
          );
          selectedItem.value = success.data;
          print(
            '>>>>>>> API MARKETPLACE ITEM DETAILS loaded: ${selectedItem.value?.title}',
          );
        },
      );
    } catch (e, st) {
      print(
        '[MarketplaceController] fetchMarketplaceItemById exception: $e\n$st',
      );
      selectedItem.value = null;
    } finally {
      isLoadingDetails.value = false;
    }
  }

  // Helper method to refresh marketplace items
  Future<void> refreshMarketplaceItems() async {
    await fetchMarketplaceItems();
  }

  /// Create payment and return payment details map with invoice URL and transaction ID.
  /// On success the UI caller can navigate to the invoice URL.
  Future<Map<String, String>?> createPaymentForItem({
    required String userId,
    required num price,
    required String productId,
    String type = 'product',
  }) async {
    try {
      final res = await repository.createPayment(
        userId: userId,
        price: price,
        productId: productId,
        type: type,
      );
      Map<String, String>? paymentDetails;
      res.fold(
        (failure) {
          print(
            '[MarketplaceController] createPayment failed: ${failure.message}',
          );
        },
        (success) {
          final map = success.data;
          final invoiceUrl =
              map['invoiceUrl'] as String? ?? map['invoice_url'] as String?;
          final transactionId =
              map['transactionId'] as String? ??
              map['transaction_id'] as String? ??
              map['id'] as String?;

          print(
            '[MarketplaceController] createPayment success invoiceUrl: $invoiceUrl',
          );
          print(
            '[MarketplaceController] createPayment transactionId: $transactionId',
          );

          if (invoiceUrl != null) {
            paymentDetails = {
              'invoiceUrl': invoiceUrl,
              if (transactionId != null) 'transactionId': transactionId,
            };
          }
        },
      );
      return paymentDetails;
    } catch (e) {
      print('[MarketplaceController] createPayment exception: $e');
      return null;
    }
  }

  /// Confirm payment completion
  Future<bool> confirmPayment({required String invoiceId}) async {
    try {
      print('[MarketplaceController] confirming payment for invoiceId: $invoiceId');
      
      final result = await repository.confirmPayment(invoiceId: invoiceId);
      
      return result.fold(
        (failure) {
          print('[MarketplaceController] confirmPayment failed: ${failure.message}');
          return false;
        },
        (success) {
          print('[MarketplaceController] confirmPayment success');
          return true;
        },
      );
    } catch (e) {
      print('[MarketplaceController] confirmPayment exception: $e');
      return false;
    }
  }
}
