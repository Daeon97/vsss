// ignore_for_file: public_member_api_docs

part of 'message_cubit.dart';

abstract final class MessageState extends Equatable {
  const MessageState();
}

final class MessageInitialState extends MessageState {
  const MessageInitialState();

  @override
  List<Object> get props => [];
}

final class SendingMessageState extends MessageState {
  const SendingMessageState();

  @override
  List<Object> get props => [];
}

final class SentMessageState extends MessageState {
  const SentMessageState({
    required this.result,
  });

  final bool result;

  @override
  List<Object> get props => [
        result,
      ];
}

final class FailedToSendMessageState extends MessageState {
  const FailedToSendMessageState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object> get props => [
        failure,
      ];
}
