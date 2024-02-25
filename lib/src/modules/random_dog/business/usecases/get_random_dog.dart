import 'package:assignment/src/core/errors/failure.dart';
import 'package:assignment/src/core/params/params.dart';
import 'package:dartz/dartz.dart';
import '../entities/random_dog_entity.dart';
import '../repositories/random_dog_repository.dart';

class GetRandomDog {
  final RandomDogRepository randomDogRepository;

  GetRandomDog({required this.randomDogRepository});

  Future<Either<Failure, RandomDogEntity>> call({
    required RandomDogParams randomDogParams,
  }) async {
    return await randomDogRepository.getRandomDog(randomDogParams: randomDogParams);
  }
}
