import 'package:assignment/src/core/errors/exceptions.dart';
import 'package:assignment/src/core/network/api_base_helper.dart';
import 'package:assignment/src/core/network/url_endpoints.dart';
import 'package:assignment/src/core/params/params.dart';
import '../models/random_user_model.dart';

abstract class RandomUserRemoteDataSource {
  Future<RandomUserModel> getRandomUser({required RandomUserParams randomUserParams});
}

class RandomUserRemoteDataSourceImpl implements RandomUserRemoteDataSource {
  final ApiBaseHelper apiHelper;

  RandomUserRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<RandomUserModel> getRandomUser({required RandomUserParams randomUserParams}) async {
    final response = await apiHelper.getRequest(
      UrlEndpoints.randomUsers,
      queryParameters: {
        'api_key': 'if needed',
      },
    );

    if (response?.statusCode == 200) {
      return RandomUserModel.fromJson(response?.data);
    } else {
      throw ServerException();
    }
  }
}
