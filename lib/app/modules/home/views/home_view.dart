import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          centerTitle: true,
        ),
        body: Obx(() => ListView.builder(
            itemCount: controller.notifications.length,
            itemBuilder: ((context, index) => ListTile(
                  title: Text(controller.notifications[index].title),
                  subtitle: Text(controller.notifications[index].body),
                )))));
  }
}
