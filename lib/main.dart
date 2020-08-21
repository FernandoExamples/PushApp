import 'package:flutter/material.dart';
import 'package:pushapp/src/pages/home_page.dart';
import 'package:pushapp/src/pages/message_page.dart';
import 'package:pushapp/src/providers/push_provider.dart';
import 'package:pushapp/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //obtener un key para usar el Navigator dentro de un stream
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    //instalar las notificaciones
    super.initState();
    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();

    pushProvider.notificationStream().listen((data) {
      print('argumento desde manin $data');
      navigatorKey.currentState.pushNamed(Routes.messagePage, arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      navigatorKey: navigatorKey,
      initialRoute: Routes.homePage,
      routes: {
        Routes.homePage: (context) => HomePage(),
        Routes.messagePage: (context) => MessagePage(),
      },
    );
  }
}
