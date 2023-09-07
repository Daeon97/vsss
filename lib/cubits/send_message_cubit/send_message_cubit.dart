// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vsss/models/failure.dart';
import 'package:vsss/models/message.dart';
import 'package:vsss/repositories/chat_repository.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit(
    ChatRepository chatRepository,
  )   : _chatRepository = chatRepository,
        super(
          const SendMessageInitialState(),
        );

  final ChatRepository _chatRepository;

  Future<void> sendMessage(
    Message message,
  ) async {
    emit(
      const SendingMessageState(),
    );
    final result = await _chatRepository.sendMessage(
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
