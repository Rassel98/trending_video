import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/data/repository/video_repository.dart';
import 'package:video_player/video_player.dart';
import '../../../data/model/video_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isVideoPlay = false.obs;
  RxBool isRefresh = false.obs;
  int total = 1;
  int count = 0;
  ScrollController scrollController = ScrollController();
  late VideoRepository videoRepository;

  final _allVideosList = <VideoModel>[].obs;
  List<VideoModel> get allVideosList => _allVideosList;

  late VideoPlayerController videoController;
  late Rx<AsyncSnapshot<void>> initializeVideoPlayerFuture;

  @override
  void onInit() async {
    super.onInit();
    videoRepository = VideoRepository();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    await getAllVideos();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    videoController.dispose();
    scrollController.dispose();
  }

  _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      getAllVideos();
    }


  }

  Future<void> getAllVideos() async {
    if (total >= count) {
      isRefresh(true);
      count++;
    } else {
      return;
    }
    try {
      var getResponse = await videoRepository.getResponse(count);
      if (getResponse != null && getResponse.results != []) {
        total = getResponse.total ?? 1;
        _allVideosList.addAll(getResponse.results!);
        log('data length : ${allVideosList.length}');
        isLoading.value = false;
        isRefresh(false);
      } else {
        log('do not coming data');
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
    isRefresh(false);
  }

  void init(String videoUrl) {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl), formatHint: VideoFormat.hls);
    initializeVideoPlayerFuture = const AsyncSnapshot<void>.withData(ConnectionState.done, null).obs;
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    await videoController.initialize();
    initializeVideoPlayerFuture.value = const AsyncSnapshot<void>.withData(ConnectionState.done, null);
  }

  void togglePlayPause() {
    if (videoController.value.isPlaying) {
      isVideoPlay(false);
      videoController.pause();
    } else {
      isVideoPlay(true);
      videoController.play();
    }
  }
}
