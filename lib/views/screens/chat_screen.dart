// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsss/cubits/chats_cubit/chats_cubit.dart';
import 'package:vsss/cubits/message_cubit/message_cubit.dart';
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
  @override
  void initState() {
    context.read<ChatsCubit>().chats;
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<MessageCubit, MessageState>(
        listener: (_, messageState) {
          if (messageState is FailedToSendMessageState ||
              messageState is SentMessageState) {
            context.read<ChatsCubit>().chats;
          }
        },
        child: ScreenScaffold(
          useScrollView: false,
          centerViewVertically: false,
          edgeInsetsGeometry: const EdgeInsetsDirectional.symmetric(
            vertical: spacing,
          ),
          title: chatLiteral,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatsCubit, ChatsState>(
                  builder: (_, chatsState) => switch (chatsState) {
                    LoadedChatsState(
                      chats: final chatsList,
                    ) =>
                      ListView.builder(
                        itemCount: chatsList.length,
                        itemBuilder: (_, index) => Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom:
                                index == chatsList.length - one ? nil : spacing,
                          ),
                          child: Row(
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
                              Expanded(
                                flex: three,
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
                                                      false => Theme.of(context)
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
                    child: InkWell(
                      onTap: () => context.read<MessageCubit>().sendMessage(
                            switch (index) {
                              zero => option1LongLiteral,
                              one
                                  when context.read<UserCubit>().state.user !=
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
                                  when context.read<UserCubit>().state.user ==
                                      null =>
                                option2FirstPartLongLiteral +
                                    whiteSpace +
                                    option2SecondPartLongLiteral,
                              _ => option3LongLiteral
                            },
                          ),
                      borderRadius: BorderRadius.circular(
                        spacing,
                      ),
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: spacing,
                          vertical: smallSpacing,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
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
            ],
          ),
        ),
      );
}
