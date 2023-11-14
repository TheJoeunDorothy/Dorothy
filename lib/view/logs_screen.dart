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
        ),
        body: FutureBuilder(
            future: controller.selectAllLogs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: const Icon(Icons.delete_forever),
                        ),
                        key: ValueKey<int>(snapshot.data![index].id!),
                        onDismissed: (direction)async {
                        await controller.deleteLogs(snapshot.data![index].id!);
                        snapshot.data!.remove(snapshot.data![index]);
                        },
                        child: GestureDetector(
                          onTap: () {
                            LogVm logController = Get.put(LogVm());
                            logController.log.value = snapshot.data![index];
                            Get.to(()=>const LogScreen()); 
                          },
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox( width: 50.w,),
                                Image.memory(base64Decode(snapshot.data![index].originalimage!), height: 100.h,),
                                SizedBox( width: 100.w,),
                                Text(snapshot.data![index].datetime!),
                              ],
                            ),
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
