
import 'package:assignment/src/core/errors/exceptions.dart';
import 'package:assignment/src/core/services/database/dao_session.dart';
import 'package:assignment/src/core/utils/downloader.dart';
import 'package:dio/dio.dart';
import '../models/random_user_model.dart';

abstract class RandomUserLocalDataSource {
  Future<void> cacheRandomUser({required RandomUserModel? randomUserToCache, required Dio dio});
  Future<RandomUserModel> getRandomUser();
}


class RandomUserLocalDataSourceImpl implements RandomUserLocalDataSource {
  final DaoSession daoSession;

  RandomUserLocalDataSourceImpl({required this.daoSession});

  @override
  Future<RandomUserModel> getRandomUser() async {
    RandomUserModel? randomUser;
    try{
      randomUser = await daoSession.randomUserCacheDao.getRandomUser();
      return randomUser ?? RandomUserModel();
    } catch (e) {
      throw CacheException();
    }
  }


  @override
  Future<void> cacheRandomUser({required RandomUserModel? randomUserToCache, required Dio dio}) async {
    String? path;
    if(randomUserToCache?.results != null && randomUserToCache?.results?.first.picture?.large != null) {
      path = await ImageDownloader.downloadImage(randomUserToCache!.results!.first.picture!.large!, dio);
      randomUserToCache = randomUserToCache.copyWith(results: [randomUserToCache.results!.first.copyWith(picture: randomUserToCache.results!.first.picture!.copyWith(path: path))]);
    }
    if (randomUserToCache != null) {
      await daoSession.randomUserCacheDao.insert(randomUserToCache);
    } else {
      throw CacheException();
    }
  }
}
