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

class WeatherNotification extends StatefulWidget {
  const WeatherNotification ({Key? key}) : super(key: key);

  @override
  State<WeatherNotification> createState() => _WeatherNotificationState();
}

class _WeatherNotificationState extends State<WeatherNotification> {
  bool follow = false;
  @override
  triggerWeatherNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Weather Report',
        body: 'Cloudy with 60% chance of rain. Predicted until 17:00 this evening!',
      ),
    );
  }
  Widget build(BuildContext context) {
    return ListBody(children: [
      const SizedBox(width: 15),
      Column(
        children: [
          Text("Today: Cloudy with a 60% chance of rain!", style: Theme.of(context).textTheme.headlineMedium!
          ), const SizedBox(
            height: 5,
          ),
          Text(
            "Coat or umbrella is recommended",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: follow == false ? 50:30),
              child: ElevatedButton.icon(
                onPressed: () {
                  triggerWeatherNotification();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 30)),
                icon: const Icon(
                  Icons.cloud_rounded,
                ),
                label: Text('View full report'),
              )
          )
      ),
    ],
    );
  }
}