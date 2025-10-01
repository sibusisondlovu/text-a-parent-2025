import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  static void init() {
    OneSignal.shared.setAppId("YOUR_ONESIGNAL_APP_ID");

    // Foreground notification handler
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
            (OSNotificationReceivedEvent event) {
          event.complete(event.notification);
        });

    // When user opens notification
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('Notification opened: ${result.notification.title}');
      // Handle navigation if needed
    });
  }
}
