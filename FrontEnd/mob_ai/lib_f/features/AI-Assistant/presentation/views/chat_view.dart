import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../home/presentation/bloc/book_bloc.dart';
import '../../domain/entity/message.dart';
import '../widgets/Custom_chat_buble.dart';

// ignore: must_be_immutable
class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  // CollectionReference messages =
  final _scrollController = ScrollController();

  String message = "";

  TextEditingController controller = TextEditingController();

  List<Message> messagesList = [];
  @override
  void initState() {
    super.initState();
    messagesList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.left_chevron,
            color: AppPallete.primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "AI Assistant",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppPallete.primaryColor,
          ),
        ),
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<BookBloc, BookState>(
              listener: (context, state) {},
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].senderId != "1"
                        ? ChatBuble(message: messagesList[index])
                        : HumanChatBuble(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,

              decoration: InputDecoration(
                hintText: "send Message",
                suffixIcon: IconButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      var sendedMessage = Message(
                        content: controller.text.trim(),
                        senderId: "1",
                      );
                      messagesList.add(sendedMessage);

                      controller.clear();
                      context.read<BookBloc>().add(
                        FetchBooksByAI(sendedMessage),
                      );

                      setState(() {});
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.send, size: 30),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/entity/message.dart';
// import '../assistant_cubit/chat_cubit.dart';
// import '../widgets/Custom_chat_buble.dart';

// class ChatView extends StatefulWidget {
//   const ChatView({super.key});

//   @override
//   State<ChatView> createState() => _ChatViewState();
// }

// class _ChatViewState extends State<ChatView> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(CupertinoIcons.left_chevron, color: Colors.purple),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "AI Assistant",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//             color: Colors.purple,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<ChatCubit, ChatState>(
//               builder: (context, state) {
//                 final messagesList = context.read<ChatCubit>().messagesList;

//                 // WidgetsBinding.instance.addPostFrameCallback((_) {
//                 //   if (_scrollController.hasClients) {
//                 //     _scrollController.animateTo(
//                 //       _scrollController.position.maxScrollExtent,
//                 //       duration: const Duration(milliseconds: 300),
//                 //       curve: Curves.easeOut,
//                 //     );
//                 //   }
//                 // });

//                 return ListView.builder(
//                   controller: _scrollController,
//                   padding: const EdgeInsets.only(top: 16),
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: messagesList.length,
//                   itemBuilder: (context, index) {
//                     final message = messagesList[index];
//                     return message.senderId != "1"
//                         ? ChatBuble(message: message)
//                         : HumanChatBuble(message: message);
//                   },
//                 );
//               },
//             ),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageInput() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(color: Colors.purple),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration: const InputDecoration(
//                 hintText: "Type your message...",
//                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                 border: InputBorder.none,
//               ),
//               onSubmitted: (_) {
//                 _sendMessage();
//                 setState(() {});
//               } ,
//             ),
//           ),
//           IconButton(
//             icon: const Icon(CupertinoIcons.mic, color: Colors.purple),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: Colors.purple),
//             onPressed: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }

//   void _sendMessage() {
//     if (_controller.text.trim().isEmpty) return;

//     final message = Message(content: _controller.text.trim(), senderId: "1");

//     context.read<ChatCubit>().sendMessage(message: message);
//     _controller.clear();
//   }
// }
