// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vsss/models/chat.dart';
import 'package:vsss/models/failure.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/services/chat_service.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, List<Chat>>> get chats;

  Future<Either<Failure, Chat>> sendMessage(
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
          options: [
            option1ShortLiteral,
            option2ShortLiteral,
            option3ShortLiteral,
          ],
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
  Future<Either<Failure, Chat>> sendMessage(
    String message,
  ) async {
    try {
      final result = await _chatOpsService.sendMessage(
        message: message,
        path: dotenv.env[chatPath]!,
      );
      final json = result.data as Map<String, dynamic>;
      return const Left(
        Failure(
          couldNotSendMessageLiteral,
        ),
      );
    } catch (_) {
      return const Left(
        Failure(
          couldNotSendMessageLiteral,
        ),
      );
    }
  }
}
