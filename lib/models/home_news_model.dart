class HomeNewsModel {
  int? id;
  String? newsId;
  String? title;
  String? thumbnail;
  String? thumbnail2X;
  String? thumbnailY;
  String? thumbnailY2X;
  String? abstract;
  String? publishTime;
  int? atype;
  int? imgNum;
  int? duration;
  int? likeNum;
  String? source;
  String? editor;
  String? origin;
  String? lockAt;
  int? seq;
  int? publishingPlatform;
  int? videoOrientation;
  int? videoWidth;
  int? videoHeight;

  HomeNewsModel(
      {this.id,
      this.newsId,
      this.title,
      this.thumbnail,
      this.thumbnail2X,
      this.thumbnailY,
      this.thumbnailY2X,
      this.abstract,
      this.publishTime,
      this.atype,
      this.imgNum,
      this.duration,
      this.likeNum,
      this.source,
      this.editor,
      this.origin,
      this.lockAt,
      this.seq,
      this.publishingPlatform,
      this.videoOrientation,
      this.videoWidth,
      this.videoHeight});

  HomeNewsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    newsId = json["news_id"];
    title = json["title"];
    thumbnail = json["thumbnail"];
    thumbnail2X = json["thumbnail_2x"];
    thumbnailY = json["thumbnail_y"];
    thumbnailY2X = json["thumbnail_y_2x"];
    abstract = json["abstract"];
    publishTime = json["publish_time"];
    atype = json["atype"];
    imgNum = json["img_num"];
    duration = json["duration"];
    likeNum = json["like_num"];
    source = json["source"];
    editor = json["editor"];
    origin = json["origin"];
    lockAt = json["lock_at"];
    seq = json["seq"];
    publishingPlatform = json["publishing_platform"];
    videoOrientation = json["video_orientation"];
    videoWidth = json["video_width"];
    videoHeight = json["video_height"];
  }
}
