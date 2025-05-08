# 아키텍처 패턴 비교: Clean Architecture, MVC, MVVM, VIPER

---

## 🧱 Clean Architecture

![Clean Architecture](https://tse2.mm.bing.net/th?id=OIP.7Ug5z2wSNV8IVZhaGNm5agHaHa&pid=Api)

**Clean Architecture**는 로버트 C. 마틴(Uncle Bob)이 제안한 구조로, 높은 응집도와 낮은 결합도를 가진 계층적 구조

### 🔹 구성 계층
- **Entities**: 핵심 비즈니스 모델 및 규칙
- **Use Cases**: 애플리케이션 전용 비즈니스 로직
- **Interface Adapters**: View, Controller, Presenter, Gateway 등 인터페이스 구성
- **Frameworks & Drivers**: UI, DB, 외부 프레임워크, 디바이스 등

### 🔹 특징
- 의존성은 항상 안쪽으로 흐른다 (Dependency Rule)
- 각 계층은 독립적이며 테스트가 용이하다
- 재사용성과 유지보수성이 뛰어나다

---

## 🧩 MVC (Model-View-Controller)

![MVC](https://tse4.mm.bing.net/th/id/OIP.qEvcN0R2prLvqG4nXoXUzwHaE9?cb=iwc1&pid=Api)

**MVC**는 전통적인 아키텍처 패턴으로, UI 구성 요소를 세 가지로 분리

### 🔹 구성 요소
- **Model**: 데이터, 비즈니스 로직
- **View**: 사용자 인터페이스
- **Controller**: 사용자 입력 처리 및 모델과 뷰 연결

### 🔹 특징
- 구조가 단순해 빠른 개발 가능
- 규모가 커질수록 Controller가 비대해지는 단점

---

## 🧠 MVVM (Model-View-ViewModel)

![MVVM](https://tse1.mm.bing.net/th?id=OIP.Svrf0AtDditnayXEALZtBwHaEp&cb=iwp1&pid=Api)

**MVVM**은 UI와 로직의 결합을 줄이기 위해 ViewModel을 도입한 구조

### 🔹 구성 요소
- **Model**: 데이터 및 도메인 로직
- **View**: 사용자 인터페이스
- **ViewModel**: Model을 가공하여 View에 제공 (데이터 바인딩)

### 🔹 특징
- 테스트 용이성 향상
- 복잡한 바인딩 로직이 존재할 수 있음
- SwiftUI와 같은 선언형 UI와 궁합이 좋음

---

## 🔄 VIPER (View, Interactor, Presenter, Entity, Router)

![VIPER](https://tse3.mm.bing.net/th/id/OIP.KP1-pcdSZiZ3GG4nxnTlkgHaEQ?pid=Api)

**VIPER**는 iOS 앱 개발을 위해 고안된 패턴으로, 각 역할을 분리하여 단일 책임 원칙(SRP)을 극대화

### 🔹 구성 요소
- **View**: 사용자 인터페이스
- **Interactor**: 비즈니스 로직 처리
- **Presenter**: View에 표시할 데이터 준비, View와 Interactor 중개
- **Entity**: 비즈니스 모델
- **Router (Wireframe)**: 화면 전환 처리

### 🔹 특징
- 테스트 및 모듈화에 매우 유리
- 구성 요소가 많아 구조가 복잡함
- 중·대형 iOS 프로젝트에서 효과적

---

## 📊 아키텍처 패턴 요약 비교

| 패턴 | 구성 요소 | 장점 | 단점 | 적합한 사용처 |
|------|-----------|------|------|----------------|
| **Clean Architecture** | Entities, UseCases, Interface Adapters, Frameworks | 유연하고 확장성 높음 | 설계 난이도 높음 | 대규모 시스템 |
| **MVC** | Model, View, Controller | 간단, 빠른 구현 | Controller 비대화 | 중소형 앱 |
| **MVVM** | Model, View, ViewModel | 테스트 용이, View 분리 | ViewModel 복잡 | SwiftUI 앱 |
| **VIPER** | View, Interactor, Presenter, Entity, Router | 모듈화 및 테스트 우수 | 초기 진입장벽 높음 | 복잡한 iOS 앱 |

---

> 📌 각 아키텍처 패턴은 프로젝트의 규모, 유지보수 필요성, 팀의 역량에 따라 적절히 선택되어야 함
