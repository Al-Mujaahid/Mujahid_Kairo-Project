import 'package:dio/dio.dart';
import 'package:dio/src/adapters/io_adapter.dart';

class ApiHelper {
  static Future makeGetRequest({url}) async {
    print('Url: $url');
    var dio = Dio();
    return dio.get(url).then((value) => value.data);
  }

  static Future makePostRequest({url, data, bool useFormData}) async {
    print('Url: $url');
    var dio = Dio();
    return dio
        .post(url, data: useFormData ? FormData.fromMap(data) : data)
        .then((value) => value.data);
  }
}
