import 'dart:convert';
import 'package:assignment/src/core/connection/network_info.dart';
import 'package:assignment/src/core/errors/failure.dart';
import 'package:assignment/src/core/network/api_base_helper.dart';
import 'package:assignment/src/core/network/url_endpoints.dart';
import 'package:assignment/src/core/params/params.dart';
import 'package:assignment/src/core/services/database/db_provider.dart';
import 'package:assignment/src/modules/random_user/data/datasources/random_user_local_data_source.dart';
import 'package:assignment/src/modules/random_user/data/datasources/random_user_remote_data_source.dart';
import 'package:assignment/src/modules/random_user/data/models/random_user_model.dart';
import 'package:assignment/src/modules/random_user/data/repositories/random_user_repository_impl.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInterceptor extends Mock implements Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 75,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request => $requestPath');
    logger.d('Error: ${err.error}, Message: ${err.message}');
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request => $requestPath');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('StatusCode: ${response.statusCode}, Data: ${response.data}');
    return handler.next(response);
  }
}

const String kApplicationDocumentsPath = 'applicationDocumentsPath';

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }
}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group(
    'RandomUserRepositoryImpl',
    () {
      late Dio dio;
      late DioAdapter dioAdapter;
      late RandomUserRepositoryImpl dataSource;
      late MockInterceptor mockInterceptor;

      group('getRandomUser', () {

        setUp(() async {
          PathProviderPlatform.instance = MockPathProviderPlatform();
          mockInterceptor = MockInterceptor();

          dio = Dio(BaseOptions());
          dio.interceptors.add(mockInterceptor);
          dioAdapter = DioAdapter(
            dio: dio,
            matcher: const FullHttpRequestMatcher(),
          );
          sqfliteFfiInit();
          databaseFactory = databaseFactoryFfi;
          dataSource = RandomUserRepositoryImpl(
            remoteDataSource: RandomUserRemoteDataSourceImpl(
                apiHelper: ApiBaseHelper(dio: dio, isTest: true),),
            localDataSource: RandomUserLocalDataSourceImpl(
                daoSession: await DbProvider.instance.getDaoSession()),
            networkInfo: NetworkInfoImpl(
              DataConnectionChecker(),
            ),
            dio: dio,
          );

        });

        test('when getRandomUser is called should return RandomUserModel',
            () async {
          const userInformation = """
          {
            "results": [
              {
                "gender": "male",
                "name": {
                  "title": "Mr",
                  "first": "Cesário",
                  "last": "Silveira"
                },
                "location": {
                  "street": {
                    "number": 9394,
                    "name": "Rua São Sebastiao "
                  },
                  "city": "Florianópolis",
                  "state": "Santa Catarina",
                  "country": "Brazil",
                  "postcode": 31583,
                  "coordinates": {
                    "latitude": "-73.6736",
                    "longitude": "-117.5633"
                  },
                  "timezone": {
                    "offset": "+7:00",
                    "description": "Bangkok, Hanoi, Jakarta"
                  }
                },
                "email": "cesario.silveira@example.com",
                "login": {
                  "uuid": "3ecfd5d3-bdf2-49e2-9040-8eee4506073a",
                  "username": "crazybear575",
                  "password": "5252",
                  "salt": "SZ7lL6je",
                  "md5": "b94dadffebf9ab4fa85527ba18e1803b",
                  "sha1": "0c1d8b4ceb263635b35fd080213835d81c011351",
                  "sha256": "d6adfe2fe3952a0ee0e94656dfcd2c5467a3043de65427ed623741d3d2f68726"
                },
                "dob": {
                  "date": "1995-07-12T12:54:15.554Z",
                  "age": 28
                },
                "registered": {
                  "date": "2020-01-14T20:07:31.664Z",
                  "age": 4
                },
                "phone": "(23) 0404-2614",
                "cell": "(52) 8854-7795",
                "id": {
                  "name": "CPF",
                  "value": "552.163.445-18"
                },
                "picture": {
                  "large": "https://randomuser.me/api/portraits/men/90.jpg",
                  "medium": "https://randomuser.me/api/portraits/med/men/90.jpg",
                  "thumbnail": "https://randomuser.me/api/portraits/thumb/men/90.jpg"
                },
                "nat": "BR"
              }
            ],
            "info": {
              "seed": "e827543546b5f9ba",
              "results": 1,
              "page": 1,
              "version": "1.4"
            }
          }
          """;
          dioAdapter.onGet(
            UrlEndpoints.randomUsers,
            (server) => server.reply(200, jsonDecode(userInformation)),
          );

          dioAdapter.onGet(
            "https://randomuser.me/api/portraits/men/90.jpg",
            (server) => server.reply(200, {}),
          );


          final response = await dataSource.getRandomUser(
              randomUserParams: RandomUserParams());
          var subject;
          response.fold(
            (newFailure) {
              subject = newFailure;
            },
            (newRandomUser) {
              subject = newRandomUser;
            },
          );
          final expected = isA<RandomUserModel>();

          expect(subject, expected);
        });




        test('when getRandomUser is called and server fails should return Failure',
            () async {
          const userInformation = "{}";

          dioAdapter.onGet(
            UrlEndpoints.randomUsers,
            (server) => server.reply(500, jsonDecode(userInformation)),
          );

          final response = await dataSource.getRandomUser(
              randomUserParams: RandomUserParams());

          var subject;
          response.fold(
            (newFailure) {
              subject = newFailure;
            },
            (newRandomUser) {
              subject = newRandomUser;
            },
          );
          final expected = isA<Failure>();

          expect(subject, expected);
        });
      });
    },
  );
}
