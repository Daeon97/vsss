// ignore_for_file: public_member_api_docs

part of 'delete_chat_cubit.dart';

abstract final class DeleteChatState extends Equatable {
  const DeleteChatState();
}

final class DeleteChatInitialState extends DeleteChatState {
  const DeleteChatInitialState();

  @override
  List<Object?> get props => [];
}

final class DeletedChatState extends DeleteChatState {
  const DeletedChatState();

  @override
  List<Object?> get props => [];
}
