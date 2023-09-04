import 'dart:async';
import 'package:flutter/material.dart';
import 'package:livewebtv/controllers/providers/database_provider.dart';
import 'package:provider/provider.dart';

import '../../views/homeScreen/home_screen_view.dart';

Future<void> loadingDataFromDatabase(context) async {
  final databaseProvider = Provider.of<DataBaseProvider>(context, listen: false);
  await databaseProvider.getTvChannelLists();
  await databaseProvider.getAllChannelLists();
  await databaseProvider.getBanglaTvList();
  await databaseProvider.getChoosedMoviesList();
  await databaseProvider.getDocumentary();
  await databaseProvider.getEnglishTvList();
  await databaseProvider.getHindiTvList();
  await databaseProvider.getKidsTvList();
  await databaseProvider.getLiveSportsTvList();
  await databaseProvider.getMovies();
  await databaseProvider.getMusicTvList();
  await databaseProvider.getAllDataList();
  await databaseProvider.seperateMovies();
  await databaseProvider.getFeatures();

  Future.delayed(const Duration(seconds: 3), () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreenView()));
  });
}