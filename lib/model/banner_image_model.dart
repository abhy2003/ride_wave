import 'package:cloud_firestore/cloud_firestore.dart';

class BannerImageModel {
  final String banner_id;
  final String image_url;
  final DateTime updated_at;

  BannerImageModel(this.banner_id, this.image_url, this.updated_at);

  factory BannerImageModel.fromFirestore(
      String banner_id, Map<String, dynamic> data) {
    return BannerImageModel(banner_id, data['image_url'] as String,
        (data['uploaded_at'] as Timestamp).toDate());
  }
}
