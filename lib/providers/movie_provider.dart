import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> popularMovies = [];
  List<Movie> nowPlayingMovies = [];
  final urlm = 'api.themoviedb.org';
  final segmento = '/3/movie/popular';
  final apiKey = '70cb16ec75963a08639e203da2e781ad';
  //Esto es para now-playing
  final segmentoNow = '/3/movie/now_playing';

  MovieProvider() {
    getMoviesByPopular();
    getMoviesByNowPlaying();
  }
  //https://api.themoviedb.org/3/movie/popular?api_key=70cb16ec75963a08639e203da2e781ad
  Future<String> getPopularMovies({String? seg}) async {
    final url = Uri.https(urlm, segmento, {'api_key': apiKey});
    var response = await http.get(url);

    return response.body;
  }

  void getMoviesByPopular() async {
    final resp = await getPopularMovies();
    final data = convert.jsonDecode(resp) as Map<String, dynamic>;
    final popularResponse = MovieResponse.fromJson(data);
    popularMovies = popularResponse.results;
    notifyListeners();
  }

  Future<String> getNowPlayingMovies({String? seg}) async {
    final url = Uri.https(urlm, segmentoNow, {'api_key': apiKey});
    var response = await http.get(url);
    print(response.body);
    return response.body;
  }

  void getMoviesByNowPlaying() async {
    final resp = await getNowPlayingMovies();
    final data = convert.jsonDecode(resp) as Map<String, dynamic>;
    final nowPlayingResponse = MovieResponse.fromJson(data);
    nowPlayingMovies = nowPlayingResponse.results;
    notifyListeners();
  }
}
