import 'package:core/core.dart';
import 'package:local_db/data/datasources/db/database_helper.dart';
import 'package:tv/data/models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvTable movie);
  Future<String> removeWatchlist(TvTable movie);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTvs();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvs() async {
    final result = await databaseHelper.getWatchlistTvs();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TvTable tv) async {
    try {
      await databaseHelper.insertTvWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable movie) async {
    try {
      await databaseHelper.removeTvWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
