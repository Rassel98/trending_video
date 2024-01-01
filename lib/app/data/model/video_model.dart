List<VideoModel> videoModelFromJson(dynamic str) =>
    List<VideoModel>.from((str as List<dynamic>)
        .map((x) => VideoModel.fromJson(x)));

class VideoModel {
  String? thumbnail;
  int? id;
  String? title;
  DateTime? dateAndTime;
  String? slug;
  DateTime? createdAt;
  String? manifest;
  int? liveStatus;
  dynamic liveManifest;
  bool? isLive;
  String? channelImage;
  String? channelName;
  dynamic channelUsername;
  bool? isVerified;
  String? channelSlug;
  String? channelSubscriber;
  int? channelId;
  String? type;
  String? viewers;
  String? duration;
  String? objectType;

  VideoModel({
    this.thumbnail,
    this.id,
    this.title,
    this.dateAndTime,
    this.slug,
    this.createdAt,
    this.manifest,
    this.liveStatus,
    this.liveManifest,
    this.isLive,
    this.channelImage,
    this.channelName,
    this.channelUsername,
    this.isVerified,
    this.channelSlug,
    this.channelSubscriber,
    this.channelId,
    this.type,
    this.viewers,
    this.duration,
    this.objectType,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        thumbnail: json["thumbnail"],
        id: json["id"],
        title: json["title"],
        dateAndTime: DateTime.parse(json["date_and_time"]),
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        manifest: json["manifest"],
        liveStatus: json["live_status"],
        liveManifest: json["live_manifest"],
        isLive: json["is_live"],
        channelImage: json["channel_image"],
        channelName: json["channel_name"],
        channelUsername: json["channel_username"],
        isVerified: json["is_verified"],
        channelSlug: json["channel_slug"],
        channelSubscriber: json["channel_subscriber"],
        channelId: json["channel_id"],
        type: json["type"],
        viewers: json["viewers"],
        duration: json["duration"],
        objectType: json["object_type"],
      );
}
