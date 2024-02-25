import 'package:assignment/src/core/errors/failure.dart';
import 'package:assignment/src/core/params/params.dart';
import 'package:dartz/dartz.dart';
import '../entities/random_user_entity.dart';
import '../repositories/random_user_repository.dart';

class GetRandomUser {
  final RandomUserRepository randomUserRepository;

  GetRandomUser({required this.randomUserRepository});

  Future<Either<Failure, RandomUserEntity>> call({
    required RandomUserParams randomUserParams,
  }) async {
    return await randomUserRepository.getRandomUser(randomUserParams: randomUserParams);
  }
}
