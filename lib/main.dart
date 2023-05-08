import 'package:advera/data/cubit/advera_cubit.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/firebase_options.dart';
import 'package:advera/helper/shared_refrence.dart';
import 'package:advera/server/local_push_notification.dart';
import 'package:advera/server/server.dart';
import 'package:advera/splash_screen.dart';
import 'package:advera/widget/App.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await DioServer.init();
  await CacheHelper.init();
  AppSta.setSystemStyling();

  LayoutCubit.token = await CacheHelper.getData(key: 'token') ?? 'null';
  // ignore: avoid_print
  print("the token is : \n");
  // ignore: avoid_print
  print(LayoutCubit.token);
 // LocalNotificationService.initialize();

  // await FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onMessage.listen((event) {
  //   LocalNotificationService.display(event);
  // });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // stormNotifecationToken() async {
  //   LayoutCubit.notefication =
  //       await FirebaseMessaging.instance.getToken() as String;
  // }

  @override
  void initState() {
    super.initState();
  //  stormNotifecationToken();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdveraCubit()),
        BlocProvider(create: (context) => LayoutCubit()..getIndexCart()),
      ],
      child: ScreenUtilInit(builder: (BuildContext context, Widget? child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen());
      }),
    );
  }
}
