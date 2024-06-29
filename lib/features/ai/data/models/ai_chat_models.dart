enum MessageType { text, recommendation,user }

class Message {
  final MessageType type;
  final String? content; // Optional for recommendations

  Message(this.type, this.content);

  factory Message.fromJson(Map<String, dynamic> json) {
    final type = determineMessageType(json);
    return parseMessage(type, json);
  }
}

class TextMessage extends Message {
  TextMessage.fromJson(Map<String, dynamic> json)
      : super(MessageType.text, json['message'] as String);
}

class BookRecommendation extends Message {
  final String author;
  final String book;
  final String feedback;
  final String imageUrl;
  final int publishedYear;
  final double rate;

  BookRecommendation(this.author, this.book, this.feedback, this.imageUrl,
      this.publishedYear, this.rate)
      : super(MessageType.recommendation, null);

  factory BookRecommendation.fromJson(Map<String, dynamic> json) {
    return BookRecommendation(
        json['Author'] as String,
        json['Book'] as String,
        json['Feedback'] as String,
        json['Image'] as String,
        json['Published Year'] as int,
        json['Rate'] as double);
  }
}

MessageType determineMessageType(Map<String, dynamic> json) {
  if (json.containsKey('message')) {
    return MessageType.text;
  } else if (json.containsKey('Author') && json.containsKey('Book')) {
    return MessageType.recommendation;
  } else {
    throw Exception('Unknown message type');
  }
}

Message parseMessage(MessageType type, Map<String, dynamic> json) {
  switch (type) {
    case MessageType.text:
      return TextMessage.fromJson(json);
    case MessageType.recommendation:
      return BookRecommendation.fromJson(json);
    default:
      throw Exception('Unhandled message type');
  }
}