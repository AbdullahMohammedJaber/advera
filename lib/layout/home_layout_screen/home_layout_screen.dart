import 'package:advera/auth/login_screen.dart';
import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({Key key}) : super(key: key);

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          body: LayoutCubit.get(context).screen[LayoutCubit.get(context).index],
          backgroundColor: Colors.white,

          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            animationCurve: Curves.easeInOutCubicEmphasized,
            backgroundColor: Colors.white,
            color: primaryColor,
            index: LayoutCubit.get(context).index,
            onTap: (index) {
              print(index);
              LayoutCubit.get(context).changeBottom(index, context);
            },
            items: [
              Icon(
                Icons.home,
                color: LayoutCubit.get(context).index == 0
                    ? Colors.white
                    : Colors.black,
              ),
              Icon(
                Icons.shopping_cart_sharp,
                color: LayoutCubit.get(context).index == 1
                    ? Colors.white
                    : Colors.black,
              ),
              Icon(
                Icons.favorite,
                color: LayoutCubit.get(context).index == 2
                    ? Colors.white
                    : Colors.black,
              ),
              Icon(
                Icons.person,
                color: LayoutCubit.get(context).index == 3
                    ? Colors.white
                    : Colors.black,
              ),
            ],
          ),

          // bottomNavigationBar: BottomNavigationBar(
          //   selectedItemColor: secondColor,
          //   unselectedItemColor: primaryColor,
          //   backgroundColor: Colors.black.withOpacity(0.08),
          //   elevation: 0,
          //   type: BottomNavigationBarType.fixed,
          //   currentIndex: LayoutCubit.get(context).index,
          //   onTap: (index) {
          //     LayoutCubit.get(context).changeBottom(index);
          //   },
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.home),
          //       label: "الرئيسية",
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.shopping_cart_sharp),
          //       label: "السلة",
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.favorite),
          //       label: "المفضلة",
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.person),
          //       label: "الملف الشخصي",
          //     ),
          //   ],
          // ),

          // bottomNavigationBar: SafeArea(
          //   child: Container(
          //     padding: const EdgeInsets.all(7),
          //     margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //     decoration: BoxDecoration(
          //       color: swichColor.withOpacity(0.4),
          //       borderRadius: const BorderRadius.all(
          //         Radius.circular(25),
          //       ),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Container(
          //               height: 8,
          //               width: LayoutCubit.get(context).index == 0 ? 22 : 0,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(14),
          //                 color: const Color.fromARGB(255, 5, 75, 110),
          //               ),
          //             ),
          //             InkWell(
          //               onTap: () {
          //                 setState(() {
          //                   LayoutCubit.get(context).index = 0;
          //                 });
          //               },
          //               child: const Image(
          //                 image: AssetImage('images/home.png'),
          //                 height: 40,
          //                 width: 25,
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //           ],
          //         ),
          //         Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Container(
          //               height: 8,
          //               width: LayoutCubit.get(context).index == 1 ? 22 : 0,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(14),
          //                 color: const Color.fromARGB(255, 5, 75, 110),
          //               ),
          //             ),
          //             InkWell(
          //               onTap: () {
          //                 setState(() {
          //                   LayoutCubit.get(context).index = 1;
          //                 });
          //               },
          //               child: const Image(
          //                 image: AssetImage('images/cart.png'),
          //                 height: 40,
          //                 width: 25,
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //           ],
          //         ),
          //         Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Container(
          //               height: 8,
          //               width: LayoutCubit.get(context).index == 2 ? 22 : 0,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(14),
          //                 color: const Color.fromARGB(255, 5, 75, 110),
          //               ),
          //             ),
          //             InkWell(
          //               onTap: () {
          //                 setState(() {
          //                   LayoutCubit.get(context).index = 2;
          //                 });
          //               },
          //               child: const Image(
          //                 image: AssetImage('images/heart.png'),
          //                 height: 40,
          //                 width: 25,
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //           ],
          //         ),
          //         Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Container(
          //               height: 8,
          //               width: LayoutCubit.get(context).index == 3 ? 22 : 0,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(14),
          //                 color: const Color.fromARGB(255, 5, 75, 110),
          //               ),
          //             ),
          //             InkWell(
          //               onTap: () {
          //                 setState(() {
          //                   LayoutCubit.get(context).index = 3;
          //                 });
          //               },
          //               child: const Image(
          //                 image: AssetImage('images/user.png'),
          //                 height: 40,
          //                 width: 25,
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        );
      },
      listener: (context, state) {},
    );
  }
}
