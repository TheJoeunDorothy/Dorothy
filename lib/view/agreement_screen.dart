import 'package:dorothy/static/agreement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이용 약관"),
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
