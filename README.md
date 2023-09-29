
---
## 쥬스 메이커
``
앱을 실행하면 쥬스 주문이 가능한 창이 나오고 해당하는 버튼을 누르게되면 과일의 제고가 줄어들며 쥬스가 나왔다는 메시지를 출력해주는 앱. 재고수정 창을 통하여 재고수정이 가능.
``

---
### 목차
- [팀원](#팀원)
- [타임라인](#타임라인)
- [시각화 구조](#시각화-구조)
- [실행 화면](#실행-화면)
- [트러블 슈팅](#트러블-슈팅)
- [참고 링크](#참고-링크)
- [팀 회고](#팀-회고)

---
### 팀원
|Hisop|Morgan|
|---|---|
|[GitHub](https://github.com/Hi-sop)|[GitHub](https://github.com/devjoon)|

### 타임라인
|날짜|내용|
|------|---|
|23.09.11|요구사항 확인 , 계획 수립|
|23.09.12|FruitStore 구현, enum 타입 구현, JuiceMaker 기본 메서드 구현|
|23.09.13|enum 타입을 상세하게 분리|
|23.09.14|juiceMaker를 class로 변경, 레시피 반환 함수 생성 |
|23.09.18|FruitList 싱글톤으로 변경, notification 추가 및 테스트, Botton 추가|
|23.09.19|Alert 추가|
|23.09.22|버튼 메서드 분리, 매직리터럴 제거|
|23.09.23|private추가, 매직리터럴 제거, if-let 중복 사용된 부분 반복문으로 변경|
|23.09.25|enum String -> static을 사용한 네임스페이스로 변경|
|23.09.26|딕셔너리로 관리하던 Label을 Collection으로 관리|
|23.09.28|중복되는 부분 메서드로 분리|
|23.09.29|FruitCountLabels를 정렬해주는 코드를 함수로 처리|


### 시각화 구조

#### 시퀀스 다이어그램
![시퀀스 다이어그램](https://cdn.discordapp.com/attachments/1149152742875615303/1156405279307608114/ffeb5c5c0dbbfc7e.png?ex=65177cd7&is=65162b57&hm=7e1683d1a3ca440c758c11a7431ab13ba80a25d0bece0fb34bfc87b13fdec0be&)

#### 클래스 다이어그램
![클래스 다이어그램](https://cdn.discordapp.com/attachments/1149152742875615303/1156421648036134972/Class.png?ex=65178c16&is=65163a96&hm=bf2d745a2ceb9011d17f82a3093c43f7d45d953edf7f9df6e1eaf8b445fbe016&)

   
### 실행 화면
|주스주문, 재고부족 수정창 이동|
|---|
|![](https://github.com/devjoon/ios-juice-maker/assets/101351216/7f44117b-7f0e-44d5-bea8-ec7cb3a739ba)|

|재고수정 창 이동, 재고 수정후 닫기|
|---|
|![](https://github.com/devjoon/ios-juice-maker/assets/101351216/b7a70c60-33bf-4a25-8c25-0e6a9a448e92)|
   
### 트러블 슈팅

#### 1. Modality Present
과일의 재고를 관리하는 화면을 띄우는 것은 흐름, 계층과 관계 없는 동작이라고 판단하여 새 창을 띄우는 ```Modality Present```를 선택했다.
기존에 알고 있던 Moality방식은 창을 모두 덮지 않고, 사용자가 끌어 내리면 이전 화면으로 돌아갈 수 있는 기능을 지원했는데 이 프로젝트는 그렇게 동작하지 않았다.

**modality를 커스텀하는 아이디어**
```UiSheetPresentationController```를 사용해 커스텀 할 수 있다는 정보를 찾았다. 하지만 iOS 15.0이상부터 지원한다는 문제가 있었고, 당장 이 프로젝트만 해결할 것이라면 문제 없는 선택이었지만 디자인적인 부분만을 위해 iOS 15이하를 사용하는 사용자들을 모두 배제하는 판단은 좋지 않은 방향이라 느꼈다.

**가로화면을 지원하지 않음**
page방식을 어떻게 변경해서 전달해주어도 화면 전체를 덮는 방식으로 구현되었다.
원인은 Modality 방식이 가로화면에선 일부 기능을 지원하지 않고 풀스크린으로 실행된다는 것이었다.
테스트하기 위해 해당 프로젝트 옵션에서 회전 옵션을 활성화했고, 세로모드에서 정상 동작함을 확인했다.

#### 2. KVO / Notification Center / Delegate pattern 선택
Model의 FruitStore가 관리하고 있는 재고를 ViewController가 알수있게 해야했다. 위 방식 이외에도 getter 메서드를 만들거나, private(set)으로 선언하는 등 다양한 옵션이 있었다.

**KVO**
첫번째로 시도했던 방식으로 재고의 개수가 변한다면 ViewController가 옵저빙하여 NewValue와 oldValue를 통해 업데이트 시켜준다는 아이디어였다.
딕셔너리 타입은 KVO를 지원하지 않아서 실패.

**Notification Center**
재고를 변경함과 동시에 Notification에 post하면 컨트롤해야하는 두개의 뷰컨트롤러가 동시에 옵저빙 할 수 있다는 생각으로 채택해보았다.
실제로 위 동작을 수행할 수 있었으나 재고관리 페이지의 효율적인 관리를 위해 main에서만 옵저빙하도록 수정하였다.

**Delegate pattern**
재고관리 페이지에선 사용자의 클릭 한번마다 재고가 변경되어야 했으므로 동시에 Store의 재고를 변경시키는 구조는 비효율적이라 생각했고, 창을 닫을 때 마지막 재고 현황을 Store의 재고에 반영시키는 방식으로 변경했다. 이 과정에서 MainVC에 재고를 전달하는 방식으로 Delegate pattern을 채택했다.

**코드**
```swift
protocol manageStockDelegate {
    func updateStock(fruitList: [Fruit: Int])
}

func updateStock(fruitList: [Fruit: Int]) {
        juiceMaker.fruitStore.updateStock(modifiedList: fruitList)
    }

fruitStoreViewController.delegate = self

//서브 VC에서의 선언과 호출
var delegate: manageStockDelegate?

delegate?.updateStock(fruitList: fruitList)
```

#### 3. 최초 실행시 재고 값을 가져오는 방법
재고를 가져오는 방법으로 Notification Center의 UserInfo를 채택했다.
첫 화면이 출력될 때도 재고를 표시해줘야 했으므로 FruitStore의 init시점에 post를 전달하는 것으로 처리으나 VC에서의 옵저버 설정이 되어있지 않은 상태로 notification이 동작하지 않았다.
notification은 알림을 발생시키는 역할로만 사용하고 재고는 private(set)타입으로 변경하여 바로 접근 해 갱신하도록 변경하였다.

**옵저빙 설정 시점**
당시에는 단순히 불러오는 방식을 변경하는 것으로 해결했으나 옵저빙 설정을 하는 시점을 변경했다면 해결되었을 것이라는 생각이 든다.

VC도 결국 class인데 viewDidLoad에서 초기화 할 생각만 가지고 있었다.
VC의 init을 이용한다면 다르지 않았을까 생각됨.

### 참고 링크
[Swift Protocol 공식문서](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/)  
[Swift Delegate 공식문서](https://developer.apple.com/documentation/uikit/uiapplication/1622936-delegate)  
[Swift Notifivationcenter 공식문서](https://developer.apple.com/documentation/foundation/notificationcenter)  

---
### 팀 회고
<details>
<summary>우리팀이 잘한 점</summary>
시간 약속을 잘지키며 약속을 정할때 서로서로 잘 맞춰줌, 궁금한(실험해보고싶은)내용이 있다면 다양한 시도를 해보려고 함<br> 의견 차이 발생시 쉽게 타협이 가능함
    
</details>

<details>
<summary>우리팀이 개선할 점</summary>
아직 네이밍을 고민하는 부분에서 시간이 많이 소요되었고 피드백을 받는 과정에서도 많은 지적이 발생, 이부분은 앞으로 프로그래밍을 해 나가면서 나아질 수 있을것이라고 생각됨

코딩 컨벤션에 관해서도 사소한 실수 발생, 이 부분또한 3번째 프로젝트에 와 가면서 많이 나아지고 있기때문에 앞으로 더 진행을 하면서 줄일 수 있을것이라고 생각됨. 
</details>

<details>
<summary>서로에게 피드백</summary>
Morgan: Hisop의 경우 Swift 뿐 아니라 프로그래밍에 대한 전반적인 이해가 뛰어나셔서 같이 작업하면서 막힘없이 진행하는 모습을 많이 보여주셨습니다. 덕분에 3주의 시간동안 많이 배울수 있었고 다음에 다시 작업하게된다면 저도 많이 성장해서 서로 빠르게 의견을 나누면서 작업 할 수 있었으면 좋겠습니다.<br>
Hisop: 뭔가 의견을 제시했을때 너무 흔쾌히 따라주셔서 좋았습니다. 쓸데없는 고집이나 개인적인 습관에 의한 컨벤션을 제시했을때도 일단 해보자고 하셔서 부담없이 의견을 제시할 수 있었습니다. 재미있었어요.
    
</details>










