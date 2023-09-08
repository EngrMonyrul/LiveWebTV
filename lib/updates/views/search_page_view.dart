import 'package:flutter/material.dart';
import 'package:livewebtv/updates/views/home_page_view.dart';
import 'package:provider/provider.dart';

import '../../controllers/providers/database_provider.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> filteredList = [];
  int selectedIndex = -1;

  void _filterList(String query) {
    setState(() {
      filteredList = dataList
          .where((item) => item['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> goAnotherPage(String value) async {
    int index = dataList.indexWhere((element) =>
        element['name']?.toString().toLowerCase() == value.toLowerCase());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateHomeScreen(
                  sourceUrl: dataList[index]['link'],
                  wv: dataList[index]['wv'],
                )));
  }

  @override
  void initState() {
    // TODO: implement initState
    final moviesProvider =
        Provider.of<DataBaseProvider>(context, listen: false);
    dataList.addAll(moviesProvider.allItemsList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                cursorOpacityAnimates: true,
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: _filterList,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final itemName =
                    filteredList[index]['name'] as String? ?? 'No Title';
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    title: Text(itemName,
                        style: const TextStyle(color: Colors.white)),
                    onTap: () {
                      goAnotherPage(itemName);
                    },
                    tileColor: selectedIndex == index
                        ? Colors.blue.withOpacity(0.5)
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
