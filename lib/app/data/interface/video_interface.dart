import 'package:test_app/app/data/model/ResponseModel.dart';
abstract class VideoInterface {

  Future<ResponseModel?> getResponse(int count);
}
