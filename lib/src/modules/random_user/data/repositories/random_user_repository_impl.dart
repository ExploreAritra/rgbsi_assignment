import 'package:assignment/src/core/connection/network_info.dart';
import 'package:assignment/src/core/errors/exceptions.dart';
import 'package:assignment/src/core/errors/failure.dart';
import 'package:assignment/src/core/params/params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../business/repositories/random_user_repository.dart';
import '../datasources/random_user_local_data_source.dart';
import '../datasources/random_user_remote_data_source.dart';
import '../models/random_user_model.dart';

class RandomUserRepositoryImpl implements RandomUserRepository {
  final RandomUserRemoteDataSource remoteDataSource;
  final RandomUserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final Dio dio;

  RandomUserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.dio,
  });

  @override
  Future<Either<Failure, RandomUserModel>> getRandomUser(
      {required RandomUserParams randomUserParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        RandomUserModel remoteRandomUser =
            await remoteDataSource.getRandomUser(randomUserParams: randomUserParams);
        localDataSource.cacheRandomUser(randomUserToCache: remoteRandomUser, dio: dio);
        return Right(remoteRandomUser);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        RandomUserModel localRandomUser = await localDataSource.getRandomUser();
        return Right(localRandomUser);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
