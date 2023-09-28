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

class CalenderNotification extends StatefulWidget {
  const CalenderNotification ({Key? key}) : super(key: key);

  @override
  State<CalenderNotification> createState() => _CalenderNotificationState();
}

class _CalenderNotificationState extends State<CalenderNotification> {
  bool follow = false;
  @override
  triggerCalenderEvent1Notification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Dentist Appointment',
        body: 'You have a dentist appointment at Sharrow Dental Practice in Chelmsford at 1PM.',
      ),
    );
  }

  triggerCalenderEvent2Notification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Work Meeting',
        body: 'You have a work meeting with Alice at your workplace at 9AM.',
      ),
    );
  }

  triggerCalenderEvent3Notification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Work Presentation',
        body: 'You have to do a work presentation at your workplace with Roger at 3PM.',
      ),
    );
  }
  Widget build(BuildContext context) {
    return ListBody(children: [
      const SizedBox(width: 15),
      Column(
        children: [
          Text("Dentist Appointment", style: Theme.of(context).textTheme.headlineMedium!
          ), const SizedBox(
            height: 5,
          ),
          Text(
            "Scheduled for 1:00 PM.",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: follow == false ? 50:30),
              child: ElevatedButton.icon(
                onPressed: () {
                  triggerCalenderEvent1Notification();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 30)),
                icon: const Icon(
                  Icons.calendar_month_rounded,
                ),
                label: Text('View Details'),
              )
          )
      ),
      const SizedBox(width: 15),
      Column(
        children: [
          Text("Meeting with Alice", style: Theme.of(context).textTheme.headlineMedium!
          ), const SizedBox(
            height: 5,
          ),
          Text(
            "Scheduled for 9:00 AM.",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: follow == false ? 50:30),
              child: ElevatedButton.icon(
                onPressed: () {
                  triggerCalenderEvent2Notification();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 30)),
                icon: const Icon(
                  Icons.calendar_month_rounded,
                ),
                label: Text('View Details'),
              )
          )
      ),
      const SizedBox(width: 15),
      Column(
        children: [
          Text("Work Presentation with Roger", style: Theme.of(context).textTheme.headlineMedium!
          ), const SizedBox(
            height: 5,
          ),
          Text(
            "Scheduled for 3:00 PM",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: follow == false ? 50:30),
              child: ElevatedButton.icon(
                onPressed: () {
                  triggerCalenderEvent3Notification();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 30)),
                icon: const Icon(
                  Icons.calendar_month_rounded,
                ),
                label: Text('View Details'),
              )
          )
      ),
    ],
    );
  }
}