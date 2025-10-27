import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';
import 'package:flutter_ladydenily/core/network/constants/api_constants.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';

import '../domain/marketplace_repository.dart';
import '../models/marketplace_item_api_model.dart';

class MarketplaceRepositoryImpl implements MarketplaceRepository {
  final ApiClient _apiClient;

  MarketplaceRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<Either<NetworkFailure, NetworkSuccess<List<MarketplaceItemApiModel>>>>
  fetchAllMarketplaceItems() async {
    print('[MarketplaceRepositoryImpl] fetching all marketplace items');

    return _apiClient.get<List<MarketplaceItemApiModel>>(
      '${ApiConstants.baseUrl}/market/',
      fromJsonT: (json) {
        print(
          '[MarketplaceRepositoryImpl] fromJsonT received: ${json.runtimeType} -> $json',
        );

        List<MarketplaceItemApiModel> items = [];

        try {
          if (json == null) {
            return items;
          }

          // Handle different JSON response shapes
          List<dynamic> itemsList = [];

          if (json is List) {
            itemsList = json;
          } else if (json is Map && json['data'] is List) {
            itemsList = json['data'] as List;
          } else if (json is Map && json['items'] is List) {
            itemsList = json['items'] as List;
          } else if (json is Map && json['marketplace'] is List) {
            itemsList = json['marketplace'] as List;
          }

          print(
            '[MarketplaceRepositoryImpl] found ${itemsList.length} marketplace items',
          );

          for (var itemData in itemsList) {
            if (itemData is Map) {
              try {
                print('[MarketplaceRepositoryImpl] parsing item: $itemData');
                final item = MarketplaceItemApiModel.fromJson(
                  Map<String, dynamic>.from(itemData),
                );
                items.add(item);
                print(
                  '[MarketplaceRepositoryImpl] successfully parsed item: ${item.title}',
                );
              } catch (e, stackTrace) {
                print(
                  '[MarketplaceRepositoryImpl] error parsing marketplace item: $e\n$stackTrace',
                );
              }
            }
          }

          print(
            '[MarketplaceRepositoryImpl] successfully parsed ${items.length} marketplace items',
          );
        } catch (e) {
          print(
            '[MarketplaceRepositoryImpl] error processing marketplace items: $e',
          );
        }

        return items;
      },
    );
  }

  @override
  Future<Either<NetworkFailure, NetworkSuccess<Map<String, dynamic>>>>
  createPayment({
    required String userId,
    required num price,
    required String productId,
    required String type,
  }) async {
    final endpoint = '${ApiConstants.baseUrl}/payment/create-payment';
    print(
      '[MarketplaceRepositoryImpl] creating payment for productId: $productId, price: $price',
    );

    return _apiClient.post<Map<String, dynamic>>(
      endpoint,
      data: {
        'userId': userId,
        'price': price,
        'productId': productId,
        'type': type,
      },
      fromJsonT: (json) {
        // Expecting { invoiceUrl, transactionId, message }
        if (json == null) return <String, dynamic>{};
        if (json is Map<String, dynamic>) return json;
        try {
          return Map<String, dynamic>.from(json);
        } catch (e) {
          return <String, dynamic>{};
        }
      },
    );
  }

  @override
  Future<Either<NetworkFailure, NetworkSuccess<MarketplaceItemApiModel>>>
  fetchMarketplaceItemById(String id) async {
    print('[MarketplaceRepositoryImpl] fetching marketplace item by id: $id');

    return _apiClient.get<MarketplaceItemApiModel>(
      '${ApiConstants.baseUrl}/market/$id',
      fromJsonT: (json) {
        print(
          '[MarketplaceRepositoryImpl] fromJsonT for single item received: ${json.runtimeType} -> $json',
        );

        try {
          if (json == null) {
            throw Exception('No data received for marketplace item');
          }

          Map<String, dynamic> itemData = {};

          // Handle different response shapes
          if (json is Map<String, dynamic>) {
            // Check if data is nested
            if (json.containsKey('data') && json['data'] is Map) {
              itemData = Map<String, dynamic>.from(json['data']);
            } else {
              itemData = json;
            }
          } else if (json is Map) {
            itemData = Map<String, dynamic>.from(json);
          } else {
            throw Exception('Invalid data format for marketplace item');
          }

          final item = MarketplaceItemApiModel.fromJson(itemData);
          print(
            '[MarketplaceRepositoryImpl] successfully parsed marketplace item: ${item.title}',
          );

          return item;
        } catch (e) {
          print(
            '[MarketplaceRepositoryImpl] error parsing single marketplace item: $e',
          );
          throw e;
        }
      },
    );
  }

  @override
  Future<Either<NetworkFailure, NetworkSuccess<Map<String, dynamic>>>>
  confirmPayment({
    required String invoiceId,
  }) async {
    final endpoint = '${ApiConstants.baseUrl}/payment/confirm-payment';
    print(
      '[MarketplaceRepositoryImpl] confirming payment for invoiceId: $invoiceId',
    );

    return _apiClient.post<Map<String, dynamic>>(
      endpoint,
      data: {
        'invoiceId': invoiceId,
      },
      fromJsonT: (json) {
        // Since we don't need to grab the response, just return empty map
        if (json == null) return <String, dynamic>{};
        if (json is Map<String, dynamic>) return json;
        try {
          return Map<String, dynamic>.from(json);
        } catch (e) {
          return <String, dynamic>{};
        }
      },
    );
  }
}
