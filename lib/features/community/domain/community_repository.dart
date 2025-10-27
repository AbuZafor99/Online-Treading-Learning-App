import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import 'package:flutter_ladydenily/features/community/models/community_item.dart';

abstract class CommunityRepository {
  Future<Either<NetworkFailure, NetworkSuccess<List<CommunityItem>>>>
  fetchCommunityList();
}
