import 'dart:async';
import 'package:flutter/material.dart';
import 'package:livewebtv/controllers/providers/database_provider.dart';
import 'package:livewebtv/updates/views/home_page_view.dart';
import 'package:provider/provider.dart';

Future<void> loadingDataFromDatabase(context) async {
  final databaseProvider = Provider.of<DataBaseProvider>(context, listen: false);
  await databaseProvider.getAllChannelLists();
  await databaseProvider.getChoosedMoviesList();
  await databaseProvider.getAllDataList();
  await databaseProvider.seperateMovies();

  Future.delayed(const Duration(seconds: 3), () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateHomeScreen()));
  });
}
