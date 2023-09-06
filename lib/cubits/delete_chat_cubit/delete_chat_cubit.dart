// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vsss/repositories/chat_repository.dart';

part 'delete_chat_state.dart';

class DeleteChatCubit extends Cubit<DeleteChatState> {
  DeleteChatCubit(
    ChatRepository chatsRepository,
  )   : _chatsRepository = chatsRepository,
        super(
          const DeleteChatInitialState(),
        );

  final ChatRepository _chatsRepository;

  Future<void> deleteChatAt(
    int index,
  ) async {
    emit(
      const DeletingChatState(),
    );
    await _chatsRepository.deleteChatAt(
      index,
    );
    emit(
      const DeletedChatState(),
    );
  }
}
