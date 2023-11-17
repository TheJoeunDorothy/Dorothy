import 'package:dorothy/static/agreement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("terms_of_service_appbar".tr),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MarkdownBody(
                    softLineBreak: true,
                    data: Agreement.personalCollection,
                    styleSheet: MarkdownStyleSheet(
                      h2: TextStyle(
                          fontSize: 20.sp, 
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
