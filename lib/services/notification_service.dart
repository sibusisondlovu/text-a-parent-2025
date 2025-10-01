

import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  static Future<void> init() async {
    // // Set OneSignal App ID
    // await OneSignal.shared.setAppId("YOUR_ONESIGNAL_APP_ID");
    //
    // // Optional: Prompt for push notification permission (iOS)
    // await OneSignal.shared.promptUserForPushNotificationPermission();
    //
    // // Foreground notification handler
    // OneSignal.shared.setNotificationWillShowInForegroundHandler(
    //       (OSNotificationReceivedEvent event) {
    //     print("Foreground notification received: ${event.notification.title}");
    //     // Display the notification
    //     event.complete(event.notification);
    //   },
    // );
    //
    // // When user opens a notification
    // OneSignal.shared.setNotificationOpenedHandler(
    //       (OSNotificationOpenedResult result) {
    //     print("Notification opened: ${result.notification.title}");
    //     print("Notification body: ${result.notification.body}");
    //     // TODO: Handle navigation or other app logic
    //   },
    // );

    // Optional: Logging subscription and permission state
    // OneSignal.shared.getDeviceState().then((deviceState) {
    //   print("OneSignal User ID: ${deviceState?.userId}");
    //   print("Push enabled: ${deviceState?.hasNotificationPermission}");
    // });
  }
}
