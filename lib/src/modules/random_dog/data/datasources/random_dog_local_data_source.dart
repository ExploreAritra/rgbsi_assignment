
import 'package:assignment/src/core/errors/exceptions.dart';
import 'package:assignment/src/core/services/database/dao_session.dart';
import 'package:assignment/src/core/utils/downloader.dart';
import 'package:dio/dio.dart';
import '../models/random_dog_model.dart';

abstract class RandomDogLocalDataSource {
  Future<void> cacheRandomDog({required RandomDogModel? randomDogToCache, required Dio dio});
  Future<RandomDogModel> getRandomDog();
}


class RandomDogLocalDataSourceImpl implements RandomDogLocalDataSource {
  final DaoSession daoSession;

  RandomDogLocalDataSourceImpl({required this.daoSession});

  @override
  Future<RandomDogModel> getRandomDog() async {
    List<RandomDogModel> randomDog;
    try{
      randomDog = await daoSession.randomDogCacheDao.getRandomDog();
      return randomDog.first;
    } catch (e) {
      throw CacheException();
    }
  }


  @override
  Future<void> cacheRandomDog({required RandomDogModel? randomDogToCache, required Dio dio}) async {
    String? path;
    if(randomDogToCache?.message != null) {
      path = await ImageDownloader.downloadImage(randomDogToCache!.message!, dio);
      randomDogToCache = randomDogToCache.copyWith(path: path);
    }
    if (randomDogToCache != null) {
      await daoSession.randomDogCacheDao.insert(randomDogToCache);
    } else {
      throw CacheException();
    }
  }
}
