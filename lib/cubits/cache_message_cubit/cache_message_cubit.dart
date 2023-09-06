// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vsss/models/message.dart';
import 'package:vsss/repositories/chat_repository.dart';

part 'cache_message_state.dart';

class CacheMessageCubit extends Cubit<CacheMessageState> {
  CacheMessageCubit(
    ChatRepository chatsRepository,
  )   : _chatsRepository = chatsRepository,
        super(
          const CacheMessageInitialState(),
        );

  final ChatRepository _chatsRepository;

  Future<void> cacheMessage(
    String message,
  ) async {
    emit(
      const CachingMessageState(),
    );
    final result = await _chatsRepository.cacheMessage(
      message,
    );
    emit(
      CachedMessageState(
        result,
      ),
    );
  }
}
