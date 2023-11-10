import 'package:flutter/material.dart';

class ChatSection extends StatelessWidget {
  final ScrollController scrollController;
  final List<ChatMessage> chatMessages;
  final Function(String text, {bool isUserMessage}) addChatMessage;

  ChatSection({
    required this.scrollController,
    required this.chatMessages,
    required this.addChatMessage,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add a subtle shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chat heading
          Container(
            padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
            // alignment: Alignment.l,
            child: Text(
              'Conversation Logs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          // Chat messages with fixed height
          Container(
            padding: EdgeInsets.all(10),
            height: 180, // Adjust the height as needed
            child: ListView.builder(
              controller: scrollController,
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return ChatMessageTile(message: message);
              },
            ),
          ),
          // User input field (if needed)
          // ...
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, this.isUserMessage = false});
}

class ChatMessageTile extends StatelessWidget {
  final ChatMessage message;

  ChatMessageTile({required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Container(
        alignment:
            message.isUserMessage ? Alignment.topRight : Alignment.topLeft,
        child: Row(
          mainAxisAlignment: message.isUserMessage
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!message.isUserMessage)
              CircleAvatar(
                backgroundColor: Colors.green[400],
                child: Icon(
                  Icons.smart_toy_outlined,
                  color: Colors.white,
                ),
              ),
            SizedBox(width: 8),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: message.isUserMessage
                        ? Radius.circular(16)
                        : Radius.circular(0),
                    bottomRight: message.isUserMessage
                        ? Radius.circular(0)
                        : Radius.circular(16),
                  ),
                  color:
                      message.isUserMessage ? Colors.blue : Colors.green[400],
                ),
                child: Text(
                  message.text,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(width: 8),
            if (message.isUserMessage)
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
