import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../common/enums.dart';
import '../models/movie_model.dart';
import '../service/api_service.dart';

class MovieViewModel with ChangeNotifier {
  List<Result> _topRatedMovieList = [];
  List<Result> get topRatedMovieList => _topRatedMovieList;
  List<Result> _upcomingMovieList = [];
  List<Result> get upcomingMovieList => _upcomingMovieList;
  List<Result> _nowPlayingMovieList = [];
  List<Result> get nowPlayingMovieList => _nowPlayingMovieList;
  List<Result> _popularMovieList = [];
  List<Result> get popularMovieList => _popularMovieList;
  List<Result> _searchResultMovieList = [];
  List<Result> get searchResultMovieList => _searchResultMovieList;

  WidgetState _state = WidgetState.loading;
  WidgetState get state => _state;

  void changeState(WidgetState s) {
    _state = s;
    notifyListeners();
  }

  Future<void> getTopRatedMovies() async {
    try {
      changeState(WidgetState.loading);
      var response = await ApiService().getTopRatedMovies();
      var responseData = MovieListModel.fromJson(response.data);
      _topRatedMovieList = responseData.results;
      notifyListeners();
      changeState(WidgetState.succes);
    } on DioError catch (e) {
      changeState(WidgetState.error);
      debugPrint(e.message.toString());
    }
  }

  Future<void> getUpcomingMovies() async {
    try {
      changeState(WidgetState.loading);
      var response = await ApiService().getUpcomingMovies();
      var responseData = MovieListModel.fromJson(response.data);
      _upcomingMovieList = responseData.results;
      notifyListeners();
      changeState(WidgetState.succes);
    } on DioError catch (e) {
      changeState(WidgetState.error);
      debugPrint(e.message.toString());
    }
  }

  Future<void> getNowPlayingMovies() async {
    try {
      changeState(WidgetState.loading);
      var response = await ApiService().getNowPlayingMovie();
      var responseData = MovieListModel.fromJson(response.data);
      _nowPlayingMovieList = responseData.results;
      notifyListeners();
      changeState(WidgetState.succes);
    } on DioError {
      changeState(WidgetState.error);
    }
  }

  Future<void> getPopularMovie() async {
    try {
      changeState(WidgetState.loading);
      final response = await ApiService().getPopularMovie();
      var responseData = MovieListModel.fromJson(response.data);
      _popularMovieList = responseData.results;
      notifyListeners();
      changeState(WidgetState.succes);
    } on DioError catch (e) {
      print(e.toString());
      changeState(WidgetState.error);
    }
  }

  searchMovie({required String query}) async {
    try {
      changeState(WidgetState.loading);
      var response = await ApiService().searchMovie(query: query);
      var responseData = MovieListModel.fromJson(response.data);
      _searchResultMovieList = responseData.results;
      notifyListeners();
      changeState(WidgetState.succes);
    } catch (e) {
      debugPrint(e.toString());
      changeState(WidgetState.error);
    }
  }
}
