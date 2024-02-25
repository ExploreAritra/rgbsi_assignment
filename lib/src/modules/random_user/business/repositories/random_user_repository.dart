import 'package:assignment/src/core/errors/failure.dart';
import 'package:assignment/src/core/params/params.dart';
import 'package:dartz/dartz.dart';
import '../entities/random_user_entity.dart';


abstract class RandomUserRepository {
  Future<Either<Failure, RandomUserEntity>> getRandomUser({
    required RandomUserParams randomUserParams,
  });
}
