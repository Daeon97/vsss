// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vsss/models/chat.dart';
import 'package:vsss/models/failure.dart';
import 'package:vsss/models/message.dart';
import 'package:vsss/resources/numbers.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/services/chat_service.dart';
import 'package:vsss/utils/helpers/time_util.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, List<Chat>>> get chats;

  Future<Message> cacheMessage(
    String message,
  );

  Future<Either<Failure, bool>> sendMessage(
    Message message,
  );

  Future<void> deleteChatAt(
    int index,
  );

  Future<void> closeDatabase();
}

final class ChatRepositoryImplementation implements ChatRepository {
  const ChatRepositoryImplementation({
    required ChatOpsService chatOpsService,
    required ChatUtilsService chatUtilsService,
  })  : _chatOpsService = chatOpsService,
        _chatUtilsService = chatUtilsService;

  final ChatOpsService _chatOpsService;
  final ChatUtilsService _chatUtilsService;

  @override
  Future<Either<Failure, List<Chat>>> get chats async {
    try {
      await _chatOpsService.open(
        chatsBox,
      );
      await _chatUtilsService.open(
        chatsUtilsBox,
      );

      if (_chatUtilsService.getBool(
            boxName: chatsUtilsBox,
            key: initialChatOpenKey,
            defaultValue: true,
          ) ??
          true) {
        final initialChat = Chat(
          message: helloLiteral +
              whiteSpace +
              waveEmoji +
              whiteSpace +
              initialMessage,
          timestamp: TimeUtil.currentDateTimeMilliseconds,
          isReply: true,
          failed: false,
        );
        await _chatOpsService.add(
          boxName: chatsBox,
          chat: initialChat,
        );
        await _chatUtilsService.setBool(
          boxName: chatsUtilsBox,
          key: initialChatOpenKey,
          value: false,
        );
      }

      final chats = _chatOpsService.getAllChats(
        chatsBox,
      );
      return Right(
        chats,
      );
    } catch (_) {
      return const Left(
        Failure(
          couldNotGetChatsLiteral,
        ),
      );
    }
  }

  @override
  Future<Message> cacheMessage(
    String message,
  ) async {
    await _chatOpsService.open(
      chatsBox,
    );
    final nowMilliseconds = TimeUtil.currentDateTimeMilliseconds;
    final userChat = Chat(
      message: message,
      timestamp: nowMilliseconds,
      isReply: false,
      failed: false,
    );
    final botReplyPlaceholderChat = Chat(
      message: threeDots,
      isReply: true,
      failed: false,
    );
    await _chatOpsService.add(
      boxName: chatsBox,
      chat: userChat,
    );
    await _chatOpsService.add(
      boxName: chatsBox,
      chat: botReplyPlaceholderChat,
    );
    return Message(
      text: message,
      timestamp: nowMilliseconds,
    );
  }

  @override
  Future<Either<Failure, bool>> sendMessage(
    Message message,
  ) async {
    final chats = _chatOpsService.getAllChats(
      chatsBox,
    );

    try {
      final result = await _chatOpsService.sendMessage(
        path: fowardSlash + dotenv.env[chatPath]!,
        queryParameters: <String, String>{
          messageKey: message.text,
        },
      );
      final json = {
        messageKey: result.data as String,
      };
      final chat = Chat.fromJson(
        json,
      );
      await _chatOpsService.deleteAt(
        boxName: chatsBox,
        index: chats.length - one,
      );
      final reply = Chat(
        message: chat.message,
        timestamp: chat.timestamp ?? TimeUtil.currentDateTimeMilliseconds,
        isReply: chat.isReply ?? true,
        failed: false,
      );
      await _chatOpsService.add(
        boxName: chatsBox,
        chat: reply,
      );
      return const Right(
        true,
      );
    } catch (_) {
      await _chatOpsService.deleteAt(
        boxName: chatsBox,
        index: chats.length - one,
      );
      await _chatOpsService.deleteAt(
        boxName: chatsBox,
        index: chats.length - one,
      );
      final chat = Chat(
        message: message.text,
        timestamp: message.timestamp,
        isReply: false,
        failed: true,
      );
      await _chatOpsService.add(
        boxName: chatsBox,
        chat: chat,
      );
      return const Left(
        Failure(
          couldNotSendMessageLiteral,
        ),
      );
    }
  }

  @override
  Future<void> deleteChatAt(
    int index,
  ) async {
    await _chatOpsService.open(
      chatsBox,
    );
    await _chatOpsService.deleteAt(
      boxName: chatsBox,
      index: index,
    );
  }

  @override
  Future<void> closeDatabase() async {
    await _chatOpsService.close(
      chatsBox,
    );
    await _chatUtilsService.close(
      chatsUtilsBox,
    );
  }
}
