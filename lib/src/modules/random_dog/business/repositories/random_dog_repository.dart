import 'package:assignment/src/core/errors/failure.dart';
import 'package:assignment/src/core/params/params.dart';
import 'package:dartz/dartz.dart';
import '../entities/random_dog_entity.dart';


abstract class RandomDogRepository {
  Future<Either<Failure, RandomDogEntity>> getRandomDog({
    required RandomDogParams randomDogParams,
  });
}
