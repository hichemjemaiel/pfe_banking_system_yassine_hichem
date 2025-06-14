// lib/models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String displayName;
  final String email;
  final String? photoUrl;
  final bool online;
  final Timestamp? lastSeen;
  final String? location;

  UserModel({
    required this.id,
    required this.displayName,
    required this.email,
    this.photoUrl,
    this.online = false,
    this.lastSeen,
    this.location,
  });

  // Create a UserModel instance from a Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      id: doc.id,
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'],
      online: data['online'] ?? false,
      lastSeen: data['lastSeen'],
      location: data['location'],
    );
  }

  // Convert UserModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'online': online,
      'lastSeen': lastSeen ?? FieldValue.serverTimestamp(),
      'location': location,
    };
  }

  // Create a copy of UserModel with updated fields
  UserModel copyWith({
    String? displayName,
    String? email,
    String? photoUrl,
    bool? online,
    Timestamp? lastSeen,
    String? location,
  }) {
    return UserModel(
      id: this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      online: online ?? this.online,
      lastSeen: lastSeen ?? this.lastSeen,
      location: location ?? this.location,
    );
  }
}

// Service to manage users in Firestore
class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new user in Firestore
  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  // Get a user by ID
  Future<UserModel?> getUserById(String userId) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc);
    }
    return null;
  }

  // Update a user's online status
  Future<void> updateUserStatus(String userId, bool online) async {
    await _firestore.collection('users').doc(userId).update({
      'online': online,
      'lastSeen': FieldValue.serverTimestamp(),
    });
  }

  // Update user profile
  Future<void> updateUserProfile(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  // Get all users
  Stream<QuerySnapshot> getAllUsers() {
    return _firestore.collection('users').snapshots();
  }

  // Get online users
  Stream<QuerySnapshot> getOnlineUsers() {
    return _firestore
        .collection('users')
        .where('online', isEqualTo: true)
        .snapshots();
  }
}