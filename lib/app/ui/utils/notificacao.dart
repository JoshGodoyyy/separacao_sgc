import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificacao {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  Notificacao({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

class NotificacaoService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificacaoService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    _configurarNotificacao();
  }

  _configurarNotificacao() async {
    await _initializeNotificacao();
  }

  _initializeNotificacao() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
    );
  }

  showNotificacao(Notificacao notificacao) {
    androidDetails = const AndroidNotificationDetails(
      'Separacao',
      'SGC',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound('alert'),
    );

    localNotificationsPlugin.show(
      notificacao.id,
      notificacao.title,
      notificacao.body,
      NotificationDetails(android: androidDetails),
    );
  }

  verificarNotificacoes() async {
    await localNotificationsPlugin.getNotificationAppLaunchDetails();
  }
}
