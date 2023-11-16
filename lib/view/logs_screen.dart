import 'dart:convert';

import 'package:dorothy/view/log_screen.dart';
import 'package:dorothy/viewmodel/log_vm.dart';
import 'package:dorothy/viewmodel/logs_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LogsVM controller = Get.put(LogsVM());
    return Scaffold(
      appBar: AppBar(
        title: const Text("기록 보기"),
        actions: [
          IconButton(
            onPressed: () {
              controller.deleteAllLogs();
            },
            icon: const Icon(Icons.delete_forever),
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
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50.w,
                            ),
                            Image.memory(
                              base64Decode(
                                  controller.logs[index].originalImage),
                              height: 100.h,
                            ),
                            SizedBox(
                              width: 100.w,
                            ),
                            Text(controller.logs[index].datetime!),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
