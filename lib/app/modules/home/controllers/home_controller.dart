import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_atlanta_push_notification_example/app/data/models/notification.dart';
import 'package:flutter_atlanta_push_notification_example/app/data/models/user.dart';
import 'package:flutter_atlanta_push_notification_example/app/data/services/notification_service.dart';
import 'package:flutter_atlanta_push_notification_example/app/data/services/user_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  StreamSubscription<List<Notification>>? _notificationSubscription;
  final RxList<Notification> notifications = RxList<Notification>();
  @override
  void onInit() {
    super.onInit();
    _storeToken();
    _listenForNotifications();
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    _notificationSubscription = null;
    super.dispose();
  }

  void _storeToken() async {
    FirebaseMessaging.instance.requestPermission();

    UserService().create(User(fcmToken: await FirebaseMessaging.instance.getToken()));

    
  }

  void _listenForNotifications() {
    _notificationSubscription =
        NotificationService().streamList(limit: 1000).listen(
      (List<Notification> notifications) {
        this.notifications.value = notifications;
      },
    );
  }
}
