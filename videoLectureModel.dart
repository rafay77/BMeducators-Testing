import 'package:flutter/cupertino.dart';

class videoLectureModel {


  late String caption;
  late String url;
  late String thumbnail;


  videoLectureModel({
    required this.caption,
    required this.url,
    required this.thumbnail,

  });

  Map<String, dynamic> toMap() {
    return {
      "caption": caption,
      "url": url,
      "thumbnail": thumbnail,

    };
  }

  Map<String, dynamic> toJson() => {
    'caption': caption,
    'thumbnail': thumbnail,
    'url': url,

  };

  videoLectureModel.fromSnapshot(snapshot):
        caption = snapshot.data()['caption'],
        thumbnail = snapshot.data()['thumbnail'],
        url = snapshot.data()['url'];
}
