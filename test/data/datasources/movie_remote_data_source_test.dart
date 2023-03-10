import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb_movies_app/common/exception.dart';
import 'package:tmdb_movies_app/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb_movies_app/data/models/movie_detail_model.dart';
import 'package:tmdb_movies_app/data/models/movie_response.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=1e36f68fc2521991b4bd6fb76a0bda86';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing.json')))
        .movieList;

    test('should return list of movie model when the response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/now_playing.json'), 200));

      final result = await dataSource.getNowPlayingMovies();

      expect(result, equals(tMovieList));
    });

    test('should throw a ServerException when the response code is 404',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSource.getNowPlayingMovies();

      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    test(
        'should return list of popular movie model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular.json'), 200));

      final result = await dataSource.getPopularMovies();

      expect(result, equals(tMovieList));
    });

    test('should throw a ServerException when the response code is 404',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSource.getPopularMovies();

      expect(result, throwsA(isA<ServerException>()));
    });
  });
  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test(
        'should return list of top rated movie model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated.json'), 200));

      final result = await dataSource.getTopRatedMovies();

      expect(result, equals(tMovieList));
    });

    test('should throw a ServerException when the response code is 404',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSource.getTopRatedMovies();

      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    final tId = 1;
    final tMovieList = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return detail of movie when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/movie_detail.json'), 200));

      final result = await dataSource.getMovieDetail(tId);

      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSource.getMovieDetail(tId);

      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('get recommendation movie', () {
    final tId = 1;
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/movie_recommendations.json')))
        .movieList;

    test('should return recommendation of movie when the response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/movie_recommendations.json'), 200));

      final result = await dataSource.getMovieRecommendations(tId);

      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSource.getMovieRecommendations(tId);

      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList;
    final tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_spiderman_movie.json'), 200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
