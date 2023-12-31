

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Repository/api/anime_api.dart';
import '../../Repository/modelclass/AnimeModel.dart';

part 'anime_event.dart';
part 'anime_state.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  late AnimeModel animeModel;
  AnimeApi animeApi=AnimeApi();
  AnimeBloc() : super(AnimeInitial()) {
    on<FetchAnime>((event, emit) async{
      emit(AnimeblocLoading());
      try{

        animeModel = await animeApi.getAnime();
        emit(AnimeblocLoaded());
      } catch(e){
        print(e);
        emit(AnimeblocError());}
    });
  }
}
