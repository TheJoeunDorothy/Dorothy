import 'dart:convert';
import 'package:dorothy/viewmodel/log_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

// class LogScreen extends StatelessWidget {
//   const LogScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     LogVm logController = Get.find<LogVm>();
//     return Obx(
//       () => IntroductionScreen(
//         globalHeader: AppBar(
//           title: Text(logController.log.value.datetime!),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.share),
//               tooltip: '공유하기',
//               onPressed: () {
//                 if(logController.nowImage.value == ""){
//                   logController.nowImage.value = logController.log.value.personalimage!;
//                 }
//                 logController.shareImage(logController.nowImage.value);
//               },
//             ),
//           ],
//         ),
//         onChange: (index) {
//           logController.nowImage.value = (index == 0
//               ? logController.log.value.personalimage
//               : logController.log.value.ageimage)!;
//         },
//         pages: getPages(),
//         showSkipButton: false,
//         showNextButton: false,
//         showDoneButton: false,
//       ),
//     );
//   }

//   List<PageViewModel> getPages() {
//     LogVm logController = Get.find<LogVm>();
//     return [
//       PageViewModel(
//         title: "",
//         bodyWidget: const Text('퍼스널 컬러 결과 이미지'),
//         image: Image.memory(
//           base64Decode(logController.log.value.personalimage!),
//           fit: BoxFit.contain,
//         ),
//         decoration: const PageDecoration(
//           imageFlex: 6,
//           bodyFlex: 1,
//           pageColor: Colors.white,
//           bodyPadding: EdgeInsets.all(0),
//         ),
//       ),
//       PageViewModel(
//         title: "",
//         bodyWidget: const Text('나이 예측 결과 이미지'),
//         image: Image.memory(
//           base64Decode(logController.log.value.ageimage!),
//           fit: BoxFit.contain,
//         ),
//         decoration: const PageDecoration(
//           imageFlex: 6,
//           bodyFlex: 1,
//           pageColor: Colors.white,
//           bodyPadding: EdgeInsets.all(0),
//         ),
//       ),
//     ];
//   }
// }
