// ignore_for_file: public_member_api_docs

import 'package:hive/hive.dart';

abstract interface class DatabaseClient<E, T> {
  Future<void> open(
    String boxName,
  );

  Future<void> close(
    String boxName,
  );

  Future<int> add({
    required String boxName,
    required T value,
  });

  T? getValue({
    required String boxName,
    required String key,
    required T defaultValue,
  });

  Future<void> setValue({
    required String boxName,
    required String key,
    required T value,
  });

  Future<void> deleteAt({
    required String boxName,
    required int index,
  });

  Stream<E> watch(
    String boxName,
  );

  List<T> all(
    String boxName,
  );
}

final class HiveDatabase<T> implements DatabaseClient<BoxEvent, T> {
  @override
  Future<void> open(
    String boxName,
  ) =>
      Hive.openBox<T>(
        boxName,
      );

  @override
  Future<void> close(
    String boxName,
  ) =>
      Hive.box<T>(
        boxName,
      ).close();

  @override
  Future<int> add({
    required String boxName,
    required T value,
  }) =>
      Hive.box<T>(
        boxName,
      ).add(
        value,
      );

  @override
  T? getValue({
    required String boxName,
    required String key,
    required T defaultValue,
  }) =>
      Hive.box<T?>(
        boxName,
      ).get(
        key,
        defaultValue: defaultValue,
      );

  @override
  Future<void> setValue({
    required String boxName,
    required String key,
    required T value,
  }) =>
      Hive.box<T?>(boxName).put(
        key,
        value,
      );

  @override
  Future<void> deleteAt({
    required String boxName,
    required int index,
  }) =>
      Hive.box<T>(
        boxName,
      ).deleteAt(
        index,
      );

  @override
  Stream<BoxEvent> watch(
    String boxName,
  ) =>
      Hive.box<T>(
        boxName,
      ).watch();

  @override
  List<T> all(
    String boxName,
  ) =>
      Hive.box<T>(
        boxName,
      ).values.toList();
}
