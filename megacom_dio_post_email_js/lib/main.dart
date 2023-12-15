import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:megacom_dio_post_email_js/app_consts/app_consts.dart';
import 'package:megacom_dio_post_email_js/email_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController fromNameController = TextEditingController();
  final TextEditingController tonameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomText(
                hintext: 'ToName',
                maxline: 1,
                controller: tonameController,
              ),
              CustomText(
                hintext: 'FromName',
                maxline: 1,
                controller: fromNameController,
              ),
              CustomText(
                hintext: 'Message',
                maxline: 6,
                controller: messageController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendEmail,
        tooltip: 'Increment',
        child: const Icon(Icons.send),
      ),
    );
  }

  Future<void> sendEmail() async {
    final Dio dio =
        Dio(BaseOptions(baseUrl: 'https://api.emailjs.com/api/v1.0'));
    try {
      await dio.post(
        '/email/send',
        data: EmailModel(
            serviceId: AppConst().serviceId,
            templateId: AppConst().templateId,
            userId: AppConst().userId,
            accessToken: AppConst().accessToken,
            templateParams: TemplateParams(
              toName: tonameController.text,
              fromName: fromNameController.text,
              message: messageController.text,
              data: DateTime.now().toString(),
            )).toJson(),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Success'),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.hintext,
    required this.maxline,
    required this.controller,
  }) : super(key: key);
  final String hintext;
  final int maxline;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxline,
        decoration: InputDecoration(
          hintText: hintext,
          border: const OutlineInputBorder(),
          filled: true,
        ),
      ),
    );
  }
}
