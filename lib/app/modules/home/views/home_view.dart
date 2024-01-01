import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_app/app/modules/home/views/video_details_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Obx(() => controller.isRefresh.value && !controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.redAccent,)
            : const SizedBox()),
        body: SafeArea(
      child: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Trending videos",
                    style: TextStyle(fontWeight: FontWeight.w700, fontFamily: "HindSiliguri", fontSize: 20, color: Color(0xff1A202C)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.allVideosList.length,
                    controller: controller.scrollController,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final model = controller.allVideosList.elementAt(index);
                        return GestureDetector(
                          onTap: () => Get.to(() => VideoDetailsView(videoModel: model), transition: Transition.leftToRight),
                          child: Container(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: model.thumbnail.toString(),
                                      height: Get.height * 0.196850,
                                      width: double.maxFinite,
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => const Icon(Icons.image),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                    Positioned(
                                        bottom: 20,
                                        right: 10,
                                        child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(
                                                model.duration ?? "",
                                                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
                                              ),
                                            )))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: "${model.channelImage}",
                                      height: 50,
                                      width: 50,
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(50)),
                                      ),
                                      placeholder: (context, url) => const Icon(Icons.image),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        model.title.toString(),
                                        maxLines: 2,
                                        softWrap: true,
                                        style: const TextStyle(
                                            color: Color(0xff4A5568), fontFamily: "HindSiliguri", fontSize: 16, fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    IconButton(onPressed: () => print,
                                        icon: const Icon(Icons.more_vert_sharp,color: Color(0xffCBD5E0),))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 58),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${model.viewers ?? ""} views  . ',
                                        softWrap: true,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Color(0xff4A5568), fontFamily: "HindSiliguri", fontSize: 14, fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        DateFormat("yMMMMd").format(model.dateAndTime!.toLocal()),
                                        softWrap: true,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Color(0xff4A5568), fontFamily: "HindSiliguri", fontSize: 14, fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      ),
    ));
  }
}
