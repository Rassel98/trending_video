import 'package:test_app/app/data/interface/video_interface.dart';
import 'package:test_app/app/data/model/ResponseModel.dart';
import '../db/api/api_servise.dart';

class VideoRepository extends VideoInterface {
  ApiService apiService = ApiService.instance;

  @override
  Future<ResponseModel?> getResponse(int count) => apiService.getResponse(count);
}
