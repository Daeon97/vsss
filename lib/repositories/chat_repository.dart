// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vsss/models/chat.dart';
import 'package:vsss/models/failure.dart';
import 'package:vsss/resources/numbers.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/services/chat_service.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, List<Chat>>> get chats;

  Future<Either<Failure, bool>> sendMessage(
    String message,
  );
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
          message: helloLiteral + initialMessage,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isReply: false,
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
  Future<Either<Failure, bool>> sendMessage(
    String message,
  ) async {
    await _chatOpsService.open(
      chatsBox,
    );
    final nowMilliseconds = DateTime.now().millisecondsSinceEpoch;
    final chat = Chat(
      message: message,
      timestamp: nowMilliseconds,
      isReply: false,
      failed: false,
    );
    await _chatOpsService.add(
      boxName: chatsBox,
      chat: chat,
    );

    try {
      final result = await _chatOpsService.sendMessage(
        path: dotenv.env[chatPath]!,
        queryParameters: <String, String>{
          messageKey: message,
        },
      );
      final json = result.data as Map<String, dynamic>;
      final response = Chat.fromJson(
        json,
      );
      final chat = Chat(
        message: response.message,
        timestamp: response.timestamp ?? DateTime.now().millisecondsSinceEpoch,
        isReply: response.isReply ?? true,
        failed: false,
      );
      await _chatOpsService.add(
        boxName: chatsBox,
        chat: chat,
      );
      return const Right(
        true,
      );
    } catch (_) {
      final chats = _chatOpsService.getAllChats(
        chatsBox,
      );
      await _chatOpsService.deleteAt(
        boxName: chatsBox,
        index: chats.length - one,
      );
      final chat = Chat(
        message: message,
        timestamp: nowMilliseconds,
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
}
