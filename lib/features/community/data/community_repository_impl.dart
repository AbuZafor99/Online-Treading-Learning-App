import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';
import 'package:flutter_ladydenily/core/network/constants/api_constants.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import 'package:flutter_ladydenily/features/community/domain/community_repository.dart';
import 'package:flutter_ladydenily/features/community/models/community_item.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final ApiClient _apiClient;

  CommunityRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<Either<NetworkFailure, NetworkSuccess<List<CommunityItem>>>>
  fetchCommunityList() async {
    print('[CommunityRepositoryImpl] fetching community chat list');

    return _apiClient.get<List<CommunityItem>>(
      '${ApiConstants.baseUrl}/chat/list',
      fromJsonT: (json) {
        print(
          '[CommunityRepositoryImpl] fromJsonT received: ${json.runtimeType}',
        );

        if (json == null) {
          print('[CommunityRepositoryImpl] JSON is null, returning empty list');
          return <CommunityItem>[];
        }

        // json should be a List directly
        if (json is List) {
          print('[CommunityRepositoryImpl] Parsing ${json.length} chat items');
          return json
              .map((e) => CommunityItem.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        print(
          '[CommunityRepositoryImpl] Unexpected JSON structure, returning empty list',
        );
        return <CommunityItem>[];
      },
    );
  }
}
