// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vsss/repositories/chat_repository.dart';

part 'delete_chat_state.dart';

class DeleteChatCubit extends Cubit<DeleteChatState> {
  DeleteChatCubit(
    ChatRepository chatRepository,
  )   : _chatRepository = chatRepository,
        super(
          const DeleteChatInitialState(),
        );

  final ChatRepository _chatRepository;

  Future<void> deleteChatAt(
    int index,
  ) async {
    await _chatRepository.deleteChatAt(
      index,
    );
    emit(
      const DeletedChatState(),
    );
  }
}
