import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class ImageDownloader {

  static Future<String> downloadImage(String url, Dio dio) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = url.split("/").last;
    await dio.download(url, '${appDir.path}/$fileName');

    return '${appDir.path}/$fileName';
  }

}