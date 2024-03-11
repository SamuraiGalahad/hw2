import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/news_model.dart';
import '../web_module.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final WebModule module = WebModule();

  NewsBloc() : super(InitialNewsState()) {
    on<FetchNewsEvent>((event, emit) async {
      try {
        await module.getNews();
        List<News> newsList = await module.readNewsFromPrefs();
        emit(LoadedNewsState(newsList));
      } catch (e) {
        emit(ErrorNewsState(e));
      }
    });
  }
}
