import 'package:flutter/foundation.dart';
import 'package:pfe_banking_system/screens/chatbot/service/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/ChatMessage.dart';


class ChatProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String _userId = '1'; // Default user ID

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String get userId => _userId;

  ChatProvider() {
    _initializeUserId();
    _loadWelcomeMessage();
  }

  Future<void> _initializeUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _userId = prefs.getString('user_id') ?? '1';
      notifyListeners();
    } catch (e) {
      print('[ChatProvider] Error loading user ID: $e');
      _userId = '1'; // Fallback to default
    }
  }

  void _loadWelcomeMessage() {
    final welcomeMessage = ChatMessage(
      id: _generateMessageId(),
      message: "Bonjour! Comment puis-je vous aider aujourd'hui?",
      isUser: false,
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
    );
    _messages.add(welcomeMessage);
    notifyListeners();
  }

  String _generateMessageId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<void> sendMessage(String messageText) async {
    if (messageText.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: _generateMessageId(),
      message: messageText.trim(),
      isUser: true,
      timestamp: DateTime.now(),
      status: MessageStatus.sending,
    );

    _messages.add(userMessage);
    notifyListeners();

    // Update user message status to sent
    final userIndex = _messages.indexWhere((msg) => msg.id == userMessage.id);
    if (userIndex != -1) {
      _messages[userIndex] = userMessage.copyWith(status: MessageStatus.sent);
      notifyListeners();
    }

    // Set loading state
    _isLoading = true;
    notifyListeners();

    try {
      // Send message to API
      final response = await _apiService.sendMessage(
        userId: _userId,
        message: messageText.trim(),
      );

      // Add bot response
      final botMessage = ChatMessage(
        id: _generateMessageId(),
        message: response.message,
        isUser: false,
        timestamp: DateTime.now(),
        status: response.success ? MessageStatus.sent : MessageStatus.failed,
      );

      _messages.add(botMessage);

      // If there was an error, also update user message status
      if (!response.success) {
        final userIndex = _messages.indexWhere((msg) => msg.id == userMessage.id);
        if (userIndex != -1) {
          _messages[userIndex] = userMessage.copyWith(status: MessageStatus.failed);
        }
      }

    } catch (e) {
      // Add error message
      final errorMessage = ChatMessage(
        id: _generateMessageId(),
        message: "Désolé, je ne peux pas répondre pour le moment. Veuillez réessayer plus tard.",
        isUser: false,
        timestamp: DateTime.now(),
        status: MessageStatus.failed,
      );

      _messages.add(errorMessage);

      // Update user message status to failed
      final userIndex = _messages.indexWhere((msg) => msg.id == userMessage.id);
      if (userIndex != -1) {
        _messages[userIndex] = userMessage.copyWith(status: MessageStatus.failed);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retryMessage(String messageId) async {
    final messageIndex = _messages.indexWhere((msg) => msg.id == messageId);
    if (messageIndex == -1) return;

    final message = _messages[messageIndex];
    if (message.isUser && message.status == MessageStatus.failed) {
      // Remove the failed message and any subsequent messages
      _messages.removeRange(messageIndex, _messages.length);
      notifyListeners();

      // Resend the message
      await sendMessage(message.message);
    }
  }

  void clearMessages() {
    _messages.clear();
    _loadWelcomeMessage();
    notifyListeners();
  }

  Future<void> setUserId(String newUserId) async {
    _userId = newUserId;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', newUserId);
    } catch (e) {
      print('[ChatProvider] Error saving user ID: $e');
    }
    notifyListeners();
  }
}