import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_movies_app/domain/entities/tv.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/get_on_the_air_tvs.dart';

part 'on_the_air_tvs_event.dart';
part 'on_the_air_tvs_state.dart';

class OnTheAirTvsBloc extends Bloc<OnTheAirTvsEvent, OnTheAirTvsState> {
  final GetOnTheAirTvs getOnTheAirTvs;
  OnTheAirTvsBloc({
    required this.getOnTheAirTvs,
  }) : super(OnTheAirTvsInitial()) {
    on<OnTheAirTvsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchOnTheAirTvs>(((event, emit) async {
      emit(OnTheAirTvLoading());
      final tvs = await getOnTheAirTvs.execute();

      tvs.fold(
        (failure) => emit(OnTheAirTvError(failure.message)),
        (tvs) => emit(OnTheAirTvHasData(tvs)),
      );
    }));
  }
}
