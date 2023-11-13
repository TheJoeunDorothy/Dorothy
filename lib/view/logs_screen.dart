import 'dart:convert';

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
        ),
        body: FutureBuilder(
            future: controller.selectAllLogs(),
            builder: (context, snapshot) {
              // c언어의 포인터개념으로 snapshot(위치에 직접 접속한다.)
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length, // null값 있을 수 있어서 ?
                    itemBuilder: (context, index) {
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: ValueKey<int>(snapshot.data![index].id!),
                      onDismissed: (direction)async {
                        await controller.deleteLogs(snapshot.data![index].id!);
                        snapshot.data!.remove(snapshot.data![index]);
                      },
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox( width: 50.w,),
                              Image.memory(base64Decode(snapshot.data![index].image), height: 100.h,),
                              SizedBox( width: 100.w,),
                              Text(snapshot.data![index].datetime),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
