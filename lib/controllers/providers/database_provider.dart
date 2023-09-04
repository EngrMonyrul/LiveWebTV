import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DataBaseProvider extends ChangeNotifier {
  final CollectionReference _tvChannelsIns = FirebaseFirestore.instance.collection('tv');
  final CollectionReference _alltvIns = FirebaseFirestore.instance.collection('alltv');
  final CollectionReference _banglaIns = FirebaseFirestore.instance.collection('bangaltv');
  final CollectionReference _choosedMovieIns = FirebaseFirestore.instance.collection('choosedmovie');
  final CollectionReference _documentaryIns = FirebaseFirestore.instance.collection('documentarytv');
  final CollectionReference _englishtvIns = FirebaseFirestore.instance.collection('englishtv');
  final CollectionReference _hinditvIns = FirebaseFirestore.instance.collection('hinditv');
  final CollectionReference _livesportstv = FirebaseFirestore.instance.collection('livesportstv');
  final CollectionReference _movies = FirebaseFirestore.instance.collection('movies');
  final CollectionReference _music = FirebaseFirestore.instance.collection('music');
  final CollectionReference _kidstv = FirebaseFirestore.instance.collection('kidstv');
  final CollectionReference _featureIns = FirebaseFirestore.instance.collection('features');

  final List<Map<String, dynamic>> _tvChannelLists = [];
  final List<Map<String, dynamic>> _allTvLists = [];
  final List<Map<String, dynamic>> _bangalTvLists = [];
  final List<Map<String, dynamic>> _choosedMoviesList = [];
  final List<Map<String, dynamic>> _documentaryTvList = [];
  final List<Map<String, dynamic>> _englishTvList = [];
  final List<Map<String, dynamic>> _hindiTvList = [];
  final List<Map<String, dynamic>> _liveSportsTvList = [];
  final List<Map<String, dynamic>> _moviesTvList = [];
  final List<Map<String, dynamic>> _musicTvList = [];
  final List<Map<String, dynamic>> _kidsTvList = [];
  final List<Map<String, dynamic>> _allItemsList = [];
  final List<Map<String, dynamic>> _englishMovie = [];
  final List<Map<String, dynamic>> _othersMovie = [];
  final List<Map<String, dynamic>> _hindiMovie = [];
  final List<Map<String, dynamic>> _appfeatures = [];

  List<Map<String, dynamic>> get tvChannelLists => _tvChannelLists;
  List<Map<String, dynamic>> get allTvLists => _allTvLists;
  List<Map<String, dynamic>> get bangalTvLists => _bangalTvLists;
  List<Map<String, dynamic>> get choosedMoviesList => _choosedMoviesList;
  List<Map<String, dynamic>> get documentaryTvList => _documentaryTvList;
  List<Map<String, dynamic>> get englishTvList => _englishTvList;
  List<Map<String, dynamic>> get hindiTvList => _hindiTvList;
  List<Map<String, dynamic>> get liveSportsTvList => _liveSportsTvList;
  List<Map<String, dynamic>> get moviesTvList => _moviesTvList;
  List<Map<String, dynamic>> get musicTvList => _musicTvList;
  List<Map<String, dynamic>> get kidsTvList => _kidsTvList;
  List<Map<String, dynamic>> get allItemsList => _allItemsList;
  List<Map<String, dynamic>> get englishMovie => _englishMovie;
  List<Map<String, dynamic>> get othersMovie => _othersMovie;
  List<Map<String, dynamic>> get hindiMovie => _hindiMovie;
  List<Map<String, dynamic>> get appfeatures => _appfeatures;

  Future<void> getTvChannelLists() async {
    _tvChannelLists.clear();

    final QuerySnapshot querySnapshot = await _tvChannelsIns.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _tvChannelLists.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getAllChannelLists() async {
    _allTvLists.clear();

    final QuerySnapshot querySnapshot = await _alltvIns.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _allTvLists.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getBanglaTvList() async {
    _bangalTvLists.clear();

    final QuerySnapshot querySnapshot = await _banglaIns.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _bangalTvLists.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getChoosedMoviesList() async {
    _choosedMoviesList.clear();

    final QuerySnapshot querySnapshot = await _choosedMovieIns.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _choosedMoviesList.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getDocumentary() async {
    _documentaryTvList.clear();

    final QuerySnapshot querySnapshot = await _documentaryIns.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _documentaryTvList.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getEnglishTvList() async {
    _englishTvList.clear();

    final QuerySnapshot querySnapshot = await _englishtvIns.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _englishTvList.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getHindiTvList() async {
    _hindiTvList.clear();

    final QuerySnapshot querySnapshot = await _hinditvIns.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _hindiTvList.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getLiveSportsTvList() async {
    _liveSportsTvList.clear();

    final QuerySnapshot querySnapshot = await _livesportstv.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _tvChannelLists.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getMovies() async {
    _moviesTvList.clear();

    final QuerySnapshot querySnapshot = await _movies.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _moviesTvList.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getMusicTvList() async {
    _musicTvList.clear();

    final QuerySnapshot querySnapshot = await _music.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _musicTvList.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getKidsTvList() async {
    _kidsTvList.clear();

    final QuerySnapshot querySnapshot = await _kidstv.get();

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _kidsTvList.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  Future<void> getFeatures() async {
    _appfeatures.clear();

    final QuerySnapshot querySnapshot = await _featureIns.get();

    querySnapshot.docs.forEach(
          (DocumentSnapshot documentSnapshot) {
        final Map<String, dynamic>? tvChannelsData = documentSnapshot.data() as Map<String, dynamic>?;

        if (tvChannelsData != null) {
          _appfeatures.add(tvChannelsData);
        }
      },
    );

    notifyListeners();
  }

  getAllDataList(){
    _allItemsList.addAll(_tvChannelLists);
    _allItemsList.addAll(_allTvLists);
    _allItemsList.addAll(_choosedMoviesList);
    _allItemsList.addAll(_documentaryTvList);
    _allItemsList.addAll(_englishTvList);
    _allItemsList.addAll(_hindiTvList);
    _allItemsList.addAll(_liveSportsTvList);
    _allItemsList.addAll(_moviesTvList);
    _allItemsList.addAll(_musicTvList);
    _allItemsList.addAll(_kidsTvList);
    _allItemsList.addAll(_bangalTvLists);
    notifyListeners();
  }

  seperateMovies() {
    _allItemsList.clear();
    for (int i = 0; i < _choosedMoviesList.length; i++) {
      if(_choosedMoviesList[i]['lan'].contains('english')){
        _englishMovie.add(_choosedMoviesList[i]);
      }
      if(_choosedMoviesList[i]['lan'].contains('hindi')){
        _hindiMovie.add(_choosedMoviesList[i]);
      }
      if(_choosedMoviesList[i]['lan'].contains('others')){
        _othersMovie.add(_choosedMoviesList[i]);
      }
    }

    notifyListeners();
  }
}
