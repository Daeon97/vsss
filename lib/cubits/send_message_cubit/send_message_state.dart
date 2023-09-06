// ignore_for_file: public_member_api_docs

part of 'send_message_cubit.dart';

abstract final class SendMessageState extends Equatable {
  const SendMessageState();
}

final class SendMessageInitialState extends SendMessageState {
  const SendMessageInitialState();

  @override
  List<Object> get props => [];
}

final class SendingMessageState extends SendMessageState {
  const SendingMessageState();

  @override
  List<Object> get props => [];
}

final class SentMessageState extends SendMessageState {
  const SentMessageState({
    required this.result,
  });

  final bool result;

  @override
  List<Object> get props => [
        result,
      ];
}

final class FailedToSendMessageState extends SendMessageState {
  const FailedToSendMessageState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object> get props => [
        failure,
      ];
}
