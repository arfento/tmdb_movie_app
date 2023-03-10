import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb_movies_app/common/exception.dart';
import 'package:tmdb_movies_app/data/datasources/movie_local_data_source.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovielocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovielocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('Should return success message when insert to database is success',
        () async {
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      final result = await dataSource.insertWatchlist(testMovieTable);
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenThrow(Exception());
      final call = dataSource.insertWatchlist(testMovieTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      final result = await dataSource.removeWatchlist(testMovieTable);
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove to database is failed',
        () async {
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception());
      final call = dataSource.removeWatchlist(testMovieTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tID = 1;
    test('should return movie detail table when data is found', () async {
      when(mockDatabaseHelper.getMovieById(tID))
          .thenAnswer((_) async => testMovieMap);
      final result = await dataSource.getMovieById(tID);
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      when(mockDatabaseHelper.getMovieById(tID)).thenAnswer((_) async => null);
      final result = await dataSource.getMovieById(tID);

      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      final result = await dataSource.getWatchlistMovies();
      expect(result, [testMovieTable]);
    });
  });
}
