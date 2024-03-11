part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class InitialNewsState extends NewsState {}

class LoadingNewsState extends NewsState {}

class LoadedNewsState extends NewsState {
  final List<News> newsList;

  LoadedNewsState(this.newsList);
}

class ErrorNewsState extends NewsState {
  final Object? exception;

  ErrorNewsState(this.exception);
}
