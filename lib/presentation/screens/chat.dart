import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = "chat";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final List<String> _exampleMessages = [
    "أريد لابتوب من نوع Lenovo يكون بالقرب من إدلب",
    "ابحث عن هاتف ذكي بسعر أقل من 500 دولار ومواصفات عالية",
    "أحتاج إلى ثلاجة سعة كبيرة بموفر للطاقة",
    "أرغب في شراء دراجة هوائية كهربائية للمدينة",
    "ابحث عن عطر رجالي من ماركة عالمية برائحة خشبية"
  ];

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    _messageController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              text: "جاري البحث عن: '$text'... سأعود لك بالنتائج قريباً",
              isUser: false,
            ),
          );
        });
      });
    });
  }

  void _useExample(String example) {
    _messageController.text = example;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 249, 253, 1),
      appBar: myAppBar(title: "مساعد الذكاء الصناعي", context: context),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _messages[index],
            ),
          ),
          _buildExamples(),
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: AppColor.kPrimaryColor.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'أدخل وصف المنتج الذي تبحث عنه...',
                  border: InputBorder.none,
                ),
                textDirection: TextDirection.rtl,
                onSubmitted: _handleSubmitted,
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: AppColor.kPrimaryColor,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => _handleSubmitted(_messageController.text),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildExamples() {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _exampleMessages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _useExample(_exampleMessages[index]),
            child: Container(
              width: 220,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: AppColor.kPrimaryColor.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CairoText(
                _exampleMessages[index],
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isUser
              ? AppColor.kPrimaryColor
              : const Color.fromARGB(255, 238, 238, 238),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft:
                isUser ? const Radius.circular(18) : const Radius.circular(4),
            bottomRight:
                isUser ? const Radius.circular(4) : const Radius.circular(18),
          ),
        ),
        child: CairoText(
          text,
          color: isUser ? Colors.white : Colors.black87,
          fontSize: 15,
        ),
      ),
    );
  }
}
