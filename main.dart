import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'Notifications/whatsapp_notifications.dart';
import 'Notifications/facebook_notifications.dart';
import 'Notifications/calender_notifications.dart';
import 'Notifications/weather_notifications.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:io';
import 'dart:ui';

import 'Notifications/notification_service.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:push/push.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
//import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

DateTime scheduledate = DateTime.now();
Time12hPickerModel scheduletime = Time12hPickerModel();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification Channel for basic tests',
      ),
    ],
    debug: true,
  );
  runApp(const MaterialApp(
    title: 'Main',
    home: FirstRoute(),
  ));
  tz.initializeTimeZones();
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  get assets => null;

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> { //Stateful Widget for home menu for notification permission message
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications(); //If awesome_notifications is functional on a device (Pixel 4a)
        // then request permission
      }
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            'Home Menu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text('Welcome to the main menu of the microcontroller to all IoT devices. Please use the buttons to navigate!',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ))
                      ]
                  )
              )
            ]
        )
    );
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AlarmRoute()),
            );
          },
          icon: const Icon (
            Icons.access_alarm_rounded,
            size:24.0,
          ),
          label: Text('Alarm'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CoffeeMachineRoute()),
            );
          },
          icon: const Icon (
            Icons.coffee_rounded,
            size:24.0,
          ),
          label: Text('Coffee Machine'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LightbulbRoute()),
            );
          },
          icon: const Icon (
            Icons.lightbulb_circle_rounded,
            size:24.0,
          ),
          label: Text('Lightbulb settings'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CurtainRoute()),
            );
          },
          icon: const Icon (
            Icons.curtains_rounded,
            size:24.0,
          ),
          label: Text('Curtain settings'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SleepAnalysisRoute()),
            );
          },
          icon: const Icon (
            Icons.bed_rounded,
            size:24.0,
          ),
          label: Text('Sleep Analysis Graph'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationRoute()),
            );
          },
          icon: const Icon (
            Icons.notifications_rounded,
            size:24.0,
          ),
          label: Text('Notification List'),
        ),
      ],
    );
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Smart Alarm Clock Home'),
          ),
          body: ListView(
            children: [
              Image.asset("lib/images/Smart-Bedroom.png",
              width: 150,
              height: 300,
              fit: BoxFit.cover),
              titleSection,
              buttonSection,
            ],
          ),
        )
    );
  }
}

class AlarmTimePicker extends StatefulWidget {
  const AlarmTimePicker({
    Key? key,
    }) : super(key: key);

  @override
  State<AlarmTimePicker> createState() => _AlarmTimePickerState();
}

class _AlarmTimePickerState extends State<AlarmTimePicker> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        DatePicker.showTime12hPicker(
          context,
          showTitleActions: true,
          onChanged: (time) => scheduledate = time,
          onConfirm: (time) {},
        );
      },
      icon: const Icon(
        Icons.alarm_add_rounded,
        size: 24.0,
      ),
      label: const Text('Select 12h Alarm Time'),
    );
  }
}

class AlarmDatePicker extends StatefulWidget {
  const AlarmDatePicker({
    Key? key,
    }) : super(key: key);

  @override
  State<AlarmDatePicker> createState() => _AlarmPickerState();
}

class _AlarmPickerState extends State<AlarmDatePicker> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (time) => scheduledate = time,
          onConfirm: (time) {},
        );
      },
      icon: const Icon(
        Icons.alarm_add_rounded,
        size: 24.0,
      ),
      label: const Text('Select Alarm Time'),
    );
  }
}

class ScheduleAlm extends StatelessWidget{
  const ScheduleAlm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        debugPrint('Alarm Notification set for $scheduledate');
        NotificationService().scheduleAlarmNotification(
          title: 'Scheduled Alarm Notification',
          body: '$scheduledate',
          scheduledNotificationDateTime: scheduledate);
      },
      icon: const Icon(
        Icons.schedule_rounded,
        size: 24.0,
      ),
      label: const Text('Schedule Alarm Time!'),
    );
  }
}

class AlarmRoute extends StatelessWidget {
  const AlarmRoute({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            'Alarm Menu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text('Please schedule the specific time you wish the IoT alarm clock to wake you up at!',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ))
                      ]
                  )
              )
            ]
        )
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Clock Menu'),
      ),
      body: Center(
        child: ListView(
            children: [
              Image.asset("lib/images/IoTAlarmClock.png",
            width: 150,
            height: 300,
            fit: BoxFit.cover),
        titleSection,
        AlarmDatePicker(),
        ScheduleAlm(),
        ],
        ),
        ),
      );
  }
}

class LightbulbRoute extends StatelessWidget {
  const LightbulbRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Light Bulb Menu'),
      ),
      body: Center(
        child: ListView(
          children: [
            Image.asset("lib/images/IoTLightbulb.png",
                width: 150,
                height: 300,
                fit: BoxFit.cover),
            LightbulbSwitch(),
          ],
        ),
      ),
    );
  }
}

class LightbulbSwitch extends StatefulWidget {
  const LightbulbSwitch({super.key});

  @override
  State<LightbulbSwitch> createState() => _LightbulbSwitchState();
}

class _LightbulbSwitchState extends State<LightbulbSwitch> {

  String savedLightBulbSettingsText = '';

  void clickSaveSettings() {
    setState(() {
      savedLightBulbSettingsText =
          'Settings Saved!';
    });
  }

  bool light0 = true;
  bool light1 = true;
  bool light2 = true;

  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          child: const Text(
            'Light Bulb Menu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text('Please use the options to save options for the smart light bulbs!',
            style: TextStyle(
              color: Colors.grey[500],
            )),
        Text('Turn on/off lights!'),
        Switch(
          value: light0,
          onChanged: (bool value) {
            setState(() {
              light0 = value;
            });
          },
        ),
        Text('Enable automation'),
        Switch(
          thumbIcon: thumbIcon,
          value: light1,
          onChanged: (bool value) {
            setState(() {
              light1 = value;
            });
          },
        ),
        ElevatedButton.icon(
          onPressed: clickSaveSettings,
          icon: const Icon(
            Icons.settings_rounded,
            size:24.0,
          ),
          label: Text('Click to save settings!'),
        ),
        Text(
          savedLightBulbSettingsText,
          style: TextStyle(fontSize: 21),
        ),
      ],
    );
  }
}

class CurtainRoute extends StatelessWidget {
  const CurtainRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curtain Menu'),
      ),
      body: Center(
        child: ListView(
          children: [
            Image.asset("lib/images/IoTCurtains.png",
                width: 150,
                height: 300,
                fit: BoxFit.cover),
            CurtainRoutePage(),
          ],
        ),
      ),
    );
  }
}

class CurtainRoutePage extends StatefulWidget {
  const CurtainRoutePage({super.key});

  @override
  State<CurtainRoutePage> createState() => _CurtainRoutePageState();
}

class _CurtainRoutePageState extends State<CurtainRoutePage> {

  String savedCurtainSettingsText = '';

  void clickSaveSettings() {
    setState(() {
      savedCurtainSettingsText =
      'Settings Saved!';
    });
  }

  bool light0 = true;
  bool light1 = true;
  bool light2 = true;

  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          child: const Text(
            'Curtain Settings Menu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text('Please use the options to save options for the curtains!',
            style: TextStyle(
              color: Colors.grey[500],
            )),
        Text('Open/close curtains!'),
        Switch(
          value: light0,
          onChanged: (bool value) {
            setState(() {
              light0 = value;
            });
          },
        ),
        Text('Enable automation'),
        Switch(
          thumbIcon: thumbIcon,
          value: light1,
          onChanged: (bool value) {
            setState(() {
              light1 = value;
            });
          },
        ),
        ElevatedButton.icon(
          onPressed: clickSaveSettings,
          icon: const Icon(
            Icons.settings_rounded,
            size:24.0,
          ),
          label: Text('Click to save settings!'),
        ),
        Text(
          savedCurtainSettingsText,
          style: TextStyle(fontSize: 21),
        ),
      ],
    );
  }
}

class CoffeeMachineRoute extends StatefulWidget {
  const CoffeeMachineRoute({super.key});

  @override
  State<CoffeeMachineRoute> createState() => _CoffeeMachineRouteState();
}

class _CoffeeMachineRouteState extends State<CoffeeMachineRoute> {

  String savedSettingsText = '';

  void clickSaveSettings() {
    setState(() {
      savedSettingsText = 'Settings Saved! You have selected the coffee type ' + dropdownvalue + ' in a ' + dropdowntest
          + ' to be brewed at $scheduledate!';
    });

    NotificationService().scheduleAlarmNotification(
    title: 'Scheduled Coffee Notification',
    body: 'Your ' + dropdownvalue + ' in a ' + dropdowntest + ' is now ready',
    scheduledNotificationDateTime: scheduledate);
  }

  // Initial Selected Value
  String dropdownvalue = 'Americano';
  String dropdowntest = '1/4 Cup';

  // List of items in our dropdown menu
  var coffeeitems = [
    'Americano',
    'Cappuccino',
    'Espresso',
    'Latte',
    'Cafe au Lait',
  ];

  var coffeecupsize = [
    '1/4 Cup',
    '1/2 Cup',
    '3/4 Cup',
    'Full Cup',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Coffee Menu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text('Please select the type of coffee you would like at a certain cup size at a scheduled time!',
                style: TextStyle(
                  color: Colors.grey[500],
                )),
            DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: coffeeitems.map((String coffeeitems) {
                return DropdownMenuItem(
                  value: coffeeitems,
                  child: Text(coffeeitems),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
            DropdownButton(
              // Initial Value
              value: dropdowntest,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: coffeecupsize.map((String coffeecupsize) {
                return DropdownMenuItem(
                  value: coffeecupsize,
                  child: Text(coffeecupsize),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdowntest = newValue!;
                });
              },
            ),
            ElevatedButton.icon(
              onPressed: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (time) => scheduledate = time,
                  onConfirm: (time) {},
                );
                },
              icon: const Icon(
                Icons.alarm_add_rounded,
                size: 24.0,
              ),
              label: const Text('Select Schedule Time'),
            ),
            ElevatedButton.icon(
              onPressed: clickSaveSettings,
              icon: const Icon(
                Icons.settings_rounded,
                size:24.0,
              ),
              label: Text('Click to save settings!'),
            ),
            Text(
              savedSettingsText,
              style: TextStyle(fontSize: 21),
            ),
          ],
        ),
      ),
    );
  }
}

class SleepAnalysisRoute extends StatelessWidget {

  List<SleepData> data = [
    SleepData('12:00', 0.34),
    SleepData('01:00', 0.76),
    SleepData('02:00', 0.32),
    SleepData('03:00', 0.09),
    SleepData('04:00', 0.45)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Analysis Graph (Time vs Movement Frequency)'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Daily Sleep Performance Record'),
          legend: Legend(isVisible: true,),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<SleepData, String>>[
            LineSeries<SleepData, String>(
              dataSource: data,
              xValueMapper: (SleepData sleep, _) => sleep.time,
              yValueMapper: (SleepData sleep, _) => sleep.movementfrequency,
              name: 'Sleep',
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}

class SleepData{

  final String time;
  final double movementfrequency;

  SleepData(this.time, this.movementfrequency);

}

class NotificationRoute extends StatelessWidget {
  const NotificationRoute({super.key});

  get assets => null;

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            'Notification List',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text('List of priority notifications for today!',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ))
                      ]
                  )
              )
            ]
        )
    );
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WhatsAppNotificationRoute()),
            );
          },
          icon: const Icon (
            Icons.phone_rounded,
            size:24.0,
          ),
          label: Text('WhatsApp Notifications'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FacebookNotificationRoute()),
            );
          },
          icon: const Icon (
            Icons.facebook_rounded,
            size:24.0,
          ),
          label: Text('Facebook Notifications'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CalenderNotificationRoute()),
            );
          },
          icon: const Icon (
            Icons.calendar_month_rounded,
            size:24.0,
          ),
          label: Text('Calendar Notifications'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WeatherNotificationRoute()),
            );
          },
          icon: const Icon (
            Icons.cloud_rounded,
            size:24.0,
          ),
          label: Text('Weather Notifications'),
        ),
      ],
    );
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Priority Notification List'),
          ),
          body: ListView(
            children: [
              Image.asset("lib/images/Notification.png",
                  width: 150,
                  height: 300,
                  fit: BoxFit.cover),
              titleSection,
              buttonSection,
            ],
          ),
        )
    );
  }
}

class WhatsAppNotificationRoute extends StatelessWidget {
  const WhatsAppNotificationRoute({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            'WhatsApp Notifications',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text('Recent notifications significant for today!',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ))
                      ]
                  )
              )
            ]
        )
    );
    return Scaffold(
        appBar: AppBar(
        title: const Text('WhatsApp Notification Menu'),
    ),
    body: ListView(
    children: [
      Image.asset("lib/images/WhatsApp.png",
          width: 150,
          height: 300,
          fit: BoxFit.cover),
      titleSection,
      WhatsAppNotification(),
    ],
    ),
    );
  }
}

class FacebookNotificationRoute extends StatelessWidget {
  const FacebookNotificationRoute({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            'Facebook Notifications',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text('Recent notifications significant for today!',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ))
                      ]
                  )
              )
            ]
        )
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook Notification Menu'),
      ),
      body: ListView(
        children: [
          Image.asset("lib/images/Facebook.png",
              width: 150,
              height: 300,
              fit: BoxFit.cover),
          titleSection,
          FacebookNotification(),
        ],
      ),
    );
  }
}

class CalenderNotificationRoute extends StatelessWidget {
  const CalenderNotificationRoute({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            'Calender Notifications',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text('Recent notifications significant for today!',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ))
                      ]
                  )
              )
            ]
        )
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calender Notification Menu'),
      ),
      body: ListView(
        children: [
          Image.asset("lib/images/Calender.png",
              width: 150,
              height: 300,
              fit: BoxFit.cover),
          titleSection,
          CalenderNotification(),
        ],
      ),
    );
  }
}

class WeatherNotificationRoute extends StatelessWidget {
  const WeatherNotificationRoute({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            'Weather Notifications',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text('Recent notifications significant for today!',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ))
                      ]
                  )
              )
            ]
        )
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Notification Menu'),
      ),
      body: ListView(
        children: [
          Image.asset("lib/images/Weather.png",
              width: 150,
              height: 300,
              fit: BoxFit.cover),
          titleSection,
          WeatherNotification(),
        ],
      ),
    );
  }
}