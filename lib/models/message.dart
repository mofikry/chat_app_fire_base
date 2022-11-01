class MessageMolel {
  final String message;
  final String id;

  MessageMolel(this.message, this.id);

  factory MessageMolel.fromJson(jsonData) {
    return MessageMolel(jsonData['message'], jsonData['id']);
  }
}
