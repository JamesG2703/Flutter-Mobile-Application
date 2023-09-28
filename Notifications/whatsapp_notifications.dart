import 'package:flutter/material.dart';
import 'package:custom_button/custom_button.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null,
      [
      NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      channelDescription: 'Notification Channel',
      ),
      ],
    debug: true,
  );
}

class WhatsAppNotification extends StatefulWidget {
  const WhatsAppNotification ({Key? key}) : super(key: key);

  @override
  State<WhatsAppNotification> createState() => _WhatsAppNotificationState();
}

class _WhatsAppNotificationState extends State<WhatsAppNotification> {
  bool follow = false;
  @override
  triggerWhatsAppMessage1Notification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'David sent you a message!',
        body: 'Message: Hey there!',
      ),
    );
  }

  triggerWhatsAppMessage2Notification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Sarah sent you a message!',
        body: 'Message: What time is the work meeting again?',
      ),
    );
  }

  triggerWhatsAppMessage3Notification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'John sent you a message!',
        body: 'Message: Want to meet up tonight at 7?',
      ),
    );
  }
  Widget build(BuildContext context) {
    return ListBody(children: [
      const SizedBox(width: 15),
      Column(
        children: [
          Text("David", style: Theme.of(context).textTheme.headlineMedium!
          ), const SizedBox(
            height: 5,
          ),
          Text(
            "Hey there!",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      Expanded(
      child: Padding(
          padding: EdgeInsets.only(left: follow == false ? 50:30),
          child: ElevatedButton.icon(
            onPressed: () {
              triggerWhatsAppMessage1Notification();
              },
            style: ElevatedButton.styleFrom(fixedSize: const Size(100, 30)),
            icon: const Icon(
              Icons.message_rounded,
            ),
            label: Text('Reply'),
          )
      )
      ),
      const SizedBox(width: 15),
      Column(
        children: [
          Text("Sarah", style: Theme.of(context).textTheme.headlineMedium!
          ), const SizedBox(
            height: 5,
          ),
          Text(
            "What time is the work meeting again?",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: follow == false ? 50:30),
              child: ElevatedButton.icon(
                onPressed: () {
                  triggerWhatsAppMessage2Notification();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 30)),
                icon: const Icon(
                  Icons.message_rounded,
                ),
                label: Text('Reply'),
              )
          )
      ),
      const SizedBox(width: 15),
      Column(
        children: [
          Text("John", style: Theme.of(context).textTheme.headlineMedium!
          ), const SizedBox(
            height: 5,
          ),
          Text(
            "Want to meet up tonight at 7?",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: follow == false ? 50:30),
              child: ElevatedButton.icon(
                onPressed: () {
                  triggerWhatsAppMessage3Notification();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 30)),
                icon: const Icon(
                  Icons.message_rounded,
                ),
                label: Text('Reply'),
              )
          )
      ),
    ],
    );
  }
}