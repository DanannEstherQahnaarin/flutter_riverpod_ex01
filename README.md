# Flutter Todo 애플리케이션

Flutter와 Riverpod을 활용한 할일(Todo) 관리 애플리케이션입니다. 선언적 상태 관리와 모듈화된 아키텍처를 통해 확장 가능하고 유지보수가 용이한 코드 구조를 제공합니다.

## 📋 목차

- [프로젝트 소개](#프로젝트-소개)
- [주요 특징](#주요-특징)
- [주요 기능](#주요-기능)
- [기술 스택](#기술-스택)
- [아키텍처](#아키텍처)
- [실행 방법](#실행-방법)
- [프로젝트 구조](#프로젝트-구조)
- [문서](#문서)

---

## 프로젝트 소개

이 프로젝트는 Flutter 프레임워크와 Riverpod 상태 관리 라이브러리를 사용하여 개발된 할일 관리 애플리케이션입니다. 

### 개발 목적
- Flutter와 Riverpod을 활용한 실전 개발 경험 습득
- 선언적 상태 관리 패턴 학습
- 모듈화된 아키텍처 설계 및 구현
- 코드 재사용성과 유지보수성 향상

### 프로젝트 범위
- 할일 목록 조회 및 관리
- 할일 추가, 수정, 삭제 기능
- 할일 완료 상태 관리
- 시작일 및 완료일 관리
- 완료된 할일 조회 및 수정 제한

자세한 내용은 [PRD 문서](doc/PRD.md)를 참고하세요.

---

## 주요 특징

### 🎯 선언적 상태 관리
- **Riverpod**을 활용한 선언적 상태 관리
- 코드 생성 기반 Provider로 타입 안정성 보장
- 상태 변경 추적 및 디버깅 용이

### 🏗️ 모듈화된 아키텍처
- UI 코드와 비즈니스 로직의 명확한 분리
- 재사용 가능한 컴포넌트 설계
- 확장 가능한 구조

### 📝 체계적인 로깅
- 구조화된 로깅 시스템
- 다양한 로그 레벨 지원 (Debug, Info, Warning, Error)
- 성능 모니터링 및 에러 추적

### 📚 상세한 코드 문서화
- 모든 클래스와 함수에 대한 Dart 문서화 주석
- 사용 예시 및 파라미터 설명 포함
- 코드 가독성 및 유지보수성 향상

### ✅ 예외 처리
- 커스텀 예외 클래스를 통한 중앙화된 예외 관리
- 사용자 친화적인 에러 메시지 제공
- 예외 상황 로깅 및 추적

자세한 개발 규칙은 [RULES 문서](doc/RULES.md)를 참고하세요.

---

## 주요 기능

### 1. 할일 목록 관리
- 할일 목록 조회 및 표시
- 할일 추가, 수정, 삭제
- 완료 상태 표시 및 관리
- 시작일 및 완료일 표시

### 2. 할일 추가
- 제목 및 설명 입력
- 시작일 및 완료일 선택 (선택사항)
- 유효성 검증 (제목 필수, 시작일 ≤ 완료일)
- 팝업 형태의 입력 화면

### 3. 할일 수정
- 기존 할일 정보 수정
- 완료된 할일은 조회만 가능 (수정 불가)
- 수정 불가 시 안내 메시지 표시

### 4. 할일 삭제
- 할일 삭제 기능
- 삭제 확인 다이얼로그 제공
- 안전한 삭제 프로세스

### 5. 완료 상태 관리
- 할일 완료 상태 토글
- 완료 상태 변경 시 완료일 자동 설정
- 완료된 할일 시각적 구분 (회색 처리, 취소선)

### 6. 날짜 관리
- 시작일 및 완료일 선택 기능
- 날짜 유효성 검증
- 날짜 포맷팅 및 표시

자세한 기능 명세는 [PRD 문서](doc/PRD.md)를 참고하세요.

---

## 기술 스택

### 프레임워크 및 언어
- **Flutter**: 크로스 플랫폼 모바일 앱 개발 프레임워크
- **Dart**: Flutter의 프로그래밍 언어 (SDK ^3.10.1)

### 상태 관리
- **Riverpod** (^3.1.0): 선언적 상태 관리 라이브러리
- **flutter_riverpod** (^3.1.0): Flutter와 Riverpod 통합
- **riverpod_annotation** (^4.0.0): 코드 생성 기반 Provider 어노테이션

### 유틸리티
- **logger** (^2.0.0): 구조화된 로깅 기능
- **intl** (^0.19.0): 국제화 및 날짜/시간 포맷팅

### 개발 도구
- **flutter_lints** (^6.0.0): Flutter 권장 린트 규칙
- **build_runner**: 코드 생성 도구
- **riverpod_generator**: Riverpod Provider 코드 생성

### 지원 플랫폼
- Android
- iOS
- Web
- Windows
- macOS
- Linux

---

## 아키텍처

### 디렉토리 구조

```
lib/
├── exception/          # 예외 처리 클래스
│   ├── app_exception.dart
│   └── todo_exception.dart
├── model/              # 데이터 모델
│   └── todo.dart
├── provider/           # 상태 관리 (Riverpod Provider)
│   ├── todo_provider.dart
│   └── todo_provider.g.dart
├── screen/             # UI 화면
│   ├── todo_list.dart
│   ├── todo_add.dart
│   └── todo_edit.dart
├── service/            # 비즈니스 서비스 로직 (향후 확장)
├── utils/              # 유틸리티
│   └── logger.dart
└── widget/             # 재사용 가능한 UI 컴포넌트
    ├── common/         # 공통 컴포넌트
    │   ├── custom_button.dart
    │   ├── custom_text_field.dart
    │   └── loading_indicator.dart
    ├── dialog/          # 다이얼로그
    │   ├── confirm_dialog.dart
    │   └── error_dialog.dart
    └── todo/            # Todo 관련 위젯
        ├── todo_form.dart
        └── todo_item.dart
```

### 아키텍처 패턴

#### 1. 계층 분리
- **Presentation Layer** (`screen/`, `widget/`): UI 렌더링 및 사용자 인터랙션
- **Business Logic Layer** (`provider/`): 상태 관리 및 비즈니스 로직
- **Data Layer** (`model/`): 데이터 모델 및 변환

#### 2. 상태 관리
- Riverpod Provider를 통한 전역 상태 관리
- 코드 생성 기반으로 타입 안정성 보장
- 상태 변경 추적 및 로깅

#### 3. 컴포넌트 모듈화
- 재사용 가능한 위젯 컴포넌트
- Props 기반 설계
- 공통 컴포넌트 라이브러리

#### 4. 예외 처리
- 커스텀 예외 클래스 계층 구조
- 중앙화된 예외 관리
- 사용자 친화적인 에러 메시지

자세한 아키텍처 설계는 [RULES 문서](doc/RULES.md)를 참고하세요.

---

## 실행 방법

### 사전 요구사항
- Flutter SDK (^3.10.1 이상)
- Dart SDK (^3.10.1 이상)
- Android Studio / VS Code (선택사항)
- Git

### 설치 및 실행

#### 1. 프로젝트 클론
```bash
git clone <repository-url>
cd flutter_riverpod_ex01
```

#### 2. 의존성 설치
```bash
flutter pub get
```

#### 3. 코드 생성 (Riverpod Provider)
```bash
dart run build_runner build --delete-conflicting-outputs
```

#### 4. 애플리케이션 실행

**Android 에뮬레이터 또는 실제 기기:**
```bash
flutter run
```

**iOS 시뮬레이터 (macOS만 가능):**
```bash
flutter run -d ios
```

**웹 브라우저:**
```bash
flutter run -d chrome
```

**Windows:**
```bash
flutter run -d windows
```

**macOS:**
```bash
flutter run -d macos
```

**Linux:**
```bash
flutter run -d linux
```

### 개발 모드 실행
```bash
flutter run --debug
```

### 릴리스 빌드
```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web

# Windows
flutter build windows
```

### 코드 분석
```bash
flutter analyze
```

### 테스트 실행
```bash
flutter test
```

자세한 실행 가이드는 [TEST_GUIDE 문서](doc/TEST_GUIDE.md)를 참고하세요.

---

## 프로젝트 구조

### 주요 파일 설명

#### 모델 (`lib/model/`)
- **todo.dart**: Todo 데이터 모델 클래스
  - 불변(immutable) 데이터 클래스
  - 유효성 검증 메서드
  - JSON 직렬화/역직렬화

#### Provider (`lib/provider/`)
- **todo_provider.dart**: Todo 상태 관리 Provider
  - Todo 목록 관리
  - CRUD 작업 처리
  - 상태 변경 로깅

#### 화면 (`lib/screen/`)
- **todo_list.dart**: 할일 목록 화면
- **todo_add.dart**: 할일 추가 화면
- **todo_edit.dart**: 할일 수정 화면

#### 위젯 (`lib/widget/`)
- **common/**: 공통 재사용 컴포넌트
- **dialog/**: 다이얼로그 컴포넌트
- **todo/**: Todo 관련 위젯

#### 예외 처리 (`lib/exception/`)
- **app_exception.dart**: 기본 예외 클래스
- **todo_exception.dart**: Todo 관련 예외 클래스

#### 유틸리티 (`lib/utils/`)
- **logger.dart**: 로깅 유틸리티

---

## 문서

프로젝트의 상세한 문서는 `doc/` 폴더에 있습니다:

- **[PRD.md](doc/PRD.md)**: 제품 요구사항 문서
  - 프로젝트 개요 및 목적
  - 기능 명세
  - 기술 스택 상세 설명
  - 로깅 및 코드 문서화 가이드

- **[RULES.md](doc/RULES.md)**: 개발 규칙 및 코딩 표준
  - UI/비즈니스 로직 분리 원칙
  - 예외 처리 규칙
  - 컴포넌트 모듈화 가이드
  - 패키지 관리 규칙
  - Dart lint 규칙

- **[TASK.md](doc/TASK.md)**: 개발 작업 단계별 가이드
  - 프로젝트 환경 설정
  - 아키텍처 구성
  - 단계별 구현 가이드
  - 완료 체크리스트

- **[TEST_GUIDE.md](doc/TEST_GUIDE.md)**: 테스트 가이드
  - 기능 테스트 절차
  - UI/UX 테스트
  - 예외 처리 테스트
  - 로깅 검증

- **[FINAL_REPORT.md](doc/FINAL_REPORT.md)**: 최종 검증 보고서
  - PRD 준수 검증
  - RULES 준수 검증
  - 코드 리뷰 체크리스트

---

## 라이선스

이 프로젝트는 학습 및 교육 목적으로 개발되었습니다.

---

## 기여

이 프로젝트는 학습 목적으로 개발되었으며, 개선 사항이나 버그 리포트는 언제든지 환영합니다.

---

**마지막 업데이트**: 2026년
