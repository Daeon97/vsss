// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vsss/models/chat.dart';
import 'package:vsss/models/failure.dart';
import 'package:vsss/repositories/chat_repository.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(
    ChatRepository chatsRepository,
  )   : _chatsRepository = chatsRepository,
        super(
          const ChatsInitialState(),
        );

  final ChatRepository _chatsRepository;

  Future<void> get chats async {
    final result = await _chatsRepository.chats;
    result.fold(
      _failure,
      _chats,
    );
  }



  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToLoadChatsState(
          failure,
        ),
      );

  void _chats(
    List<Chat> chats,
  ) =>
      emit(
        LoadedChatsState(
          chats,
        ),
      );
}
