import 'package:flutter/material.dart';
import '../../model/todo.dart';
import '../common/custom_text_field.dart';
import '../common/custom_button.dart';

/// Todo 입력 폼 위젯
///
/// Todo의 제목과 설명을 입력받는 폼입니다.
/// 유효성 검증을 수행하고, 제출 시 콜백을 호출합니다.
///
/// 주요 특징:
/// - 제목 및 설명 입력 필드
/// - 유효성 검증 UI
/// - 초기값 설정 지원
/// - Props 기반 설계 (onSubmit 콜백)
///
/// 예시:
/// ```dart
/// TodoForm(
///   initialTodo: existingTodo,
///   onSubmit: (title, description) {
///     // Todo 저장 로직
///   },
///   onCancel: () {
///     // 취소 로직
///   },
/// )
/// ```
class TodoForm extends StatefulWidget {
  /// 초기 Todo 값
  ///
  /// 수정 모드에서 기존 Todo 값을 표시할 때 사용합니다.
  /// null일 경우 새 Todo 생성 모드입니다.
  final Todo? initialTodo;

  /// 폼 제출 콜백
  ///
  /// 제목과 설명을 파라미터로 받습니다.
  final void Function(String title, String? description) onSubmit;

  /// 취소 콜백
  ///
  /// 취소 버튼 클릭 시 호출됩니다.
  final VoidCallback? onCancel;

  /// TodoForm 생성자
  ///
  /// [initialTodo] 초기 Todo 값 (선택사항)
  /// [onSubmit] 폼 제출 콜백 (필수)
  /// [onCancel] 취소 콜백 (선택사항)
  const TodoForm({
    super.key,
    this.initialTodo,
    required this.onSubmit,
    this.onCancel,
  });

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  String? _titleError;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.initialTodo?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialTodo?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// 제목 유효성 검증
  ///
  /// 제목이 비어있지 않은지 확인합니다.
  void _validateTitle(String value) {
    setState(() {
      _titleError = value.trim().isEmpty ? '제목은 필수입니다.' : null;
    });
  }

  /// 폼 제출 처리
  ///
  /// 유효성 검증을 수행하고, 통과하면 onSubmit 콜백을 호출합니다.
  void _handleSubmit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    _validateTitle(title);

    if (_titleError == null && title.isNotEmpty) {
      widget.onSubmit(title, description.isEmpty ? null : description);
    } else {
      // 유효성 검증 실패 로그는 필요 시 추가 가능
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          label: '제목',
          hint: '할일 제목을 입력하세요',
          controller: _titleController,
          errorText: _titleError,
          onChanged: _validateTitle,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: '설명',
          hint: '할일 설명을 입력하세요 (선택사항)',
          controller: _descriptionController,
          maxLines: 3,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (widget.onCancel != null) ...[
              CustomButton(
                text: '취소',
                style: CustomButtonStyle.secondary,
                onPressed: widget.onCancel,
              ),
              const SizedBox(width: 8),
            ],
            CustomButton(
              text: widget.initialTodo == null ? '추가' : '수정',
              onPressed: _handleSubmit,
            ),
          ],
        ),
      ],
    ),
  );
}
