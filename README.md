<img width="992" alt="스크린샷 2022-03-02 오후 3 53 58" src="https://user-images.githubusercontent.com/88618825/156310512-789e8d07-4646-4cb6-8749-5a86437720e1.png">


## 🔥 앱소개

#### 사용자의 위치를 기반으로 주변 새싹들을 검색하고, 매칭된 새싹과 채팅을 통해 취미를 공유할 수 있는 앱입니다.

* `Firebase Auth`를 이용한 문자인증을 통한 회원가입 로직
* `CLLocation`을 활용해 위치 권한에 따른 주변친구 찾기 분기처리
* `Custom Annotation`을 이용해 다양하 주변친구 MapView에 표현
* `Socket.IO`를 이용해 취미가 매칭되 상대방과 실시간을 채팅 구현
* `Notification`을 이용한 키보드 대응 `(키보드가 올라올 때 Layout 변경)`

<br>

## 📆 개발기간

#### 22.01.17 ~ 22.02.23
<br>

## 🏷 사용기술

* SnapKit
* Firebase Auth, Firebase CloudMessage
* URLSession, Socket.IO
* CLLocation, Mapkit
* Tabman, DoubleSlider
* MVVM, MVC

<br>

## 🔨 개발 기록 및 트러블 슈팅
| Date | Finished | Link |
| :-: | :-: | :-: |
| 2022-01-19 | `폰트+컬러 모듈화`, `타이머 구현` | [Link](https://github.com/Brandnew-one/SeSACFriends/blob/master/DevLog/2022-01-19.MD)|
| 2022-01-20 | `전화번호 정규표현식` | [Link](https://github.com/Brandnew-one/SeSACFriends/blob/master/DevLog/2022-01-20.MD)|
| 2022-02-04 | `ScrollView + StackView` ,`팝업화면 구현`, `DoubleSlider` | [Link](https://github.com/Brandnew-one/SeSACFriends/blob/master/DevLog/2022-02-05.MD)|
| 2022-02-08 | `키보드 Notification 대응`, `Self-Sizing CollectionViewCell` | [Link](https://github.com/Brandnew-one/SeSACFriends/blob/master/DevLog/2022-02-08.MD)|

<br>

***

### 회원가입 및 내 정보 로직

| 온보딩 | 회원가입 | 내 정보 |
| - | - | - |
| <img src = "https://user-images.githubusercontent.com/88618825/156317596-ceca5f40-5f07-438d-b95e-250eb9b0d65e.gif" height = "50%"> | <img src = "https://user-images.githubusercontent.com/88618825/156322569-bf5eb5e4-5797-46f5-b9e8-be7dc1410402.gif" height = "50%"> | <img src = "https://user-images.githubusercontent.com/88618825/156323543-921a51ab-ee85-4527-9bec-b3d31355f614.gif"> |


### 새싹 매칭 로직

| 주변새싹 찾기 | 새싹 매칭 |
| - | - |
| <img src = "https://user-images.githubusercontent.com/88618825/156322866-766bc57c-f3b2-4dcd-97ed-ff802fbba5ab.gif" height = "50%"> | <img src = "https://user-images.githubusercontent.com/88618825/156322874-d1498fe9-c7ba-44cc-9da3-97e1497704a6.gif" height = "50%"> |



### 채팅 및 매칭종료 로직

| 채팅 | 리뷰, 신고, 종료 |
| - | - |
| <img src = "https://user-images.githubusercontent.com/88618825/156323165-aa9e761a-aad7-4ca4-b0be-b5deddb44ac6.gif" height = "50%"> | <img src = "https://user-images.githubusercontent.com/88618825/156323171-8b5b8c44-2cbd-4ddb-b785-7db046398d2d.gif" > |

<br>

***

## 😤 회고

약 5주간의 프로젝트를 진행하면서 최선을 다했다고 생각하지만 개인적으로 아쉬움이 많이 남았다 ㅠ

> * 5주라는 시간은 생각보다 길었다! 프로젝트 기간을 절반을 나누어서 보면 확실히 후반부에 집중력이 많이 떨어진게 사실이다. 
> 다음부터는 프로젝트 기간이 길어지더라도 좀 더 구체적인 개발공수 산정을 통해서 적절한 위기감(?)을 느껴서 너무 풀어지 않도록 해야겠다.

> * 규모가 큰 프로젝트를 진행하면서 왜 개발자들이 클린코드 및 구조에 힘쓰는지 느꼈다. 1주차에 작성한 코드를 3주가 지나서 보니 내가 어떤 의도로 해다 메서드르 정의했었는지 기억이 나지 않았다.
> 만약 다른 iOS 개발자와 협업을 하거나 더 많은 시간이 흐른뒤 유지보수하는 상황을 생각하며 반성했다. 구현도 중요하지만 나와 동료들을 위해서 프로젝트 설계도 정말 중요하다는 것을 꺠달았다.

