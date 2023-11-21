# Dorothy

Flutter를 사용하여 제작한 iOS용 모바일 어플리케이션입니다.    
얼굴 사진 한 장으로 퍼스널컬러 진단과 얼굴 나이 예측 서비스를 제공합니다.   
피부 톤을 바탕으로 AI 모델을 활용하여 퍼스널 컬러를 진단하며   
3만장의 데이터를 학습한 AI 모델을 활용하여 얼굴 나이를 예측합니다.


# 어플리케이션 목업
![mockup](https://github.com/TheJoeunDorothy/Dorothy/assets/130451718/e0259a08-cdd0-4750-a102-51dcb834f9b6)


# 기능 설명

### 1. 도로시 홈 화면

<div style="display: flex; justify-content: space-between;">
    <img alt="color_screen" src="https://github.com/TheJoeunDorothy/Dorothy/assets/130552875/b2e03505-0581-4042-9a9d-cdd6b2a06736" width="30%">
    <img alt="camera_screen" src="https://github.com/TheJoeunDorothy/Dorothy/assets/130552875/ffb04ec6-cdc2-45af-a51e-0bbc4a73fdc3" width="30%">
    <img alt="age_screen" src="https://github.com/TheJoeunDorothy/Dorothy/assets/130552875/73f0b542-d124-4d82-a042-58234d20d81f" width="30%">
</div>

<br>

- 카메라에 표시된 영역에 얼굴을 맞추면 촬영 버튼이 활성화됩니다.   
- 상단의 ⓘ 버튼을 누르면 예측이 잘 되는 사진 예시를 확인 가능합니다.
- 상단의 설정 버튼을 누르면 설정 화면으로 이동합니다.

### 2. 퍼스널 컬러 진단 결과 화면

<img alt="color_screen" src="https://github.com/TheJoeunDorothy/Dorothy/assets/130552875/8688fe68-8ca1-4a15-8278-4390aaae8493" width="30%">

<br>

- 퍼스널 컬러 진단 결과를 확인하실 수 있습니다.
- 결과는 봄 웜톤, 여름 쿨톤, 가을 웜톤, 겨울 쿨톤 4가지로 분류됩니다.
- 진단된 퍼스널컬러 결과에 따라 다른 배경색이 노출됩니다.
- 공유하기 버튼으로 결과 화면 캡처 이미지를 공유하실 수 있습니다.

### 3. 나이 예측 결과 화면

<img alt="color_screen" src="https://github.com/TheJoeunDorothy/Dorothy/assets/130552875/148852ac-a221-4eca-accb-d67b2fc49bd9" width="30%">

<br>

- 얼굴 나이 예측 결과를 확인하실 수 있습니다.
- 결과는 10대부터 70대까지 7가지로 분류됩니다.
- 예측된 나이 예측 결과는 연령대별 퍼센트로 노출됩니다.
- 공유하기 버튼으로 결과 화면 캡처 이미지를 공유하실 수 있습니다.

### 4. 설정 화면

<img alt="color_screen" src="https://github.com/TheJoeunDorothy/Dorothy/assets/130552875/b3987de5-c615-4044-aa85-463e35252609" width="30%">


<br>

- 서비스 이용 약관 항목에서 서비스 이용 약관을 확인하실 수 있습니다.
- 사용 기록 항목에서 이전 결과 기록들을 확인하실 수 있습니다.
- 잠금 모드를 활성화하면 iPhone의 TouchID, FaceID, 암호 등을 통해 사용 기록 잠금이 가능합니다.

### 5. 사용 기록 화면

<img alt="color_screen" src="https://github.com/TheJoeunDorothy/Dorothy/assets/130552875/caf01135-1f37-4f61-95d7-682317419e42" width="30%">

<br>

- 얼굴 사진 결과를 도로시 앱에 저장합니다.
- 사용 기록 타일을 터치하면 결과 화면과 동일한 화면을 보실 수 있습니다.
- 사용 기록 타일을 왼쪽으로 슬라이드하면 기록을 삭제하실 수 있습니다.
- 상단의 휴지통 아이콘으로 저장된 모든 기록 삭제가 가능합니다.


# Flow Chart
![dorothy_flow_chart](https://github.com/TheJoeunDorothy/Dorothy/assets/130552875/93345131-902b-4ba2-8c17-befb0537f119)



# 사용한 패키지
```yaml
# 상태 관리
get: ^4.6.6
# 환경 변수 관리
flutter_dotenv: ^5.1.0
# 토큰 값 저장
shared_preferences: ^2.2.2
# 카메라
camera: ^0.10.5+5
# 갤러리
image_picker: ^1.0.4
# splash 추가
animated_splash_screen: ^1.3.0
# 앱 아이콘 관리
flutter_launcher_icons: ^0.13.1
# HTTP Request
http: ^1.1.0
# 반응형 앱 화면 구성
flutter_screenutil: ^5.9.0
# 구글 폰트
google_fonts: ^6.1.0
# 카메라, 알림 등 권한 요청
permission_handler: ^11.0.1
# 카메라 얼굴 인식
google_mlkit_face_detection: ^0.9.0
# 온보딩 스크린
introduction_screen: ^3.1.12
# 이미지
image: ^4.1.3
# SQLite
sqflite: ^2.3.0
# DateTimeFormat
intl: ^0.18.1
# markdown 쓰기
flutter_markdown: ^0.6.18+2
# 구글 광고
google_mobile_ads: ^3.1.0
# 퍼센트 인디케이터
percent_indicator: ^4.2.3
# 파일 경로
path_provider: ^2.1.1
# 파일 공유
share_plus: ^7.2.1
# 앱 기능 잠금 기능
local_auth: ^2.1.7
# 카드 슬라이드 삭제
flutter_slidable: ^3.0.1
```


# 데이터베이스
    SQLITE  


# 시연 영상
<a href="https://drive.google.com/file/d/1JyNa9-KblflPKlbP4i5j0ed9QuL3vkuI/view?usp=sharing">
  <img src="https://github.com/TheJoeunDorothy/Dorothy/assets/130552875/b693b2e8-64be-4305-afec-330d0629e627" alt="이미지" height= "600">
</a>



# 기술 스택
<img src="https://skillicons.dev/icons?i=flutter,dart,git,github,vscode" /></a>



# 서버 깃허브 주소
https://github.com/TheJoeunDorothy/Dorothy_server_lambda
