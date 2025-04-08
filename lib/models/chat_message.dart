import 'package:hive/hive.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 0)
class ChatMessage extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  String sender; // "A" or "B"

  ChatMessage({required this.text, required this.sender});
}
