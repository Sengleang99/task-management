import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String? name;
  final DateTime createdAt;
  final DateTime? lastLogin;

  AppUser({
    required this.uid,
    required this.email,
    this.name,
    required this.createdAt,
    this.lastLogin,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String?,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastLogin: map['lastLogin'] != null
          ? (map['lastLogin'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'createdAt': createdAt,
      'lastLogin': lastLogin,
    };
  }
}