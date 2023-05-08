import 'package:advera/auth/login_screen.dart';
import 'package:advera/controller/color.dart';
import 'package:advera/controller/token.dart';
import 'package:advera/data/cubit/advera_cubit.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/layout/home_layout_screen/home_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    LayoutCubit.get(context).getProductHomeScreen();
    LayoutCubit.get(context).getAllNotifecation();
    LayoutCubit.get(context).getSliderHomeScreen();

    LayoutCubit.get(context).getCategory();
    LayoutCubit.limit = 5;
    LayoutCubit.get(context).getCategory();

    LayoutCubit.get(context).getIndexCart();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeLayoutScreen()),
          (route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: primaryColor,
        child: Center(
          child: Image(
            image: const AssetImage("images/logo-dark.png"),
            height: 200,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ),
      ),
    );
  }
}
