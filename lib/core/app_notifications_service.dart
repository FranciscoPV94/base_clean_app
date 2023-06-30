// import 'package:onesignal_flutter/onesignal_flutter.dart';

// void initOneSignal() {
//   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//   OneSignal.shared.setAppId('e82a72d5-25d0-4e50-98ca-a1f764dc53f5');

//   OneSignal.shared.setNotificationWillShowInForegroundHandler(
//       (OSNotificationReceivedEvent event) {
//     event.complete(event.notification);
//   });

//   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//     print("Accepted permission: $accepted");
//   });

//   OneSignal.shared
//       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});
// }
