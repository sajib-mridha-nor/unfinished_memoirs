// import 'dart:typed_data';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:bongobondhu_app/core/theme/colors.dart';
// import 'package:flutter/material.dart';
//
// import '../utils/colors.dart';
//
// class NotificationManager {
//   Future<void> initNotification() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: 'scheduled_channel',
//           channelName: 'Scheduled Notifications',
//           defaultColor: kPrimaryColor,
//           locked: false,
//           importance: NotificationImportance.High,
//           defaultRingtoneType: DefaultRingtoneType.Notification,
//           channelDescription: 'Notification channel for schedule tests',
//         ),
//         NotificationChannel(
//           channelKey: 'media_player_channel',
//           channelName: 'Media Player',
//           channelDescription: 'Control your media playback',
//           defaultColor: Color(0xFF9D50DD),
//           ledColor: Colors.blue,
//           importance: NotificationImportance.Low,
//           locked: true,
//           criticalAlerts: false,
//           defaultPrivacy: NotificationPrivacy.Secret,
//           playSound: false,
//           enableLights: true,
//           onlyAlertOnce: true,
//           vibrationPattern: Int64List.fromList([0, 0, 0]),
//           enableVibration: false,
//         ),
//       ],
//     );
//   }
//
//   Future<void> cancelScheduledNotifications() async {
//     await AwesomeNotifications().cancelAllSchedules();
//   }
// }
