// ignore_for_file: public_member_api_docs

part of 'chat_cubit.dart';

abstract final class ChatState extends Equatable {
  const ChatState();
}

final class ChatInitialState extends ChatState {
  const ChatInitialState();

  @override
  List<Object?> get props => [];
}

final class LoadingChatsState extends ChatState {
  const LoadingChatsState();

  @override
  List<Object?> get props => [];
}

final class LoadedChatsState extends ChatState {
  const LoadedChatsState(
    this.chats,
  );

  final List<Chat> chats;

  @override
  List<Object?> get props => [
        chats,
      ];
}

final class FailedToLoadChatsState extends ChatState {
  const FailedToLoadChatsState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
