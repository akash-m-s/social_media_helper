import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_media_helper/models/chat_message.dart';
import '../providers/chat_provider.dart';

class ChatSimulationPage extends StatelessWidget {
  const ChatSimulationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Pop the current screen and navigate back to the home screen
            context.pop();
          },
        ),
        title: const Text("Chat Builder"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<ChatProvider>().clearAll();
            },
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              context.read<ChatProvider>().sendChatDataToAPI();
            },
          ),
        ],
      ),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          final chatList = chatProvider.chatList;

          return chatList.isEmpty
              ? const Center(child: Text('Tap + to start the conversation'))
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    final bubble = chatList[index];
                    return _buildBubble(context, index, bubble);
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ChatProvider>().addBubble();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBubble(BuildContext context, int index, ChatMessage bubble) {
    final isPersonA = bubble.sender == "A";
    final controller = TextEditingController(text: bubble.text);

    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return Align(
      alignment: isPersonA ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isPersonA ? Colors.grey[300] : Colors.blue[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: controller,
          onChanged: (val) {
            context.read<ChatProvider>().updateBubble(index, val);
          },
          decoration: InputDecoration.collapsed(
            hintText: isPersonA ? 'Person A says...' : 'Person B says...',
          ),
          maxLines: null,
        ),
      ),
    );
  }
}
