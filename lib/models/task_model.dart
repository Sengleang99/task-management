import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String? taskId;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority; // 'low', 'medium', 'high'
  final String status; // 'todo', 'inProgress', 'done'
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  final String? projectId;
  final List<String> tags;
  final DateTime? completedAt;
  final DateTime? reminder;

  Task({
    this.taskId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    this.projectId,
    required this.tags,
    this.completedAt,
    this.reminder,
  });

  /// Use when reading directly from a Firestore DocumentSnapshot
  factory Task.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Task.fromMap(data, doc.id);
  }

  /// Use this for general purpose: accepts a data map + doc ID
  factory Task.fromMap(Map<String, dynamic> data, String id) {
    return Task(
      taskId: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      priority: data['priority'] ?? 'medium',
      status: data['status'] ?? 'todo',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      userId: data['userId'] ?? '',
      projectId: data['projectId'],
      tags: List<String>.from(data['tags'] ?? []),
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      reminder: data['reminder'] != null
          ? (data['reminder'] as Timestamp).toDate()
          : null,
    );
  }

  /// Converts Task object to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dueDate': Timestamp.fromDate(dueDate),
      'priority': priority,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'userId': userId,
      'projectId': projectId,
      'tags': tags,
      'completedAt':
          completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'reminder': reminder != null ? Timestamp.fromDate(reminder!) : null,
    };
  }
}
