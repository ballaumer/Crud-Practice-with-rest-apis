import 'package:crud_again/controllers/api_services.dart';
import 'package:crud_again/views/login.dart';
import 'package:crud_again/views/main_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'curved_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');

}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();





void setupLocator() {
  GetIt.I.registerLazySingleton(() => ApiServices());
}
Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
     AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
    getToken();
    // getTopics();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

        home: CurvedSplashScreen(
          screensLength: splashContent.length,
          screenBuilder: (index) {
            return SplashContent(
              title: splashContent[index]["title"],
              image: splashContent[index]["image"],
              text: splashContent[index]["text"],
            );
          },
          onSkipButton: () {
          }),
        routes: {'/dashboard': (context) =>  MyHomePage(),
          '/mainpage': (context) =>  MainPage(),
        }


    );
  }
  getToken() async{
    String token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

}

class SplashContent extends StatelessWidget {
  final String title;
  final String text;
  final String image;

  const SplashContent({
    Key key,
    @required this.title,
    @required this.text,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Container(
            height: 200,
            child: Image.asset(image),
          ),
          const SizedBox(height: 60),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19,
            ),
          )
        ],
      ),
    );
  }
}

final splashContent = [
  {
    "title": "Start Learning",
    "text":
    "Start learning now by using this app, Get your choosen course and start the journey.",
    "image": "assets/images/1.png",
  },
  {
    "title": "Explore Courses",
    "text": "Choose which course is suitable for you to enroll in.",
    "image": "assets/images/2.png",
  },
  {
    "title": "At Any time.",
    "text": "Your courses is available at any time you want. Join us now !",
    "image": "assets/images/3.png"
  },
];
