import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_app/app/data/model/video_model.dart';
import 'package:test_app/app/modules/home/views/widgets/custom_button.dart';
import 'package:video_player/video_player.dart';
import '../controllers/home_controller.dart';

class VideoDetailsView extends StatelessWidget {
  final VideoModel videoModel;
  final HomeController _controller = Get.put(HomeController());
  VideoDetailsView({super.key, required this.videoModel}) {
    _controller.init(videoModel.manifest.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (_controller.initializeVideoPlayerFuture.value.connectionState == ConnectionState.done)
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.videoController.value.aspectRatio,
                          child: VideoPlayer(_controller.videoController),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: IconButton(
                              onPressed: () {
                                _controller.togglePlayPause();
                              },
                              icon: Obx(
                                () => _controller.isVideoPlay.value
                                    ? AnimatedOpacity(
                                        duration: const Duration(seconds: 10),
                                        curve: Curves.easeIn,
                                        opacity: _controller.isVideoPlay.value ? 0.0 : 1.0,
                                        child: const Icon(
                                          Icons.pause,
                                          size: 60,
                                          color: Colors.white,
                                        ))
                                    : const Icon(
                                        Icons.play_arrow,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                              ),
                            )),
                        Positioned(
                            left: 10,
                            top: 10,
                            child: IconButton(
                              onPressed: () {
                                _controller.isVideoPlay(false);
                                _controller.videoController.dispose();
                                Get.back();
                              },
                              alignment: Alignment.center,
                              style: IconButton.styleFrom(
                                  backgroundColor: const Color(0xff718096).withOpacity(0.4),
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  videoModel.title.toString(),
                  maxLines: 2,
                  style: const TextStyle(color: Color(0xff1A202C), fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${videoModel.viewers ?? ""} views . ',
                      style: const TextStyle(color: Color(0xff72777B), fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      DateFormat("yMMMMd").format(videoModel.dateAndTime!.toLocal()),
                      style: const TextStyle(color: Color(0xff72777B), fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(height: 60, weight: 125, title: "MASH ALLAH (12k)", iconData: "assets/svg/heart.svg", onPressed: () => print),
                    CustomButton(height: 60, weight: 80, title: "LIKE (12k)", iconData: "assets/svg/like.svg", onPressed: () => print),
                    CustomButton(height: 60, weight: 80, title: "SHARE", iconData: "assets/svg/share.svg", onPressed: () => print),
                    CustomButton(height: 60, weight: 80, title: "REPORT", iconData: "assets/svg/flag.svg", onPressed: () => print),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: CachedNetworkImage(
                  imageUrl: videoModel.thumbnail.toString(),
                  height: 40,
                  width: 40,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  placeholder: (context, url) => const Icon(Icons.image),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                title: Text(
                  videoModel.channelName.toString(),
                  style: const TextStyle(color: Color(0xff1A202C), fontSize: 14, fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  videoModel.channelSubscriber.toString(),
                  style: const TextStyle(color: Color(0xff718096), fontSize: 11, fontWeight: FontWeight.w700),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () => print,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3898FC),
                      foregroundColor: const Color(0xff3898FC),
                      //padding: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          "Subscribe",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(color: Color(0xffE2E8F0), thickness: 1),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Comments   7.5K"),
                    Column(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/arror.svg",
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffE2E8F0), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _controller.commentController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    border: const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Add Comment",
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        "assets/svg/sent.svg",
                      ),
                      onPressed: () {},
                    ),
                    hintStyle: const TextStyle(color: Color(0xffCBD5E0), fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                        imageUrl: "dg",
                        height: 40,
                        width: 40,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        placeholder: (context, url) => const Icon(Icons.image),
                        errorWidget: (context, url, error) =>Image.asset(
                          "assets/images/ellipse.png",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Fahmida khanom",
                                  style: TextStyle(color: Color(0xff718096), fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "2 days ago",
                                  style: TextStyle(color: Color(0xff718096), fontSize: 10, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Text(
                              "হুজুরের বক্তব্য গুলো ইংরেজি তে অনুবাদ করে সারা পৃথিবীর মানুষদের কে শুনিয়ে দিতে হবে। কথা গুলো খুব দামি",
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(color: Color(0xff4A5568), fontFamily: "HindSiliguri", fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
