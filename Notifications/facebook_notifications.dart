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

class FacebookNotification extends StatefulWidget {
  const FacebookNotification ({Key? key}) : super(key: key);

  @override
  State<FacebookNotification> createState() => _FacebookNotificationState();
}

class _FacebookNotificationState extends State<FacebookNotification> {
  bool follow = false;
  @override
  triggerFacebookMessage1Notification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Daniel Sent you a message!',
        body: "Message: What's Up?",
      ),
    );
  }

  triggerFacebookMessage2Notification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Alice Sent you a message!',
        body: "Message: Can you see me in my office at 9 today?",
      ),
    );
  }

  triggerFacebookMessage3Notification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Roger Sent you a message!',
        body: "Message: Remember our work presentation for today!",
      ),
    );
  }
  Widget build(BuildContext context) {
    return ListBody(children: [
      const SizedBox(width: 15),
      Column(
        children: [
          Text("Daniel", style: Theme.of(context).textTheme.headlineMedium!
          ), const SizedBox(
            height: 5,
          ),
          Text(
            "Whats up?",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: follow == false ? 50:30),
              child: ElevatedButton.icon(
                onPressed: () {
                  triggerFacebookMessage1Notification();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 30)),
                icon: const Icon(
                  Icons.facebook_rounded,
                ),
                label: Text('Reply'),
              )
          )
      ),
      const SizedBox(width: 15),
      Column(
        children: [
          Text("Alice", style: Theme.of(context).textTheme.headlineMedium!
          ), const SizedBox(
            height: 5,
          ),
          Text(
            "Can you see me in my office at 9 today?",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: follow == false ? 50:30),
              child: ElevatedButton.icon(
                onPressed: () {
                  triggerFacebookMessage2Notification();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 30)),
                icon: const Icon(
                  Icons.facebook_rounded,
                ),
                label: Text('Reply'),
              )
          )
      ),
      const SizedBox(width: 15),
      Column(
        children: [
          Text("Roger", style: Theme.of(context).textTheme.headlineMedium!
          ), const SizedBox(
            height: 5,
          ),
          Text(
            "Remember our work presentation for today!",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: follow == false ? 50:30),
              child: ElevatedButton.icon(
                onPressed: () {
                  triggerFacebookMessage3Notification();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 30)),
                icon: const Icon(
                  Icons.facebook_rounded,
                ),
                label: Text('Reply'),
              )
          )
      ),
    ],
    );
  }
}