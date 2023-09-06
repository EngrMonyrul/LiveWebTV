import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:livewebtv/controllers/providers/database_provider.dart';
import 'package:livewebtv/controllers/providers/theme_provider.dart';
import 'package:livewebtv/utils/consts/consts.dart';
import 'package:livewebtv/views/homeScreen/home_screen_view.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/functions/allChannelsList.dart';
import '../../utils/functions/popup_menu_button_functions.dart';
import '../videoPlayerScreen/video_player_view.dart';

class VideoPlayerView extends StatefulWidget {
  String videoLink;
  String videoName;
  bool webView;
  VideoPlayerView({Key? key, required this.videoLink, required this.videoName, required this.webView})
      : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  bool showSearchButton = false;
  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> filteredList = [];
  int selectedIndex = -1;
  bool videoStart = false;
  int vProgress = 0;
  late WebViewController controller;
  late VideoPlayerController videoPlayerController;

  setWebViewController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.videoLink));
  }

  setVideoPlayerController(){
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoLink));
  }

  void _filterList(String query) {
    setState(() {
      filteredList =
          dataList.where((item) => item['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  Future<void> goAnotherPage(String value) async {
    int index = dataList.indexWhere((element) => element['name']?.toString().toLowerCase() == value.toLowerCase());
    widget.videoName = dataList[index]['name'];
    widget.videoLink = dataList[index]['link'];
    setState(() {
      showSearchButton = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setVideoPlayerController();
    if(Platform.isAndroid || Platform.isIOS){
      setWebViewController();
    }
    WebViewPlatform.instance;
    final moviesProvider = Provider.of<DataBaseProvider>(context, listen: false);
    dataList.addAll(moviesProvider.allItemsList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataPro = Provider.of<DataBaseProvider>(context, listen: false);
    return Consumer<ThemeProvider>(builder: (context, property, child) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: colorsList[property.colorIndex],
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        buildTvIcon(context),
                        SizedBox(width: 20),
                        buildAppTitle(),
                      ],
                    ),
                    Row(
                      children: [
                        if (!showSearchButton) buildHomeButton(context),
                        if (!showSearchButton) buildAboutButton(context),
                        if (!showSearchButton) buildContactButton(context),
                        if (!showSearchButton) buildSearchButton(context),
                        if (showSearchButton) buildSearchSysetm(context),
                        buildPopupMenuButton(context, property),
                      ],
                    ),
                  ],
                ),
                if (showSearchButton) buildSearchItems(),
                if (!showSearchButton)
                  Text(
                    widget.videoName,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                if (!showSearchButton && widget.webView)
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.9,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                spreadRadius: 10,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          child:
                              Platform.isAndroid || Platform.isIOS ? WebViewWidget(controller: controller) : VideoPlayer(videoPlayerController),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Text buildAppTitle() => Text('LiveWebTV', style: TextStyle(fontSize: 20, color: Colors.white));

  Icon buildTvIcon(BuildContext context) {
    return Icon(CupertinoIcons.tv_fill, color: Colors.white, size: MediaQuery.sizeOf(context).height * 0.05);
  }

  GestureDetector buildSearchButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showSearchButton = true;
        });
      },
      child: Icon(CupertinoIcons.search_circle, color: Colors.white, size: MediaQuery.sizeOf(context).height * 0.05),
    );
  }

  GestureDetector buildContactButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: const Text(
          'Contact',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }

  GestureDetector buildAboutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: const Text(
          'About',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }

  GestureDetector buildHomeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreenView()));
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: const Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }

  Widget buildSearchItems() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final itemName = filteredList[index]['name'] as String? ?? 'No Title';
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                top: 2,
                left: MediaQuery.of(context).size.width * 0.233,
                right: MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: ListTile(
              title: Text(itemName, style: TextStyle(color: Colors.white)),
              onTap: () {
                goAnotherPage(itemName);
              },
              tileColor: selectedIndex == index ? Colors.blue.withOpacity(0.5) : null,
            ),
          );
        },
      ),
    );
  }

  Container buildSearchSysetm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TextField(
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        onChanged: _filterList,
        mouseCursor: MaterialStateMouseCursor.textable,
        autofocus: false,
        cursorOpacityAnimates: true,
        cursorColor: Colors.white,
        cursorHeight: 20,
        cursorRadius: const Radius.circular(10),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          hintText: 'Search by Channel name, Movie name....',
          hintStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          prefixIcon: Icon(CupertinoIcons.search, color: Colors.white, size: MediaQuery.of(context).size.height * 0.03),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                showSearchButton = false;
              });
            },
            child:
                Icon(CupertinoIcons.xmark_seal, color: Colors.white, size: MediaQuery.of(context).size.height * 0.03),
          ),
        ),
      ),
    );
  }
}
