// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(TodoNotifier)
final todoProvider = TodoNotifierProvider._();

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
final class TodoNotifierProvider
    extends $NotifierProvider<TodoNotifier, List<Todo>> {
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
  TodoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoNotifierHash();

  @$internal
  @override
  TodoNotifier create() => TodoNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Todo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Todo>>(value),
    );
  }
}

String _$todoNotifierHash() => r'cc83dfc035b8f7e3fa3dcab5ac36f5315a22f8ba';

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

abstract class _$TodoNotifier extends $Notifier<List<Todo>> {
  List<Todo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Todo>, List<Todo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Todo>, List<Todo>>,
              List<Todo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
