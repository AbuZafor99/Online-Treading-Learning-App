import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import '../models/trainer_api_model.dart';

abstract class TrainerRepository {
  Future<Either<NetworkFailure, NetworkSuccess<List<TrainerApiModel>>>>
  fetchTopTrainers();
}
