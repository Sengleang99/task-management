import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/task_model.dart';

class TaskRepository {
  final FirebaseFirestore _firestore;

  TaskRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<Task>> getTasks(String userId) {
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .orderBy('dueDate')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Task.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Stream<List<Task>> getTasksByProject(String userId, String projectId) {
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where('projectId', isEqualTo: projectId)
        .orderBy('dueDate')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Task.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> addTask(Task task) async {
    await _firestore.collection('tasks').add(task.toMap());
  }

  Future<void> updateTask(Task task) async {
    await _firestore
        .collection('tasks')
        .doc(task.taskId)
        .update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }

  Future<Task?> getTask(String taskId) async {
    final doc = await _firestore.collection('tasks').doc(taskId).get();
    if (doc.exists) {
      return Task.fromMap(doc.data()!, doc.id);
    }
    return null;
  }
}