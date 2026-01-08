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
  /// 제목, 설명, 시작 일자, 완료 일자를 파라미터로 받습니다.
  final void Function(
    String title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
  )
  onSubmit;

  /// 취소 콜백
  ///
  /// 취소 버튼 클릭 시 호출됩니다.
  final VoidCallback? onCancel;

  /// 읽기 전용 모드
  ///
  /// true일 경우 폼이 읽기 전용으로 표시되며 수정할 수 없습니다.
  /// 완료된 Todo를 조회할 때 사용됩니다.
  final bool readOnly;

  /// TodoForm 생성자
  ///
  /// [initialTodo] 초기 Todo 값 (선택사항)
  /// [onSubmit] 폼 제출 콜백 (필수)
  /// [onCancel] 취소 콜백 (선택사항)
  /// [readOnly] 읽기 전용 모드 (기본값: false)
  const TodoForm({
    super.key,
    this.initialTodo,
    required this.onSubmit,
    this.onCancel,
    this.readOnly = false,
  });

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;
  String? _titleError;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.initialTodo?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialTodo?.description ?? '',
    );
    _startDate = widget.initialTodo?.startDate;
    _endDate = widget.initialTodo?.endDate;
    _startDateController = TextEditingController(
      text: _startDate != null
          ? '${_startDate!.year}-${_startDate!.month.toString().padLeft(2, '0')}-${_startDate!.day.toString().padLeft(2, '0')}'
          : '',
    );
    _endDateController = TextEditingController(
      text: _endDate != null
          ? '${_endDate!.year}-${_endDate!.month.toString().padLeft(2, '0')}-${_endDate!.day.toString().padLeft(2, '0')}'
          : '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
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

  /// 시작 일자 선택
  ///
  /// 날짜 선택 다이얼로그를 표시하고 선택한 날짜를 설정합니다.
  Future<void> _selectStartDate() async {
    if (widget.readOnly) return;

    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
        _startDateController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
        // 시작일이 완료일보다 늦으면 완료일 초기화
        if (_endDate != null && _startDate!.isAfter(_endDate!)) {
          _endDate = null;
          _endDateController.clear();
        }
      });
    }
  }

  /// 완료 일자 선택
  ///
  /// 날짜 선택 다이얼로그를 표시하고 선택한 날짜를 설정합니다.
  /// 시작일보다 이전 날짜는 선택할 수 없습니다.
  Future<void> _selectEndDate() async {
    if (widget.readOnly) return;

    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _endDate = picked;
        _endDateController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  /// 폼 제출 처리
  ///
  /// 유효성 검증을 수행하고, 통과하면 onSubmit 콜백을 호출합니다.
  /// 날짜 정보도 함께 전달합니다.
  void _handleSubmit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    _validateTitle(title);

    // 날짜 유효성 검증
    if (_startDate != null && _endDate != null) {
      if (_startDate!.isAfter(_endDate!)) {
        setState(() {
          _titleError = '시작 일자는 완료 일자보다 늦을 수 없습니다.';
        });
        return;
      }
    }

    if (_titleError == null && title.isNotEmpty) {
      // 날짜 정보를 포함하여 onSubmit 호출
      widget.onSubmit(
        title,
        description.isEmpty ? null : description,
        _startDate,
        _endDate,
      );
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
          onChanged: widget.readOnly ? null : _validateTitle,
          readOnly: widget.readOnly,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: '설명',
          hint: '할일 설명을 입력하세요 (선택사항)',
          controller: _descriptionController,
          maxLines: 3,
          readOnly: widget.readOnly,
        ),
        const SizedBox(height: 16),
        // 시작 일자 선택
        CustomTextField(
          label: '시작 일자',
          hint: '시작 일자를 선택하세요 (선택사항)',
          controller: _startDateController,
          readOnly: true,
          onTap: widget.readOnly ? null : _selectStartDate,
        ),
        const SizedBox(height: 16),
        // 완료 일자 선택
        CustomTextField(
          label: '완료 일자',
          hint: '완료 일자를 선택하세요 (선택사항)',
          controller: _endDateController,
          readOnly: true,
          onTap: widget.readOnly ? null : _selectEndDate,
        ),
        const SizedBox(height: 24),
        if (!widget.readOnly)
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
