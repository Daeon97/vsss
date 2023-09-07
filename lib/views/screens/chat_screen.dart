// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsss/cubits/cache_message_cubit/cache_message_cubit.dart';
import 'package:vsss/cubits/chats_cubit/chats_cubit.dart';
import 'package:vsss/cubits/delete_chat_cubit/delete_chat_cubit.dart';
import 'package:vsss/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:vsss/cubits/user_cubit/user_cubit.dart';
import 'package:vsss/resources/colors.dart';
import 'package:vsss/resources/numbers.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/utils/helpers/time_util.dart';
import 'package:vsss/views/widgets/screen_scaffold.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ScrollController _chatsListViewScrollController;

  @override
  void initState() {
    _chatsListViewScrollController = ScrollController();
    context.read<ChatsCubit>().chats;
    super.initState();
  }

  @override
  void deactivate() {
    context.read<ChatsCubit>().closeDatabase();
    super.deactivate();
  }

  @override
  void dispose() {
    _chatsListViewScrollController.dispose();
    super.dispose();
  }

  void _getChats() => context.read<ChatsCubit>().chats;

  void _scrollToEnd() => _chatsListViewScrollController.animateTo(
        _chatsListViewScrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: chatsListViewScrollAnimationDuration,
        ),
        curve: Curves.easeIn,
      );

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<SendMessageCubit, SendMessageState>(
            listener: (_, sendMessageState) {
              if (sendMessageState is FailedToSendMessageState ||
                  sendMessageState is SentMessageState) {
                _getChats();
                // _scrollToEnd();
              }
            },
          ),
          BlocListener<DeleteChatCubit, DeleteChatState>(
            listener: (_, deleteChatState) {
              if (deleteChatState is DeletedChatState) {
                _getChats();
                // _scrollToEnd();
              }
            },
          ),
          BlocListener<CacheMessageCubit, CacheMessageState>(
            listener: (_, cacheMessageState) {
              if (cacheMessageState is CachedMessageState) {
                _getChats();
                // _scrollToEnd();
                context.read<SendMessageCubit>().sendMessage(
                      cacheMessageState.message,
                    );
              }
            },
          ),
        ],
        child: ScreenScaffold(
          useScrollView: false,
          centerViewVertically: false,
          edgeInsetsGeometry: const EdgeInsetsDirectional.only(
            bottom: spacing,
          ),
          appBarTitle: const Text(
            chatLiteral,
          ),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatsCubit, ChatsState>(
                  builder: (_, chatsState) => switch (chatsState) {
                    LoadedChatsState(
                      chats: final chatsList,
                    ) =>
                      ListView.builder(
                        controller: _chatsListViewScrollController,
                        itemCount: chatsList.length,
                        itemBuilder: (_, index) => Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: index == zero ? spacing : nil,
                            bottom: spacing,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: spacing,
                              ),
                              switch (chatsList[index].isReply) {
                                true || null => const SizedBox.shrink(),
                                false => const Expanded(
                                    child: SizedBox.shrink(),
                                  )
                              },
                              switch (chatsList[index].isReply) {
                                true || null => Image.asset(
                                    robotPath,
                                    width: chatScreenRobotImageWidthAndHeight,
                                    height: chatScreenRobotImageWidthAndHeight,
                                  ),
                                false => const SizedBox.shrink()
                              },
                              Expanded(
                                flex: three,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                    spacing,
                                  ),
                                  onLongPress: switch (
                                      chatsList[index].isReply) {
                                    false
                                        when chatsList[index].failed ?? false =>
                                      () {
                                        // ignore: inference_failure_on_function_invocation
                                        showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .vertical(
                                              top: Radius.circular(
                                                spacing,
                                              ),
                                            ),
                                          ),
                                          builder: (_) => ListTile(
                                            title: const Text(
                                              deleteLiteral,
                                            ),
                                            leading: const Icon(
                                              Icons.delete_forever,
                                            ),
                                            onTap: () {
                                              context
                                                  .read<DeleteChatCubit>()
                                                  .deleteChatAt(
                                                    index,
                                                  );
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        );
                                      },
                                    _ => null
                                  },
                                  child: Container(
                                    padding: const EdgeInsetsDirectional.all(
                                      spacing,
                                    ),
                                    decoration: BoxDecoration(
                                      color: switch (chatsList[index].isReply) {
                                        true || null => Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        false =>
                                          Theme.of(context).colorScheme.primary
                                      },
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                        spacing,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          chatsList[index].message,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: switch (
                                                    chatsList[index].isReply) {
                                                  true || null => null,
                                                  false => Theme.of(context)
                                                      .colorScheme
                                                      .background
                                                },
                                              ),
                                        ),
                                        const SizedBox(
                                          height: threeDouble,
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: switch (
                                              chatsList[index].timestamp) {
                                            null => const SizedBox.shrink(),
                                            _ => Text(
                                                TimeUtil.computeHourMinuteAmPm(
                                                  chatsList[index].timestamp!,
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: switch (
                                                          chatsList[index]
                                                              .isReply) {
                                                        true || null => null,
                                                        false =>
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .background
                                                              .withOpacity(
                                                                nilDotEight,
                                                              )
                                                      },
                                                    ),
                                              ),
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              switch (chatsList[index].isReply) {
                                true || null => const SizedBox.shrink(),
                                false when chatsList[index].failed ?? false =>
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: spacing,
                                      ),
                                      Icon(
                                        Icons.error,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    ],
                                  ),
                                false => const SizedBox.shrink()
                              },
                              switch (chatsList[index].isReply) {
                                true || null => const Expanded(
                                    child: SizedBox.shrink(),
                                  ),
                                false => const SizedBox.shrink()
                              },
                              const SizedBox(
                                width: spacing,
                              ),
                            ],
                          ),
                        ),
                      ),
                    _ => const SizedBox.shrink()
                  },
                ),
              ),
              const SizedBox(
                height: spacing,
              ),
              SizedBox(
                height: chatScreenBottomLayoutHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: three,
                  itemBuilder: (_, index) => Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: switch (index) {
                        zero => spacing,
                        one => spacing,
                        _ => nil
                      },
                      end: switch (index) {
                        zero => nil,
                        one => spacing,
                        _ => spacing
                      },
                      bottom: chatScreenBottomLayoutOptionsDy,
                    ),
                    child: BlocBuilder<SendMessageCubit, SendMessageState>(
                      builder: (_, sendMessageState) => InkWell(
                        onTap: switch (sendMessageState) {
                          SendingMessageState() => null,
                          _ => () =>
                              context.read<CacheMessageCubit>().cacheMessage(
                                    switch (index) {
                                      zero => option1LongLiteral,
                                      one
                                          when context
                                                  .read<UserCubit>()
                                                  .state
                                                  .user !=
                                              null =>
                                        option2FirstPartLongLiteral +
                                            whiteSpace +
                                            relatedToLiteral +
                                            whiteSpace +
                                            context
                                                .read<UserCubit>()
                                                .state
                                                .user!
                                                .courseOfStudy +
                                            whiteSpace +
                                            option2SecondPartLongLiteral,
                                      one
                                          when context
                                                  .read<UserCubit>()
                                                  .state
                                                  .user ==
                                              null =>
                                        option2FirstPartLongLiteral +
                                            whiteSpace +
                                            option2SecondPartLongLiteral,
                                      _ => option3LongLiteral
                                    },
                                  )
                        },
                        borderRadius: BorderRadius.circular(
                          spacing,
                        ),
                        child: Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: spacing,
                            vertical: smallSpacing,
                          ),
                          decoration: BoxDecoration(
                            color: switch (sendMessageState) {
                              SendingMessageState() => disabledColor,
                              _ => Theme.of(context).colorScheme.primary
                            },
                            borderRadius: BorderRadiusDirectional.circular(
                              spacing,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(
                                  chatScreenBottomLayoutOptionsDx,
                                  chatScreenBottomLayoutOptionsDy,
                                ),
                                color: chatScreenBottomLayoutOptionsShadowColor,
                              ),
                            ],
                          ),
                          child: Text(
                            switch (index) {
                              zero => option1ShortLiteral,
                              one => option2ShortLiteral,
                              _ => option3ShortLiteral
                            },
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
