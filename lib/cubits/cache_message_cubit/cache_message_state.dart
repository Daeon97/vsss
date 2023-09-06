// ignore_for_file: public_member_api_docs

part of 'cache_message_cubit.dart';

abstract final class CacheMessageState extends Equatable {
  const CacheMessageState();
}

final class CacheMessageInitialState extends CacheMessageState {
  const CacheMessageInitialState();

  @override
  List<Object> get props => [];
}

final class CachingMessageState extends CacheMessageState {
  const CachingMessageState();

  @override
  List<Object> get props => [];
}

final class CachedMessageState extends CacheMessageState {
  const CachedMessageState(
    this.message,
  );

  final Message message;

  @override
  List<Object> get props => [
        message,
      ];
}
