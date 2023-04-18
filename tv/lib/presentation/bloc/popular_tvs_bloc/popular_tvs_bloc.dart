import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tv_usecase/get_popular_tvs.dart';

part 'popular_tvs_event.dart';
part 'popular_tvs_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs popularTvs;
  PopularTvsBloc({required this.popularTvs}) : super(PopularTvsInitial()) {
    on<PopularTvsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchPopularTvs>(((event, emit) async {
      emit(PopularTvsLoading());
      final result = await popularTvs.execute();
      result.fold(
        (failure) => emit(PopularTvsError(failure.message)),
        (tvs) => emit(PopularTvsHasData(tvs)),
      );
    }));
  }
}
