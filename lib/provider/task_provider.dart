import 'package:flutter/foundation.dart';
import 'package:task/models/task_model.dart';
import 'package:task/provider/auth_provider.dart';
import 'package:task/repositories/task_repository.dart';


class TaskProvider with ChangeNotifier {
  final AuthProvider _authProvider;
  final TaskRepository _taskRepository;
  
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  TaskProvider({required AuthProvider authProvider, TaskRepository? taskRepository})
      : _authProvider = authProvider,
        _taskRepository = taskRepository ?? TaskRepository() {
    if (_authProvider.user != null) {
      _initialize();
    }
  }

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void updateAuthProvider(AuthProvider authProvider) {
    if (authProvider.user != null && _authProvider.user?.uid != authProvider.user?.uid) {
      _initialize();
    }
  }

  void _initialize() {
    _taskRepository.getTasks(_authProvider.user!.uid).listen((tasks) {
      _tasks = tasks;
      _isLoading = false;
      _error = null;
      notifyListeners();
    }, onError: (error) {
      _error = error.toString();
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addTask(Task task) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _taskRepository.addTask(task);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTask(Task task) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _taskRepository.updateTask(task);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _taskRepository.deleteTask(taskId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Task> getTasksByProject(String projectId) {
    return _tasks.where((task) => task.projectId == projectId).toList();
  }

  List<Task> getTasksByStatus(String status) {
    return _tasks.where((task) => task.status == status).toList();
  }
}