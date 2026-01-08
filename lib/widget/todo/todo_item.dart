import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/todo.dart';

/// Todo 목록의 개별 항목을 표시하는 위젯
///
/// Todo 정보를 표시하고, 클릭 시 상세 정보를 보여줍니다.
/// 완료 상태에 따라 시각적으로 구분됩니다.
///
/// 주요 특징:
/// - Todo 정보 표시 (제목, 설명, 완료 상태)
/// - 클릭 이벤트 처리
/// - 삭제 버튼 지원
/// - 완료 상태 시각화
/// - Props 기반 설계
///
/// 예시:
/// ```dart
/// TodoItem(
///   todo: todo,
///   onTap: () => navigateToDetail(todo.id),
///   onDelete: () => deleteTodo(todo.id),
/// )
/// ```
class TodoItem extends StatelessWidget {
  /// 표시할 Todo 객체
  ///
  /// 필수 파라미터입니다.
  final Todo todo;

  /// 항목 클릭 시 실행될 콜백
  ///
  /// null일 경우 클릭 이벤트가 처리되지 않습니다.
  final VoidCallback? onTap;

  /// 삭제 버튼 클릭 시 실행될 콜백
  ///
  /// null일 경우 삭제 버튼이 표시되지 않습니다.
  final VoidCallback? onDelete;

  /// TodoItem 생성자
  ///
  /// [todo] 표시할 Todo 객체 (필수)
  /// [onTap] 항목 클릭 시 실행될 콜백 (선택사항)
  /// [onDelete] 삭제 버튼 클릭 시 실행될 콜백 (선택사항)
  const TodoItem({
    super.key,
    required this.todo,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // 완료 상태 체크박스
                Checkbox(
                  value: todo.isCompleted,
                  onChanged: onTap != null ? (_) => onTap?.call() : null,
                ),
                const SizedBox(width: 12),
                // Todo 정보
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: todo.isCompleted
                              ? Colors.grey
                              : Colors.black87,
                        ),
                      ),
                      if (todo.description != null &&
                          todo.description!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          todo.description!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 8),
                      // 날짜 정보 표시
                      Row(
                        children: [
                          if (todo.startDate != null) ...[
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '시작: ${DateFormat('yyyy-MM-dd').format(todo.startDate!)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            if (todo.endDate != null) const SizedBox(width: 12),
                          ],
                          if (todo.endDate != null) ...[
                            Icon(
                              Icons.event,
                              size: 14,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '완료: ${DateFormat('yyyy-MM-dd').format(todo.endDate!)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ],
                        ],
                      ),
                      // 완료 여부 표시
                      if (todo.isCompleted) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '완료됨',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // 삭제 버튼
                if (onDelete != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red,
                    onPressed: onDelete,
                    tooltip: '삭제',
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}
