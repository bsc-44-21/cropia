import 'package:flutter/material.dart';

class AgriBotScreen extends StatefulWidget {
  const AgriBotScreen({super.key});

  @override
  State<AgriBotScreen> createState() => _AgriBotScreenState();
}

class _AgriBotScreenState extends State<AgriBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() async {
    String userMessage = _controller.text.trim();

    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": userMessage});
    });

    _controller.clear();

    // Simulated AI response (replace with API later)
    String aiResponse = await _getAgriBotResponse(userMessage);

    setState(() {
      _messages.add({"role": "bot", "text": aiResponse});
    });
  }

  Future<String> _getAgriBotResponse(String message) async {
    await Future.delayed(const Duration(seconds: 1));

    return "AgriBot: I received your question about \"$message\". "
        "Here is some farming advice 🌱.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AgriBot Assistant"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isUser = _messages[index]["role"] == "user";

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_messages[index]["text"]!),
                  ),
                );
              },
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Ask AgriBot about farming...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
