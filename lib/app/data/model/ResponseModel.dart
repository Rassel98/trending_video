
import 'video_model.dart';
class ResponseModel {
  int? total;
  int? page;
  int? pageSize;
  List<VideoModel>? results;

  ResponseModel({
    this.total,
    this.page,
    this.pageSize,
    this.results,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        total: json["total"],
        page: json["page"],
        pageSize: json["page_size"],
        results: json["results"] == null || json["results"] == []
            ? []
            : List<VideoModel>.from(json["results"].map((x) => VideoModel.fromJson(x))),
      );
}
