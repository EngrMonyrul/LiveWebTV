// ignore_for_file: must_be_immutable

import 'dart:ui';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:livewebtv/controllers/providers/database_provider.dart';
import 'package:livewebtv/updates/views/contact_page_view.dart';
import 'package:livewebtv/updates/views/search_page_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class UpdateHomeScreen extends StatefulWidget {
  String? sourceUrl;
  bool? wv = false;
  UpdateHomeScreen({Key? key, this.sourceUrl, this.wv}) : super(key: key);

  @override
  State<UpdateHomeScreen> createState() => _UpdateHomeScreenState();
}

class _UpdateHomeScreenState extends State<UpdateHomeScreen> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool showVideoList = false;
  bool showVolume = false;
  bool showInfo = false;
  double progressVolume = 0.0;
  late String sourceUrl;
  late bool liveVideo;

  setSourceUrl() {
    if (widget.sourceUrl == null) {
      final moviesProvider =
          Provider.of<DataBaseProvider>(context, listen: false);
      setState(() {
        sourceUrl = moviesProvider.othersMovie[0]['link'];
        liveVideo = moviesProvider.othersMovie[0]['wv'];
      });
    } else {
      setState(() {
        sourceUrl = widget.sourceUrl!;
        liveVideo = widget.wv?? false;
      });
    }

    initializeVideoPlayerController();
  }

  setClickedSourceUrl(url, wv) {
    setState(() {
      sourceUrl = url;
      liveVideo = wv;
    });

    initializeVideoPlayerController();
  }

  initializeVideoPlayerController() {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        sourceUrl,
      ),
    )..initialize().then((value) {
        setState(() {});
      });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      autoInitialize: false,
      allowFullScreen: true,
      allowMuting: true,
      isLive: liveVideo,
      allowedScreenSleep: true,
      aspectRatio: 16 / 9,
      zoomAndPan: true,
      showControls: true,
      looping: true,
      placeholder: Center(
          child: Lottie.asset('assets/animation_lm33g5pe.json',
              height: 300, width: 300)),
    );
  }

  volumeController(value) {
    setState(() {
      progressVolume = value;
      videoPlayerController.setVolume(progressVolume);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setSourceUrl();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sourceProvider = Provider.of<DataBaseProvider>(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Chewie(
              controller: chewieController,
            ),
          ),
          Visibility(
            visible: showVideoList,
            child: Positioned(
              bottom: screenSize.height * 0.05,
              child: SizedBox(
                height: screenSize.height * 0.95,
                width: screenSize.width,
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: SizedBox(
                        height: screenSize.height * 0.95,
                        width: screenSize.width,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: screenSize.height * 0.05,
                          width: screenSize.width,
                          child: const Text(
                            'Hindi Movies',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.14,
                          width: screenSize.width * 0.125,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sourceProvider.hindiMovie.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setClickedSourceUrl(sourceProvider.hindiMovie[index]['link'], sourceProvider.hindiMovie[index]['wv']);
                                  setState(() {
                                    showVideoList = false;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: screenSize.height * 0.14,
                                  width: screenSize.width,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl: sourceProvider.hindiMovie[index]
                                          ['image'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: screenSize.height * 0.05,
                          width: screenSize.width,
                          child: const Text(
                            'English Movies',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.14,
                          width: screenSize.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sourceProvider.englishMovie.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setClickedSourceUrl(sourceProvider.englishMovie[index]['link'], sourceProvider.englishMovie[index]['wv']);
                                  setState(() {
                                    showVideoList = false;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: screenSize.height * 0.14,
                                  width: screenSize.width,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl: sourceProvider
                                          .englishMovie[index]['image'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: screenSize.height * 0.05,
                          width: screenSize.width,
                          child: const Text(
                            'Other Movies',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.14,
                          width: screenSize.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sourceProvider.othersMovie.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setClickedSourceUrl(sourceProvider.othersMovie[index]['link'], sourceProvider.othersMovie[index]['wv']);
                                  setState(() {
                                    showVideoList = false;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: screenSize.height * 0.14,
                                  width: screenSize.width * 0.125,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl: sourceProvider
                                          .othersMovie[index]['image'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: screenSize.height * 0.05,
                          width: screenSize.width,
                          child: const Text(
                            'All TV Channel',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.14,
                          width: screenSize.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sourceProvider.allTvLists.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setClickedSourceUrl(sourceProvider.allTvLists[index]['link'], sourceProvider.allTvLists[index]['wv']);
                                  setState(() {
                                    showVideoList = false;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: screenSize.height * 0.14,
                                  width: screenSize.width * 0.125,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl: sourceProvider
                                          .allTvLists[index]['image'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchPageView()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: screenSize.height * 0.05,
                            width: screenSize.width * 0.1,
                            margin: EdgeInsets.only(top: screenSize.height*0.01, bottom: screenSize.height*0.01),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.white),
                            ),
                            child: const Text(
                              'Search Item',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: screenSize.height * 0.05,
                          width: screenSize.width,
                          child: const Text(
                            'Live Web TV - Copyright @Monirul Islam',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: showVolume,
            child: Positioned(
                bottom: screenSize.height * 0.05,
                child: Slider(
                  value: progressVolume,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (value) {
                    volumeController(value);
                  },
                )),
          ),
          Positioned(
            bottom: screenSize.height * 0.027,
            child: GestureDetector(
              onTap: () {
                setState(
                  () {
                    showVideoList = !showVideoList;
                  },
                );
              },
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showVolume = !showVolume;
                      });
                    },
                    child: Icon(
                      CupertinoIcons.volume_up,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  Container(
                    height: screenSize.height * 0.034,
                    width: screenSize.width * 0.03,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showInfo = !showInfo;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ContactPageView()));
                      });
                    },
                    child: Icon(
                      CupertinoIcons.info_circle_fill,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
