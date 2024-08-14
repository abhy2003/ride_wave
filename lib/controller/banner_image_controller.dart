import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_wave/model/banner_image_model.dart';
import 'package:get/get.dart';
class BannerImageController extends GetxController{
  var bannerimages=<BannerImageModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBannerImage();
  }
  void fetchBannerImage()async{
    final snapshot=await FirebaseFirestore.instance
        .collection('banner_image')
        .orderBy('upload_at',descending: true)
        .get();

    final List<BannerImageModel>images=snapshot.docs
        .map((doc) =>BannerImageModel.fromFirestore(doc.id,doc.data()))
        .toList();

    bannerimages.value=images;
  }
}