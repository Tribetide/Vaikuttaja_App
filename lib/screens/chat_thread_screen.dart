import 'package:flutter/material.dart';
import '../theme/app_theme_theme.dart';

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

  // mvp: viestit paikallisena listana
  // todo: korvaa backend/stream -viesteillä
  final List<_ChatMessage> _messages = [
    _ChatMessage(text: 'Moikka! Kiinnostaisiko yhteistyö?', isMe: false, time: '12:39'),
    _ChatMessage(text: 'Moikka! Kerro lisää 👋', isMe: true, time: '12:40'),
  ];

  Color _alpha(Color c, double opacity) => c.withAlpha((opacity * 255).round());

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
    // todo: voi lisätä myös “auto reply” -mockin jos haluatte demo-fiiliksen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.chatTitle),
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textPrimary,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final m = _messages[i];
                return Align(
                  alignment: m.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 320),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: m.isMe
                          ? _alpha(AppColors.primary, 0.18)
                          : _alpha(AppColors.surface, 0.95),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _alpha(AppColors.primary, 0.10)),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          m.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.text,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          m.time,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: _alpha(AppColors.textPrimary, 0.60),
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // input-alue
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                top: BorderSide(color: _alpha(AppColors.primary, 0.10)),
              ),
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
                    decoration: InputDecoration(
                      hintText: 'Kirjoita viesti…',
                      filled: true,
                      fillColor: _alpha(AppColors.secondary, 0.25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: _alpha(AppColors.primary, 0.10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: _alpha(AppColors.primary, 0.10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: _alpha(AppColors.primary, 0.35)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _send,
                  icon: Icon(Icons.send, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ],
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
