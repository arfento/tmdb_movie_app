import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:tv/domain/entities/tv.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs _searchTvs;
  TvSearchBloc(this._searchTvs) : super(TvSearchInitial()) {
    on<TvSearchEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<OnQueryTvChanged>(
      ((event, emit) async {
        final query = event.query;

        emit(TvSearchLoading());
        final result = await _searchTvs.execute(query);

        result.fold(
          (failure) => emit(TvSearchError(failure.message)),
          (data) {
            emit(TvSearchHasData(data));
            if (data.isEmpty) {
              emit(TvSearchEmpty());
            }
          },
        );
      }),
    );
  }
}
