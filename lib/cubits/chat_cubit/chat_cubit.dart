// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vsss/models/chat.dart';
import 'package:vsss/models/failure.dart';
import 'package:vsss/repositories/chat_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(
    ChatRepository chatsRepository,
  )   : _chatsRepository = chatsRepository,
        super(
          const ChatInitialState(),
        );

  final ChatRepository _chatsRepository;

  // Future<void> call() => _chatsRepository
}
