import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/todo.dart';
import '../exception/todo_exception.dart';
import '../utils/logger.dart';

part 'todo_provider.g.dart';

/// Todo 상태 관리 Provider
///
/// Riverpod을 사용하여 Todo 목록의 상태를 관리합니다.
/// 이 Provider는 Todo의 추가, 수정, 삭제, 조회 기능을 제공합니다.
///
/// 주요 기능:
/// - Todo 목록 조회
/// - Todo 추가 (유효성 검증 포함)
/// - Todo 수정 (존재 여부 확인 및 유효성 검증)
/// - Todo 삭제 (존재 여부 확인)
///
/// 사용 예시:
/// ```dart
/// // Provider에서 Todo 목록 가져오기
/// final todos = ref.watch(todoNotifierProvider);
///
/// // Todo 추가
/// ref.read(todoNotifierProvider.notifier).addTodo(newTodo);
///
/// // Todo 수정
/// ref.read(todoNotifierProvider.notifier).updateTodo(todoId, updatedTodo);
///
/// // Todo 삭제
/// ref.read(todoNotifierProvider.notifier).deleteTodo(todoId);
/// ```
@riverpod
class TodoNotifier extends _$TodoNotifier {
  /// 초기 상태 설정
  ///
  /// Returns 빈 Todo 리스트를 반환합니다.
  @override
  List<Todo> build() {
    logger.i('TodoNotifier 초기화');
    return [];
  }

  /// 현재 Todo 목록을 반환합니다.
  ///
  /// Returns 현재 저장된 모든 Todo 목록
  ///
  /// 예시:
  /// ```dart
  /// final todos = ref.read(todoNotifierProvider.notifier).getTodos();
  /// ```
  List<Todo> getTodos() {
    logger.i('Todo 목록 조회: ${state.length}개');
    return state;
  }

  /// 새로운 Todo를 추가합니다.
  ///
  /// Todo의 유효성을 검증하고, 중복 체크를 수행한 후 목록에 추가합니다.
  ///
  /// [todo] 추가할 Todo 객체
  ///
  /// Throws [TodoValidationException] Todo가 유효하지 않은 경우
  /// Throws [TodoDuplicateException] 동일한 제목의 Todo가 이미 존재하는 경우
  ///
  /// 예시:
  /// ```dart
  /// try {
  ///   await ref.read(todoNotifierProvider.notifier).addTodo(newTodo);
  /// } on TodoValidationException catch (e) {
  ///   // 검증 오류 처리
  /// } on TodoDuplicateException catch (e) {
  ///   // 중복 오류 처리
  /// }
  /// ```
  Future<void> addTodo(Todo todo) async {
    final stopwatch = Stopwatch()..start();
    logger.i('Todo 추가 시작: ${todo.title}');

    try {
      // Todo 유효성 검증
      todo.validate();

      // 중복 체크 (제목 기준)
      final existingTodo = state.firstWhere(
        (t) => t.title.trim().toLowerCase() == todo.title.trim().toLowerCase(),
        orElse: () => Todo(id: '', title: ''),
      );

      if (existingTodo.id.isNotEmpty) {
        logger.w('중복된 Todo 발견: ${todo.title}');
        throw TodoDuplicateException(todo.title);
      }

      // 상태 업데이트
      state = [...state, todo];
      stopwatch.stop();
      logger.i(
        'Todo 추가 완료: ${todo.title} (소요 시간: ${stopwatch.elapsedMilliseconds}ms)',
      );
    } on TodoValidationException catch (e, stackTrace) {
      stopwatch.stop();
      logger.e(
        'Todo 추가 실패 - 검증 오류: ${e.message}',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } on TodoDuplicateException catch (e, stackTrace) {
      stopwatch.stop();
      logger.e(
        'Todo 추가 실패 - 중복 오류: ${e.message}',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } on Exception catch (e, stackTrace) {
      stopwatch.stop();
      logger.e(
        'Todo 추가 실패 - 예상치 못한 오류: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// 기존 Todo를 수정합니다.
  ///
  /// Todo의 존재 여부를 확인하고, 유효성을 검증한 후 수정합니다.
  ///
  /// [id] 수정할 Todo의 ID
  /// [updatedTodo] 수정된 Todo 객체
  ///
  /// Throws [TodoNotFoundException] 해당 ID의 Todo를 찾을 수 없는 경우
  /// Throws [TodoValidationException] 수정된 Todo가 유효하지 않은 경우
  ///
  /// 예시:
  /// ```dart
  /// try {
  ///   await ref.read(todoNotifierProvider.notifier).updateTodo(
  ///     todoId,
  ///     todo.copyWith(title: '수정된 제목'),
  ///   );
  /// } on TodoNotFoundException catch (e) {
  ///   // Todo를 찾을 수 없음
  /// } on TodoValidationException catch (e) {
  ///   // 검증 오류
  /// }
  /// ```
  Future<void> updateTodo(String id, Todo updatedTodo) async {
    final stopwatch = Stopwatch()..start();
    logger.i('Todo 수정 시작: $id');

    try {
      // Todo 존재 여부 확인
      final todoIndex = state.indexWhere((t) => t.id == id);
      if (todoIndex == -1) {
        logger.w('Todo를 찾을 수 없음: $id');
        throw TodoNotFoundException(id);
      }

      // 유효성 검증
      updatedTodo.validate();

      // 상태 업데이트
      final updatedList = List<Todo>.from(state);
      updatedList[todoIndex] = updatedTodo.copyWith(updatedAt: DateTime.now());
      state = updatedList;

      stopwatch.stop();
      logger.i('Todo 수정 완료: $id (소요 시간: ${stopwatch.elapsedMilliseconds}ms)');
    } on TodoNotFoundException catch (e, stackTrace) {
      stopwatch.stop();
      logger.e(
        'Todo 수정 실패 - Todo를 찾을 수 없음: ${e.message}',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } on TodoValidationException catch (e, stackTrace) {
      stopwatch.stop();
      logger.e(
        'Todo 수정 실패 - 검증 오류: ${e.message}',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } on Exception catch (e, stackTrace) {
      stopwatch.stop();
      logger.e(
        'Todo 수정 실패 - 예상치 못한 오류: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Todo를 삭제합니다.
  ///
  /// Todo의 존재 여부를 확인한 후 목록에서 제거합니다.
  ///
  /// [id] 삭제할 Todo의 ID
  ///
  /// Throws [TodoNotFoundException] 해당 ID의 Todo를 찾을 수 없는 경우
  ///
  /// 예시:
  /// ```dart
  /// try {
  ///   await ref.read(todoNotifierProvider.notifier).deleteTodo(todoId);
  /// } on TodoNotFoundException catch (e) {
  ///   // Todo를 찾을 수 없음
  /// }
  /// ```
  Future<void> deleteTodo(String id) async {
    final stopwatch = Stopwatch()..start();
    logger.i('Todo 삭제 시작: $id');

    try {
      // Todo 존재 여부 확인
      final todoIndex = state.indexWhere((t) => t.id == id);
      if (todoIndex == -1) {
        logger.w('Todo를 찾을 수 없음: $id');
        throw TodoNotFoundException(id);
      }

      // 상태 업데이트
      final updatedList = List<Todo>.from(state)..removeAt(todoIndex);
      state = updatedList;

      stopwatch.stop();
      logger.i('Todo 삭제 완료: $id (소요 시간: ${stopwatch.elapsedMilliseconds}ms)');
    } on TodoNotFoundException catch (e, stackTrace) {
      stopwatch.stop();
      logger.e(
        'Todo 삭제 실패 - Todo를 찾을 수 없음: ${e.message}',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } on Exception catch (e, stackTrace) {
      stopwatch.stop();
      logger.e(
        'Todo 삭제 실패 - 예상치 못한 오류: ${e.toString()}',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// 완료된 Todo 목록을 반환합니다.
  ///
  /// Returns 완료 상태(isCompleted: true)인 Todo 목록
  ///
  /// 예시:
  /// ```dart
  /// final completedTodos = ref.read(todoNotifierProvider.notifier).getCompletedTodos();
  /// ```
  List<Todo> getCompletedTodos() {
    final completedTodos = state.where((todo) => todo.isCompleted).toList();
    logger.d('완료된 Todo 조회: ${completedTodos.length}개');
    return completedTodos;
  }

  /// 미완료 Todo 목록을 반환합니다.
  ///
  /// Returns 미완료 상태(isCompleted: false)인 Todo 목록
  ///
  /// 예시:
  /// ```dart
  /// final pendingTodos = ref.read(todoNotifierProvider.notifier).getPendingTodos();
  /// ```
  List<Todo> getPendingTodos() {
    final pendingTodos = state.where((todo) => !todo.isCompleted).toList();
    logger.d('미완료 Todo 조회: ${pendingTodos.length}개');
    return pendingTodos;
  }
}
