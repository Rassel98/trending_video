import 'dart:convert';
import 'dart:developer';
import 'package:test_app/app/data/model/ResponseModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._init();
  static final ApiService instance = ApiService._init();
  final client = http.Client();

  Future<ResponseModel?> getResponse(int count) async {
    try {
      String url = "https://test-ximit.mahfil.net/api/trending-video/$count?page=1";
      var response = await client.get(Uri.parse(url),
          headers: {'content-type': 'application/json',
        'Accept': 'application/json'});
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return  ResponseModel.fromJson(data);
      }
    } catch (exception) {
      log('$exception');
    }
    return null;
  }

}
