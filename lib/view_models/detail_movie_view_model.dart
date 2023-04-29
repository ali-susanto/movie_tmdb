import 'package:flutter/material.dart';

import '../common/enums.dart';
import '../models/movie_detail_model.dart';
import '../service/api_service.dart';

class DetailMovieViewModel with ChangeNotifier {
  MovieDetailModel? _detailMovie;
  MovieDetailModel? get detailMovie => _detailMovie;

  WidgetState _state = WidgetState.loading;
  WidgetState get state => _state;

  void changeState(WidgetState s) {
    _state = s;
    notifyListeners();
  }

  Future<void> getMovieDetail({required int idMovie}) async {
    _detailMovie = null;
    try {
      changeState(WidgetState.loading);
      final response = await ApiService().getDetailMovie(idMovie: idMovie);
      if (response.statusCode == 200) {
        var responseData = MovieDetailModel.fromJson(response.data);
        _detailMovie = responseData;
        changeState(WidgetState.succes);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      changeState(WidgetState.error);
    }
  }
}
