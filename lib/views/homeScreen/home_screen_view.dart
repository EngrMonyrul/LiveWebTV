import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:livewebtv/controllers/providers/database_provider.dart';
import 'package:livewebtv/controllers/providers/theme_provider.dart';
import 'package:livewebtv/utils/consts/consts.dart';
import 'package:provider/provider.dart';
import '../../utils/functions/allChannelsList.dart';
import '../../utils/functions/popup_menu_button_functions.dart';
import '../videoPlayerScreen/video_player_view.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  bool showSearchButton = false;
  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> filteredList = [];
  int selectedIndex = -1;
  PageController controller = PageController(viewportFraction: 0.12);
  String selectedAction = 'All Channel';
  bool isSelected = false;
  int currentIndex = 0;
  List<dynamic> allContents = [];

  setAllContents() {
    final dataPro = Provider.of<DataBaseProvider>(context, listen: false);
    setState(() {
      allContents = [
        dataPro.allTvLists,
        dataPro.liveSportsTvList,
        dataPro.tvChannelLists,
        dataPro.choosedMoviesList,
        dataPro.moviesTvList,
        dataPro.musicTvList,
        dataPro.bangalTvLists,
        dataPro.englishTvList,
        dataPro.hindiTvList,
        dataPro.kidsTvList,
        dataPro.documentaryTvList,
      ];
    });
  }

  setPageAction(action) {
    setState(() {
      selectedAction = action;
    });

    controller.animateToPage(TvCategory.indexOf(action),
        curve: Curves.linear, duration: const Duration(milliseconds: 100));
  }

  setPageController() {
    controller.addListener(() {
      int currentIndex = controller.page?.round() ?? 0;
      setState(() {
        selectedAction = TvCategory[currentIndex];
        print(selectedAction);
      });
    });
  }

  void _filterList(String query) {
    setState(() {
      filteredList =
          dataList.where((item) => item['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  Future<void> goAnotherPage(String value) async {
    int index = dataList.indexWhere((element) => element['name']?.toString().toLowerCase() == value.toLowerCase());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoPlayerView(
                  videoLink: dataList[index]['link'],
                  videoName: dataList[index]['name'],
                  webView: dataList[index]['wv'],
                )));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final moviesProvider = Provider.of<DataBaseProvider>(context, listen: false);
    dataList.addAll(moviesProvider.allItemsList);
    setAllContents();
    setPageController();
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
                if (!showSearchButton) SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                if (!showSearchButton)
                  const Text(
                    'Watch All The Shows Free',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                if (!showSearchButton) SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                if (!showSearchButton) buildPreviewDesign(context, dataPro),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  width: MediaQuery.sizeOf(context).width,
                  margin: const EdgeInsets.only(top: 100),
                  child: PageView.builder(
                    controller: controller,
                    itemCount: TvCategory.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Buttons(
                          title: TvCategory[index],
                          isSelected: selectedAction == TvCategory[index],
                          onTap: () {
                            setPageAction(TvCategory[index]);
                          });
                    },
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7, mainAxisSpacing: 2, crossAxisSpacing: 2),
                    itemCount: allContents[currentIndex].length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoPlayerView(
                                        videoLink: allContents[currentIndex][index]['link'],
                                        videoName: allContents[currentIndex][index]['name'],
                                        webView: allContents[currentIndex][index]['wv'],
                                      )));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: allContents[currentIndex][index]['image'],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Text('Copyright @LiveWebTV', style: TextStyle(color: Colors.white, fontSize: 20)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05)
              ],
            ),
          ),
        ),
      );
    });
  }

  Stack buildPreviewDesign(BuildContext context, DataBaseProvider dataPro) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.95,
        ),
        Positioned(
          bottom: -60,
          left: 120,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 20,
                  blurRadius: 80,
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(imageUrl: dataPro.appfeatures[0]['link1'], fit: BoxFit.fill)),
          ),
        ),
        Positioned(
          bottom: -60,
          right: 120,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 20,
                  blurRadius: 80,
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(imageUrl: dataPro.appfeatures[0]['link2'], fit: BoxFit.fill)),
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration:
                BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(10)), boxShadow: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 20,
                blurRadius: 80,
              )
            ]),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(imageUrl: dataPro.appfeatures[0]['link3'], fit: BoxFit.fill)),
          ),
        ),
      ],
    );
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

class Buttons extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const Buttons({super.key, required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.amber.shade800 : Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.amber.shade800 : Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
