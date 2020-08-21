import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

///Clase handler para el manejo de notificaciones
class PushNotificationProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  //Stream para notificar a los widgets que se suscriban
  final _notificationStrController = StreamController<String>.broadcast();

  Stream<String> notificationStream() => _notificationStrController.stream;

  void dispose() {
    _notificationStrController?.close();
  }

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    print("========= onMessage =========");
    // print(message);

    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
    // Or do other work.
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print("========= onMessage =========");
    print(message);
    _notificationStrController.sink.add(message['data']['comida']);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print("========= onLaunch =========");
    print(message);
    _notificationStrController.sink.add(message['data']['comida']);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print("========= onResume =========");
    print(message);
    _notificationStrController.sink.add(message['data']['comida']);
  }

  void initNotifications() async {
    //obtener un firebase message cloud token que identifica a un dispositivo android en particular.
    //Con el que podremos mandar notificaciones a un dispositivo en particular.
    //Este token deberia de guardarse en alguna arquitectura de base de datos o en el storage
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    print(" ====== FMC TOKEN =====");
    print(token);

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onResume: onResume,
      onLaunch: onLaunch,
    );
  }
}
