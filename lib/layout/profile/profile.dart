import 'package:advera/auth/login_screen.dart';
import 'package:advera/controller/color.dart';
import 'package:advera/controller/token.dart';
import 'package:advera/data/cubit/advera_cubit.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/layout/chat/chat_screen.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    AdveraCubit.get(context).getUserProfile(token: LayoutCubit.token);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdveraCubit, AdveraState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "الملف الشخصي",
                  style: TextStyle(fontFamily: "font", fontSize: 18),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: AdveraCubit.get(context).user.isEmpty ||
                      state is GetProfileUserLoaded
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 60,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 55,
                                backgroundImage: NetworkImage(
                                    "${AdveraCubit.get(context).user[0]['data']['userDetails']['image']}.png"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${AdveraCubit.get(context).user[0]['data']['userDetails']['name']}",
                                style: const TextStyle(
                                  fontFamily: "font",
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(Icons.person),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${AdveraCubit.get(context).user[0]['data']['userDetails']['email']}",
                                style: const TextStyle(
                                  fontFamily: "font",
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(Icons.email),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${AdveraCubit.get(context).user[0]['data']['userDetails']['phone']}",
                                style: const TextStyle(
                                  fontFamily: "font",
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(Icons.phone),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MessageScreenSupport(
                                          idMoqadem: "s1",
                                          nameMoqadem: "Support"),
                                    ),
                                  );
                                },
                                child: Text(
                                  "تواصل معنا",
                                  style: TextStyle(
                                      fontFamily: "font",
                                      fontSize: 16,
                                      color: primaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "? هل تواجه اي مشاكل",
                                style: TextStyle(
                                  fontFamily: "font",
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          state is DeleteAccountLoaded
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    // if (AdveraCubit.get(context).deleteAcount[0]
                                    //             ['data']['deleteAccount']
                                    //         ['status'] ==
                                    //     "pending") {
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(
                                    //     const SnackBar(
                                    //       backgroundColor: Colors.green,
                                    //       content: Text(
                                    //         "تم ارسال طلبك مسبقا وهو قيد المراجعه !",
                                    //         style: TextStyle(
                                    //           fontFamily: "font",
                                    //           fontSize: 18,
                                    //           color: Colors.white,
                                    //         ),
                                    //         textAlign: TextAlign.end,
                                    //       ),
                                    //     ),
                                    //   );
                                    // } else {
                                    AdveraCubit.get(context).deleteAccount();
                                  },
                                  child: Container(
                                    height: 55,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: const Border(
                                        bottom: BorderSide(color: Colors.red),
                                        top: BorderSide(color: Colors.red),
                                        right: BorderSide(color: Colors.red),
                                        left: BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "حذف الحساب",
                                            style: TextStyle(
                                              fontFamily: "font",
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(Icons.delete)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          state is LogoutUserLoaded
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    AdveraCubit.get(context).logoutUser();
                                  },
                                  child: Container(
                                    height: 55,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: const Border(
                                        bottom: BorderSide(color: Colors.red),
                                        top: BorderSide(color: Colors.red),
                                        right: BorderSide(color: Colors.red),
                                        left: BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "تسجيل الخروج",
                                            style: TextStyle(
                                              fontFamily: "font",
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(Icons.logout)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is DeleteAccountDone) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                state.message,
                style: const TextStyle(
                  fontFamily: "font",
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          );
        }
        if (state is LogoutUserDone) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "تم تسجيل الخروج",
                style: TextStyle(
                  fontFamily: "font",
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          );

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false);
        }
      },
    );
  }
}
