import 'package:assignment/src/core/constants/route_constants.dart';
import 'package:assignment/src/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/services/database/dao_session.dart';
import 'core/services/database/db_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RGBSI Assignment', //set from translations
      debugShowCheckedModeBanner: false,
      getPages: Routes.get(),
      initialBinding: BindingsBuilder(() async {
        await Get.putAsync<DaoSession>(() async => await DbProvider.instance.getDaoSession()) ;
      }),
      initialRoute: RouteConstants.mainScreen,

    );
  }
}
