part of 'likes_bloc.dart';

@immutable
sealed class LikesState {}

final class LikesInitialState extends LikesState {}

class LoadingLikesState extends LikesState {}

class LoadedLikesState extends LikesState {
  final List<News> newsList;

  LoadedLikesState(this.newsList);
}

class ErrorLikesState extends LikesState {
  final Object? exception;

  ErrorLikesState(this.exception);
}
