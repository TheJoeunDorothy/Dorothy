import 'dart:typed_data';

import 'package:dorothy/viewmodel/log_vm.dart';
import 'package:dorothy/widget/info_slider_indicator.dart';
import 'package:dorothy/widget/result_slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final vm = Get.find<LogVM>();
  GlobalKey<_LogScreenState> key = GlobalKey<_LogScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기록 보기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RepaintBoundary(
              key: key,
              child: resultSliderWidget(vm),
            ),
            infoSliderIndicator(vm),
            CupertinoButton.filled(
              onPressed: () async {
                Uint8List? resultImageByte = await vm.captureImage(key:key);
                vm.shareImage(resultImageByte);
              },
              child: const Text('공유하기'),
            ),
          ],
        ),
      ),
    );
  }
}