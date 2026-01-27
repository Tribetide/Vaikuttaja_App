import 'package:flutter/material.dart';

/// ChatThreadScreen = yksittäinen keskustelu.
///
/// MVP:
/// - paikallinen viestilista (ei backendia)
/// - viestin lähetys lisää viestin listaan
///
/// todo:
/// - kytke viestit backend/streamiin
/// - lisää typing/seen/statusit tarvittaessa
class ChatThreadScreen extends StatefulWidget {
  const ChatThreadScreen({
    super.key,
    required this.chatTitle,
  });

  final String chatTitle;

  @override
  State<ChatThreadScreen> createState() => _ChatThreadScreenState();
}

class _ChatThreadScreenState extends State<ChatThreadScreen> {
  final _controller = TextEditingController();

  // MVP: viestit paikallisena listana
  // todo: korvaa backend/stream -viesteillä
  final List<_ChatMessage> _messages = [
    _ChatMessage(text: 'Moikka! Kiinnostaisiko yhteistyö?', isMe: false, time: '12:39'),
    _ChatMessage(text: 'Moikka! Kerro lisää 👋', isMe: true, time: '12:40'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isMe: true, time: 'nyt'));
    });

    _controller.clear();

    // todo: backendissä tässä kohtaa lähetetään viesti palvelimelle
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      // AppBarTheme tulee teemasta
      appBar: AppBar(
        title: Text(widget.chatTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final m = _messages[i];
                return _MessageBubble(
                  message: m,
                  bubbleColor: m.isMe ? cs.primary.withAlpha(35) : cs.surface,
                  borderColor: cs.primary.withAlpha(25),
                );
              },
            ),
          ),

          // input-alue
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            decoration: BoxDecoration(
              color: cs.surface,
              border: Border(top: BorderSide(color: cs.primary.withAlpha(20))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _send(),
                    // InputDecorationTheme hoitaa borderit/fillit
                    decoration: const InputDecoration(
                      hintText: 'Kirjoita viesti…',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _send,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.bubbleColor,
    required this.borderColor,
  });

  final _ChatMessage message;
  final Color bubbleColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(message.text, style: textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(message.time, style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  _ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });

  final String text;
  final bool isMe;
  final String time;
}
