// Chat Response Model
class ChatResponse {
  final bool success;
  final String message;
  final String? errorCode;

  ChatResponse({
    required this.success,
    required this.message,
    this.errorCode,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      errorCode: json['errorCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'errorCode': errorCode,
    };
  }
}
