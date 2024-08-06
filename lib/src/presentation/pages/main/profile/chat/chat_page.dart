import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../theme/theme.dart';
import 'riverpod/provider/chat_provider.dart';
import 'widgets/chat_item.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(chatProvider.notifier).fetchChats(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.instance.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.mainAppbarBack(),
          leading: IconButton(
            splashRadius: 18.r,
            onPressed: context.popRoute,
            icon: Icon(
              isLtr
                  ? FlutterRemix.arrow_left_s_line
                  : FlutterRemix.arrow_right_s_line,
              size: 24.r,
              color: AppColors.iconAndTextColor(),
            ),
          ),
          title: Text(
            'Admin',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.iconAndTextColor(),
              letterSpacing: -0.4,
            ),
          ),
        ),
        body: Consumer(builder: (context, ref, child) {
          final state = ref.watch(chatProvider);
          final notifier = ref.read(chatProvider.notifier);
          return state.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.r,
                    color: AppColors.green,
                  ),
                )
              : Stack(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _fireStore
                          .collection('messages')
                          .where('chat_id', isEqualTo: state.chatId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3.r,
                              color: AppColors.green,
                            ),
                          );
                        }
                        final List<DocumentSnapshot> docs = snapshot.data!.docs;
                        final List<ChatMessageData> messages = docs.map(
                          (doc) {
                            final Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;

                            if (data['unread'] && data['sender'] == 0) {
                              _fireStore
                                  .collection('messages')
                                  .doc(doc.id)
                                  .update({'unread': false});
                            }
                            final Timestamp t = data['created_at'];
                            final DateTime date = t.toDate();
                            return ChatMessageData(
                              messageOwner: data['sender'] == 0
                                  ? MessageOwner.partner
                                  : MessageOwner.you,
                              message: data['chat_content'],
                              time: '${date.hour}:${date.minute}',
                              date: date,
                            );
                          },
                        ).toList();
                        messages.sort((a, b) => b.date.compareTo(a.date));
                        return ListView.builder(
                          itemCount: messages.length,
                          reverse: true,
                          controller: scrollController,
                          padding: REdgeInsets.only(
                            bottom: 87,
                            top: 20,
                            left: 15,
                            right: 15,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final chatData = messages[index];
                            return ChatItem(chatData: chatData);
                          },
                        );
                      },
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        height: 77.r,
                        padding: REdgeInsets.symmetric(horizontal: 35),
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              offset: const Offset(0, 1),
                              blurRadius: 2.r,
                              spreadRadius: 0,
                              color: AppColors.mainAppbarShadow(),
                            )
                          ],
                          color: AppColors.mainBackground(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: 1.sw - 110.r,
                              child: TextField(
                                controller: state.textController,
                                cursorWidth: 1.r,
                                cursorColor: AppColors.iconAndTextColor(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.k2d(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    letterSpacing: -0.5,
                                    color: AppColors.secondaryIconTextColor(),
                                  ),
                                  hintText: AppHelpers.getTranslation(
                                    TrKeys.typeSomething,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: notifier.sendMessage,
                              child: Container(
                                width: 37,
                                height: 37,
                                decoration: BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.circular(37),
                                ),
                                child: Icon(
                                  FlutterRemix.send_plane_2_line,
                                  size: 18.r,
                                  color: AppColors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
        }),
      ),
    );
  }
}
