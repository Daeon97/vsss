// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vsss/models/failure.dart';
import 'package:vsss/repositories/chat_repository.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(
    ChatRepository chatsRepository,
  )   : _chatsRepository = chatsRepository,
        super(
          const MessageInitialState(),
        );

  final ChatRepository _chatsRepository;

  Future<void> sendMessage(
    String message,
  ) async {
    final result = await _chatsRepository.sendMessage(
      message,
    );
    result.fold(
      _failure,
      _result,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToSendMessageState(
          failure,
        ),
      );

  void _result(
    bool result,
  ) =>
      emit(
        SentMessageState(
          result: result,
        ),
      );
}
