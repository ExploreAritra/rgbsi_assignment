import 'package:assignment/src/core/connection/network_info.dart';
import 'package:assignment/src/core/errors/exceptions.dart';
import 'package:assignment/src/core/errors/failure.dart';
import 'package:assignment/src/core/params/params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../business/repositories/random_dog_repository.dart';
import '../datasources/random_dog_local_data_source.dart';
import '../datasources/random_dog_remote_data_source.dart';
import '../models/random_dog_model.dart';

class RandomDogRepositoryImpl implements RandomDogRepository {
  final RandomDogRemoteDataSource remoteDataSource;
  final RandomDogLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final Dio dio;

  RandomDogRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.dio,
  });

  @override
  Future<Either<Failure, RandomDogModel>> getRandomDog(
      {required RandomDogParams randomDogParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        RandomDogModel remoteRandomDog =
            await remoteDataSource.getRandomDog(randomDogParams: randomDogParams);
        localDataSource.cacheRandomDog(randomDogToCache: remoteRandomDog, dio: dio);
        return Right(remoteRandomDog);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        RandomDogModel localRandomDog = await localDataSource.getRandomDog();
        return Right(localRandomDog);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
