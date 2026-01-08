import 'package:flutter/material.dart';

/// 재사용 가능한 로딩 인디케이터 위젯
///
/// 비동기 작업 중 사용자에게 로딩 상태를 표시하는 위젯입니다.
/// 다양한 크기와 메시지를 지원합니다.
///
/// 주요 특징:
/// - 다양한 크기 지원
/// - 선택적 메시지 표시
/// - 재사용 가능한 구조
///
/// 예시:
/// ```dart
/// LoadingIndicator(
///   message: '로딩 중...',
///   size: LoadingSize.medium,
/// )
/// ```
class LoadingIndicator extends StatelessWidget {
  /// 로딩 메시지
  ///
  /// 로딩 인디케이터 아래에 표시될 메시지입니다.
  /// null일 경우 메시지가 표시되지 않습니다.
  final String? message;

  /// 로딩 인디케이터 크기
  ///
  /// 기본값은 LoadingSize.medium입니다.
  final LoadingSize size;

  /// LoadingIndicator 생성자
  ///
  /// [message] 로딩 메시지 (선택사항)
  /// [size] 로딩 인디케이터 크기 (기본값: LoadingSize.medium)
  const LoadingIndicator({
    super.key,
    this.message,
    this.size = LoadingSize.medium,
  });

  /// 크기에 따른 인디케이터 크기 반환
  ///
  /// [size] 로딩 인디케이터 크기
  ///
  /// Returns 인디케이터 크기
  double _getIndicatorSize(LoadingSize size) {
    switch (size) {
      case LoadingSize.small:
        return 24.0;
      case LoadingSize.medium:
        return 48.0;
      case LoadingSize.large:
        return 72.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final indicatorSize = _getIndicatorSize(size);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: indicatorSize,
            height: indicatorSize,
            child: const CircularProgressIndicator(),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 로딩 인디케이터 크기 열거형
///
/// 로딩 인디케이터의 크기를 정의합니다.
enum LoadingSize {
  /// 작은 크기
  small,

  /// 중간 크기 (기본값)
  medium,

  /// 큰 크기
  large,
}
