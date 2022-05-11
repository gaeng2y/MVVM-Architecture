# MVVM-Architecture

[제 블로그 정리](https://gaeng2y.medium.com/mvvm%EC%97%90-%EB%8C%80%ED%95%9C-%EC%A0%95%EC%9D%98%EC%99%80-%EA%B0%9C%EB%85%90-%ED%95%A5%EC%95%84%EB%B3%B4%EA%B8%B0-72b189c84b30)

## 개요
우선 MVVM에 대한 내용을 참고한 동영상은 스탠포드 강의를 참조했음을 말씀드리며 시작하겠습니다 ㅎㅎ

## MVC
MVVM을 톺아보기 전에 MVC를 먼저 간단하게 살펴보면 좋을 것 같습니다.

![전통적인 MVC 패턴](https://miro.medium.com/max/1400/0*WCDg9vbLjdz_YZGf.png)

MVC란 Model-View-Controller로 구성된 패턴으로 서로 너무 밀접하게 연관되어 있어서… 각각 독립성이 떨어지기 때문에 재사용성이 떨어진다는 문제가 있어서 전통적인 MVC 패턴은 iOS 개발에 적합하지 않다고 생각되었는지…

[애플은 CocoaMVC 구조를 제시했습니다.](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html)

![MVC의 정의를 나타낸 그림](https://miro.medium.com/max/1178/0*yVzhg5HafOSNyWia.png)

CocoaMVC는 Controller가 View와 Model의 중간자 역할로 View와 Model에 독립성을 주었습니다.

***그러나…***

Controller의 역할을 수행하는 UIViewController가 View를 포함하기도하고, View의 Life Cycle까지 관리하기 때문에 View와 Controller를 분리하기가 어렵고, 재사용도 어렵고, 테스트도 어렵다… (3어)

그래서 막상 적용해보면 아래와 같은 구조가 되어버린다고 볼 수 있다…

![Controller: (죽여줘…!)](https://miro.medium.com/max/1400/0*sIipVDYCVCtJyK3T.PNG)

그래서 Controller가 너무 많은 일을 하기 때문에 MVVM 이 제시된 것입니다..!

## MVVM이란?
나 iOS 개발자 MVVM이란 말을 지겹게 듣는다… 하지만 나는 잘 모른다…

![ㄴㅏ는 바보니까…](https://miro.medium.com/max/558/0*RB_fbqSCIlE9XcW9.jpg)

**MVVM(Model-View-ViewModel)**은 코드 구성인 설계 디자인 패러다임이다.

* MVVM은 보통 아키텍처라고도 부르고 디자인 패턴이라고도 부른다..
* 우선 저는 디자인 패러다임이라 말하겠습니다. (강의에서 그랬어…)
* 반응형 UI 개념과 함께 동작한다고 합니다.

**정리해보면**

UI / 비즈니스 로직을 서로 분리한다.
반응형 UI 컨셉과 함께 동작하는 디자인 패러다임(디자인 패턴, 아키텍처)
라고 말할 수 있습니다.

## MVVM 요소들?

![MVVM에 대해 한짤로 요약(강의에서 줍줍…)](https://miro.medium.com/max/1400/0*rVEv5bPK21zvpu_8)

MVVM에 요소는 세 가지다. 

### Model, View, ViewModel

## Model

* UI와 독립적이다.
* SwiftUI / UIKit을 import 하지 않는다.
* 앱이 수행하는 동작에 대한 데이터와 논리를 캡슐화하려고 한다.(Data + Logic)
* Model이 변경되었을 때는 ViewModel에게 알린다.

## View
* MVC에서 C를 MVVM에서 View로 취급
* 모든 UI 로직이 ViewModel에 있으므로 View/VC가 가벼워진다.
* View는 ViewModel을 참조한다.(반대는 X)
* View는 Model을 참조하지 않는다.(반대도 O)
* View는 Publication을 Subscribe하고, Observe 한다.

## ViewModel
* ViewModel을 통해 UI / 비즈니스 로직을 분리한다.
* ViewModel은 Model을 참조한다.(반대는 X)
* View 없이 테스트가 가능하다(MVVM을 많이 쓰는 이유)
* View inpurt으로부터 Model을 업데이트한다.
* Model이 변경되면 View에 반영(Model output으로부터 View 업데이트)
* View에 직접 이야기하지 않는다. 무언가 바뀌었다고 Publish한다.
* 모든 UI 컨트롤의 상태를 알려주는 프로퍼티들을 포함한다.

## MVC -> MVVM?
### 장점
* **복잡성 감소**: VC(View)가 가벼워진다! ViewModel에 로직이 들어가니까
* **전문화**: VC(View)가 더 이상 모델 유형에 의존하지 않고 View에만 초점을 맞춘다.
* **분리**: VC(View)는 입력을 보내거나 출력을 바인딩하여 ViewModel과만 상호작용한다.
* **표현형**: ViewModel은 비즈니스 로직을 낮은 수준의 뷰 로직과 분리한다.
* **유리 관리 기능**: VC(view)에 최소한의 수정으로 새 기능을 추가하는 것이 간단해진다.
* **테스트 가능**: ViewModel은 테스트하기가 비교적 쉽다.(위에서도 말했듯이 MVVM을 쓰는 이유 중에 하나이기도 하다)

### 고려해야할 점
* **Extra Type**: 앱 구조에 추가적으로 ViewModel 타입을 도입해야 한다.
* **바인딩 메커니즘**: 몇 가지 데이터 바인딩 수단이 필요하다(Box, Rx, Combine, etc…)
* **상용구(Boilerplate)**: MVVM을 구현하려면 추가 상용구가 필요하다
* **메모리**: ViewModel을 섞어서 도입할 때 메모리 관리 및 메모리 유지 주기를 인식해야 한다.
