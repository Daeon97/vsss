// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:vsss/models/chat.dart';
import 'package:vsss/utils/clients/database_client.dart';
import 'package:vsss/utils/clients/http_client.dart';
import 'package:vsss/utils/enums.dart';

abstract class _ChatService {
  Future<void> open(
    String boxName,
  );

  Future<void> close(
    String boxName,
  );
}

abstract interface class ChatOpsService extends _ChatService {
  Future<int> add({
    required String boxName,
    required Chat chat,
  });

  Future<void> deleteAt({
    required String boxName,
    required int index,
  });

  List<Chat> getAllChats(
    String boxName,
  );

  // ignore: strict_raw_type
  Future<Response> sendMessage({
    required String message,
    required String path,
  });
}

abstract interface class ChatUtilsService extends _ChatService {
  bool? getBool({
    required String boxName,
    required String key,
    required bool defaultValue,
  });

  Future<void> setBool({
    required String boxName,
    required String key,
    required bool value,
  });
}

final class ChatUtilsServiceImplementation implements ChatUtilsService {
  const ChatUtilsServiceImplementation(
    DatabaseClient<BoxEvent, bool> databaseClient,
  ) : _databaseClient = databaseClient;

  final DatabaseClient<BoxEvent, bool> _databaseClient;

  @override
  Future<void> open(
    String boxName,
  ) =>
      _databaseClient.open(
        boxName,
      );

  @override
  Future<void> close(
    String boxName,
  ) =>
      _databaseClient.close(
        boxName,
      );

  @override
  bool? getBool({
    required String boxName,
    required String key,
    required bool defaultValue,
  }) =>
      _databaseClient.getValue(
        boxName: boxName,
        key: key,
        defaultValue: defaultValue,
      );

  @override
  Future<void> setBool({
    required String boxName,
    required String key,
    required bool value,
  }) =>
      _databaseClient.setValue(
        boxName: boxName,
        key: key,
        value: value,
      );
}

final class ChatOpsServiceImplementation implements ChatOpsService {
  const ChatOpsServiceImplementation({
    required HttpClient httpClient,
    required DatabaseClient<BoxEvent, Chat> databaseClient,
  })  : _httpClient = httpClient,
        _databaseClient = databaseClient;

  final HttpClient _httpClient;
  final DatabaseClient<BoxEvent, Chat> _databaseClient;

  @override
  Future<void> open(
    String boxName,
  ) =>
      _databaseClient.open(
        boxName,
      );

  @override
  Future<void> close(
    String boxName,
  ) =>
      _databaseClient.close(
        boxName,
      );

  @override
  Future<int> add({
    required String boxName,
    required Chat chat,
  }) =>
      _databaseClient.add(
        boxName: boxName,
        value: chat,
      );

  @override
  Future<void> deleteAt({
    required String boxName,
    required int index,
  }) =>
      _databaseClient.deleteAt(
        boxName: boxName,
        index: index,
      );

  @override
  List<Chat> getAllChats(
    String boxName,
  ) =>
      _databaseClient.all(
        boxName,
      );

  @override
  // ignore: strict_raw_type
  Future<Response> sendMessage({
    required String message,
    required String path,
  }) =>
      _httpClient.request(
        requestMethod: RequestMethod.post,
        path: path,
      );
}
