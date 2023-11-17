import 'dart:convert';

import 'package:dorothy/view/log_screen.dart';
import 'package:dorothy/viewmodel/log_vm.dart';
import 'package:dorothy/viewmodel/logs_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LogsScreen extends StatelessWidget {
  final LogsVM controller = Get.put(LogsVM());
  LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("usage_history_appbar".tr),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text(
                    'delete_alert_title'.tr,
                    style: const TextStyle(color: Colors.red),
                  ),
                  content: Text('delete_alert_content'.tr),
                  actions: [
                    TextButton(
                      child: Text(
                        "cancle_button".tr,
                        style: const TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Get.back(),
                    ),
                    Obx(
                      () => TextButton(
                        onPressed: controller.logs.isEmpty
                            ? null
                            : () async {
                                await controller.deleteAllLogs();
                                Get.back();
                                Get.snackbar(
                                  'delete_snackbar_title'.tr,
                                  'delete_snackbar_content'.tr,
                                  colorText: Colors.redAccent,
                                );
                              },
                        child: const Text("삭제하기"),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.redAccent,
            ),
          )
        ],
      ),
      body: Obx(
        () {
          if (controller.logs.isEmpty) {
            // logs 상태를 사용하여 위젯 빌드
            return const Center(
              child: Text("기록이 없습니다"),
            );
          } else {
            return ListView.builder(
              itemCount: controller.logs.length, // logs 상태를 사용하여 위젯 빌드
              itemBuilder: (context, index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(controller.logs[index].id!),
                  onDismissed: (direction) async {
                    int id = controller.logs[index].id!;
                    controller.deleteLogs(id);
                  },
                  child: GestureDetector(
                    onTap: () {
                      Get.lazyPut<LogVM>(
                          () => LogVM(log: controller.logs[index]));
                      Get.to(() => const LogScreen());
                    },
                    child: Column(
                      children: [
                        Card(
                          color: Colors.grey[100],
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // 모서리를 둥글게 하는 정도
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                // padding: EdgeInsets.all(10.0.w),
                                padding: EdgeInsets.fromLTRB(
                                    20.w, 5.0.w, 20.0.w, 5.0.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.memory(
                                    base64Decode(
                                        controller.logs[index].originalImage),
                                    height: 100.h,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 55.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.logs[index].datetime!.substring(0, 4)}년 ${controller.logs[index].datetime!.substring(5, 7)}월 ${controller.logs[index].datetime!.substring(8, 10)}일 ${controller.logs[index].datetime!.substring(17, 19) == "PM" ? "오후" : "오전"} ${controller.logs[index].datetime!.substring(11, 13)}시 ${controller.logs[index].datetime!.substring(14, 16)}분',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    SizedBox(height: 25.0.h), // 간격 추가
                                    Row(
                                      children: [
                                        const Text(
                                          '나이 예측 결과 :  ',
                                        ),
                                        Text(
                                          controller.logs[index].ageResult,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0), // 간격 추가
                                    Row(
                                      children: [
                                        const Text(
                                          '색상 예측 결과 :  ',
                                        ),
                                        Text(
                                          controller.logs[index].colorResult,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
