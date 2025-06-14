// lib/chat/api.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a chat room
  Future<String> createChatRoom(String userId, String otherUserId) async {
    // Sort user IDs to ensure consistent chat ID regardless of who initiates
    final List<String> ids = [userId, otherUserId];
    ids.sort();
    final String chatId = ids.join('_');

    try {
      // Check if chat already exists
      final chatDoc = await _firestore.collection('chats').doc(chatId).get();

      if (!chatDoc.exists) {
        // Create a new chat document
        await _firestore.collection('chats').doc(chatId).set({
          'participants': [userId, otherUserId],
          'createdAt': FieldValue.serverTimestamp(),
          'lastMessage': "",
          'lastMessageSender': "",
          'lastMessageTime': FieldValue.serverTimestamp(),
          'lastActive': FieldValue.serverTimestamp(),
          'unreadCount': {
            userId: 0,
            otherUserId: 0,
          },
        });
      }
    } catch (e) {
      print('Error creating chat room: $e');
    }

    return chatId;
  }

  // Send a message
  Future<void> sendMessage(String chatId, String senderId, String message) async {
    try {
      // Add the message to the messages subcollection
      await _firestore.collection('chats').doc(chatId).collection('messages').add({
        'senderId': senderId,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
      });

      // Get the chat document to identify the other participant
      DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();

      if (chatDoc.exists) {
        Map<String, dynamic> chatData = chatDoc.data() as Map<String, dynamic>;
        List<dynamic> participants = chatData['participants'] ?? [];

        // Find the recipient (the participant who is not the sender)
        String recipientId = participants.firstWhere(
              (id) => id != senderId,
          orElse: () => '',
        );

        // Update last message and increment unread count for recipient
        Map<String, dynamic> updateData = {
          'lastMessage': message,
          'lastMessageSender': senderId,
          'lastMessageTime': FieldValue.serverTimestamp(),
          'lastActive': FieldValue.serverTimestamp(),
        };

        // Only update unread count if we found a valid recipient
        if (recipientId.isNotEmpty) {
          updateData['unreadCount.$recipientId'] = FieldValue.increment(1);
        }

        await _firestore.collection('chats').doc(chatId).update(updateData);
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(String chatId, String userId) async {
    try {
      // Reset unread count for this user
      await _firestore.collection('chats').doc(chatId).update({
        'unreadCount.$userId': 0,
      });

      // Get all unread messages sent to this user and mark them as read
      QuerySnapshot unreadMessages = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('read', isEqualTo: false)
          .where('senderId', isNotEqualTo: userId)
          .get();

      // Batch update to mark messages as read
      if (unreadMessages.docs.isNotEmpty) {
        WriteBatch batch = _firestore.batch();
        for (var doc in unreadMessages.docs) {
          batch.update(doc.reference, {'read': true});
        }
        // Commit the batch
        await batch.commit();
      }
    } catch (e) {
      print('Error marking messages as read: $e');
    }
  }

  // Get messages for a chat
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // Get all chats for a user (without orderBy to avoid composite index requirement)
  Stream<QuerySnapshot> getUserChats(String userId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .snapshots();
  }

  // Get user profile
  Future<DocumentSnapshot> getUserProfile(String userId) {
    return _firestore.collection('users').doc(userId).get();
  }

  // Update user online status
  Future<void> updateUserStatus(String userId, bool isOnline) {
    return _firestore.collection('users').doc(userId).update({
      'online': isOnline,
      'lastSeen': FieldValue.serverTimestamp(),
    });
  }

  // Get chat info
  Future<DocumentSnapshot> getChatInfo(String chatId) {
    return _firestore.collection('chats').doc(chatId).get();
  }

  // Delete a message
  Future<void> deleteMessage(String chatId, String messageId) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      print('Error deleting message: $e');
    }
  }

  // Update a message
  Future<void> updateMessage(String chatId, String messageId, String newMessage) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .update({
        'message': newMessage,
        'edited': true,
        'editedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating message: $e');
    }
  }
}