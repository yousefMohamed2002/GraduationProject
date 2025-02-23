import 'package:flutter/material.dart';

import '../Screens/utilits/Bottom_Bar/custom_bottom_nav_bar.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'bot',
      'text': 'مرحباً، أنا 👋 MediBot!\nأنا مساعدك الطبي الشخصي، كيف يمكنني مساعدتك؟',
      'time': 'Wed 8:21 AM',
    },
    {
      'sender': 'user',
      'text': 'انا عايز اعرف هل الإيبوبروفين و الوارفارين هل فيهم ضرر لو اخدتهم مع بعض',
      'time': '',
    },
    {
      'sender': 'bot',
      'text': 'نعم، هناك تفاعل دوائي خطير بين الإيبوبروفين (Ibuprofen) والوارفارين (Warfarin)، وقد يسبب مشاكل صحية خطيرة.',
      'time': '',
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'sender': 'user',
        'text': _messageController.text.trim(),
        'time': '',
      });
      _messageController.clear();
    });
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['sender'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[600] : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(
          message['text'],
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
            fontSize: 16,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 10,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage("images/Avatar.png"),
              maxRadius: 25,
              backgroundColor: Colors.white,
            ),
            title: const Text(
              "Medi Bot",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            ),
            subtitle: Row(
              children: const [
                Icon(Icons.circle, color: Colors.green, size: 15),
                SizedBox(width: 4),
                Text("Always active", style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (message['time'].isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          message['time'],
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    _buildMessageBubble(message),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0),
    );
  }
}
