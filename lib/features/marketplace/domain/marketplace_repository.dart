import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';

import '../models/marketplace_item_api_model.dart';

abstract class MarketplaceRepository {
  Future<Either<NetworkFailure, NetworkSuccess<List<MarketplaceItemApiModel>>>>
  fetchAllMarketplaceItems();
  Future<Either<NetworkFailure, NetworkSuccess<MarketplaceItemApiModel>>>
  fetchMarketplaceItemById(String id);

  /// Create payment for a marketplace product. Returns NetworkSuccess with
  /// a Map containing keys: invoiceUrl, transactionId, message
  Future<Either<NetworkFailure, NetworkSuccess<Map<String, dynamic>>>>
  createPayment({
    required String userId,
    required num price,
    required String productId,
    required String type,
  });

  /// Confirm payment completion with invoice ID
  Future<Either<NetworkFailure, NetworkSuccess<Map<String, dynamic>>>>
  confirmPayment({
    required String invoiceId,
  });
}
