import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DataBaseProvider extends ChangeNotifier {
  final CollectionReference _alltvIns = FirebaseFirestore.instance.collection('alltv');
  final CollectionReference _choosedMovieIns = FirebaseFirestore.instance.collection('choosedmovie');

  final List<Map<String, dynamic>> _allTvLists = [];
  final List<Map<String, dynamic>> _choosedMoviesList = [];
  final List<Map<String, dynamic>> _allItemsList = [];
  final List<Map<String, dynamic>> _englishMovie = [];
  final List<Map<String, dynamic>> _hindiMovie = [];
  final List<Map<String, dynamic>> _othersMovie = [];

  List<Map<String, dynamic>> get allTvLists => _allTvLists;
  List<Map<String, dynamic>> get choosedMoviesList => _choosedMoviesList;
  List<Map<String, dynamic>> get allItemsList => _allItemsList;
  List<Map<String, dynamic>> get englishMovie => _englishMovie;
  List<Map<String, dynamic>> get hindiMovie => _hindiMovie;
  List<Map<String, dynamic>> get othersMovie => _othersMovie;

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

  getAllDataList(){
    _allItemsList.addAll(_allTvLists);
    _allItemsList.addAll(_choosedMoviesList);
    notifyListeners();
  }

  seperateMovies() {
    _englishMovie.clear();
    _hindiMovie.clear();
    _othersMovie.clear();
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
