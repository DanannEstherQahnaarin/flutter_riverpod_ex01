import '../exception/todo_exception.dart';

/// Todo 모델 클래스
///
/// 할일(Todo) 정보를 담는 불변(immutable) 데이터 클래스입니다.
/// 이 클래스는 할일의 제목, 설명, 완료 상태, 생성 시간 등의 정보를 관리합니다.
///
/// 주요 특징:
/// - 불변 클래스: 모든 필드가 final로 선언되어 한 번 생성되면 변경 불가
/// - copyWith 메서드: 불변 객체의 일부 필드만 변경하여 새 인스턴스 생성
/// - 유효성 검증: isValid() 메서드를 통해 데이터 유효성 검증
///
/// 예시:
/// ```dart
/// // Todo 생성
/// final todo = Todo(
///   id: 'todo-1',
///   title: '프로젝트 완료',
///   description: 'Flutter 프로젝트를 완료합니다.',
///   isCompleted: false,
/// );
///
/// // 완료 상태 변경
/// final completedTodo = todo.copyWith(isCompleted: true);
///
/// // 유효성 검증
/// if (todo.isValid()) {
///   // 유효한 Todo 처리
/// }
/// ```
class Todo {
  /// Todo의 고유 식별자
  ///
  /// 각 Todo를 구분하기 위한 고유한 ID입니다.
  /// null이 될 수 없으며, 빈 문자열이 될 수 없습니다.
  final String id;

  /// Todo의 제목
  ///
  /// 할일의 제목을 나타냅니다.
  /// 필수 필드이며, 빈 문자열이 될 수 없습니다.
  final String title;

  /// Todo의 상세 설명
  ///
  /// 할일에 대한 추가 설명이나 세부 사항을 나타냅니다.
  /// 선택 필드이며, null이 될 수 있습니다.
  final String? description;

  /// Todo의 완료 상태
  ///
  /// 할일이 완료되었는지 여부를 나타냅니다.
  /// 기본값은 false입니다.
  final bool isCompleted;

  /// Todo의 생성 시간
  ///
  /// Todo가 생성된 시점의 타임스탬프입니다.
  /// 기본값은 현재 시간입니다.
  final DateTime createdAt;

  /// Todo의 수정 시간
  ///
  /// Todo가 마지막으로 수정된 시점의 타임스탬프입니다.
  /// null일 수 있으며, 수정되지 않은 경우 null입니다.
  final DateTime? updatedAt;

  /// Todo 생성자
  ///
  /// [id] Todo의 고유 식별자 (필수)
  /// [title] Todo의 제목 (필수)
  /// [description] Todo의 상세 설명 (선택)
  /// [isCompleted] 완료 상태 (기본값: false)
  /// [createdAt] 생성 시간 (기본값: 현재 시간)
  /// [updatedAt] 수정 시간 (선택)
  ///
  /// Throws [TodoValidationException] 유효하지 않은 값이 전달된 경우
  Todo({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Todo의 일부 필드만 변경하여 새로운 Todo 인스턴스를 생성합니다.
  ///
  /// 불변 객체의 특성상 기존 객체를 변경할 수 없으므로,
  /// 이 메서드를 사용하여 일부 필드만 변경한 새 인스턴스를 생성합니다.
  ///
  /// [id] 변경할 Todo ID (선택)
  /// [title] 변경할 제목 (선택)
  /// [description] 변경할 설명 (선택, null을 전달하면 null로 설정)
  /// [isCompleted] 변경할 완료 상태 (선택)
  /// [createdAt] 변경할 생성 시간 (선택)
  /// [updatedAt] 변경할 수정 시간 (선택, null을 전달하면 null로 설정)
  ///
  /// Returns 일부 필드가 변경된 새로운 Todo 인스턴스
  ///
  /// 예시:
  /// ```dart
  /// final updatedTodo = todo.copyWith(
  ///   isCompleted: true,
  ///   updatedAt: DateTime.now(),
  /// );
  /// ```
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Todo(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    isCompleted: isCompleted ?? this.isCompleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  /// Todo의 유효성을 검증합니다.
  ///
  /// 다음 조건들을 검증합니다:
  /// - id가 비어있지 않아야 함
  /// - title이 비어있지 않아야 함
  ///
  /// Returns 유효한 경우 true, 그렇지 않으면 false
  ///
  /// 예시:
  /// ```dart
  /// if (!todo.isValid()) {
  ///   throw const TodoValidationException('Todo가 유효하지 않습니다.');
  /// }
  /// ```
  bool isValid() => id.isNotEmpty && title.trim().isNotEmpty;

  /// Todo의 유효성을 검증하고, 유효하지 않은 경우 예외를 발생시킵니다.
  ///
  /// isValid() 메서드를 호출하여 검증하고,
  /// 유효하지 않은 경우 TodoValidationException을 발생시킵니다.
  ///
  /// Throws [TodoValidationException] Todo가 유효하지 않은 경우
  ///
  /// 예시:
  /// ```dart
  /// try {
  ///   todo.validate();
  /// } on TodoValidationException catch (e) {
  ///   print('검증 실패: ${e.message}');
  /// }
  /// ```
  void validate() {
    if (!isValid()) {
      if (id.isEmpty) {
        throw const TodoValidationException('Todo ID는 필수입니다.');
      }
      if (title.trim().isEmpty) {
        throw const TodoValidationException('Todo 제목은 필수입니다.');
      }
    }
  }

  /// Todo를 JSON 형식으로 변환합니다.
  ///
  /// 데이터베이스 저장이나 네트워크 전송 시 사용됩니다.
  ///
  /// Returns Todo를 JSON 맵으로 변환한 결과
  ///
  /// 예시:
  /// ```dart
  /// final json = todo.toJson();
  /// // {'id': 'todo-1', 'title': '프로젝트 완료', ...}
  /// ```
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isCompleted': isCompleted,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  /// JSON 데이터로부터 Todo 인스턴스를 생성합니다.
  ///
  /// 데이터베이스에서 읽어오거나 네트워크에서 받은 JSON 데이터를
  /// Todo 객체로 변환할 때 사용됩니다.
  ///
  /// [json] JSON 맵 데이터
  ///
  /// Returns JSON 데이터로부터 생성된 Todo 인스턴스
  ///
  /// Throws [FormatException] JSON 형식이 올바르지 않은 경우
  ///
  /// 예시:
  /// ```dart
  /// final json = {'id': 'todo-1', 'title': '프로젝트 완료', ...};
  /// final todo = Todo.fromJson(json);
  /// ```
  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    isCompleted: json['isCompleted'] as bool? ?? false,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'] as String)
        : null,
  );

  /// 두 Todo가 같은지 비교합니다.
  ///
  /// id를 기준으로 비교합니다.
  ///
  /// [other] 비교할 다른 Todo 객체
  ///
  /// Returns id가 같으면 true, 그렇지 않으면 false
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Todo && other.id == id);

  /// Todo의 해시 코드를 반환합니다.
  ///
  /// id를 기준으로 해시 코드를 생성합니다.
  ///
  /// Returns id의 해시 코드
  @override
  int get hashCode => id.hashCode;

  /// Todo를 문자열로 변환합니다.
  ///
  /// 디버깅이나 로깅 시 사용됩니다.
  ///
  /// Returns Todo의 문자열 표현
  @override
  String toString() =>
      'Todo(id: $id, title: $title, isCompleted: $isCompleted)';
}
