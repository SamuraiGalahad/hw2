import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../likes_module.dart';
import '../model/news_model.dart';

part 'likes_event.dart';
part 'likes_state.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
  LikesModule module = LikesModule();

  LikesBloc() : super(LikesInitialState()) {
    on<GetLikesEvent>((event, emit) async {
      try {
        List<News> likesList = await module.readLikedNewsFromPrefs();
        emit(LoadedLikesState(likesList));
      } catch (e) {
        emit(ErrorLikesState(e));
      }
    });
  }
}
