import 'package:advera/auth/regester_screen.dart';
import 'package:advera/controller/color.dart';
import 'package:advera/controller/token.dart';
import 'package:advera/data/cubit/advera_cubit.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/helper/shared_refrence.dart';
import 'package:advera/layout/home_layout_screen/home_layout_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailOrPhone = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdveraCubit, AdveraState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: double.infinity,
                    child: const Image(
                      image: AssetImage('images/adv.png'),
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: (MediaQuery.of(context).size.height * 0.8) - 20,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 50,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: TextFormField(
                                  controller: emailOrPhone,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    hintText: "رقم الهاتف او الايميل",
                                    hintStyle: const TextStyle(
                                      fontFamily: "font",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: TextFormField(
                                  controller: password,
                                  keyboardType: TextInputType.visiblePassword,
                                  textAlign: TextAlign.end,
                                  obscureText:
                                      AdveraCubit.get(context).visibale,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    hintText: "كلمة المرور",
                                    hintStyle: const TextStyle(
                                      fontFamily: "font",
                                      color: Colors.grey,
                                    ),
                                    prefixIcon: AdveraCubit.get(context)
                                                .visibale ==
                                            false
                                        ? IconButton(
                                            onPressed: () {
                                              AdveraCubit.get(context)
                                                  .changeModePassword();
                                            },
                                            icon: const Icon(
                                                Icons.visibility_off),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              AdveraCubit.get(context)
                                                  .changeModePassword();
                                            },
                                            icon: const Icon(Icons.visibility),
                                          ),
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     TextButton(
                              //       onPressed: () {},
                              //       child: const Text(
                              //         "هل نسيت كلمة المرور؟",
                              //         style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 14,
                              //           fontFamily: "font",
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 30,
                              ),
                              state is LoginLoaded
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        if (password.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                "الرجاء ادخال كلمة المرور",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "font",
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          );
                                        } else if (emailOrPhone.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                "الرجاء ادخال رقم الجوال او الايميل",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "font",
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          );
                                        } else if (password.text.isEmpty &&
                                            emailOrPhone.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                "الرجاء ادخال بيانات تسجيل الدخول",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "font",
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          );
                                        } else {
                                          AdveraCubit.get(context)
                                              .loginUserAccount(
                                                  user: emailOrPhone.text,
                                                  password: password.text);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "تسجيل الدخول",
                                            style: TextStyle(
                                              fontFamily: "font",
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RegesterScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    border: const Border(
                                      bottom: BorderSide(color: Colors.white),
                                      top: BorderSide(color: Colors.white),
                                      left: BorderSide(color: Colors.white),
                                      right: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "انشاء حساب ",
                                      style: TextStyle(
                                        fontFamily: "font",
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) async {
        if (state is LoginSuccessfully) {
          CacheHelper.setData(
                  key: 'token',
                  value: AdveraCubit.get(context).userData[0]['data']
                      ['userDetails']['remember_token'])
              .then((value) {})
              .then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeLayoutScreen(),
                ),
                (route) => false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Color.fromARGB(255, 91, 228, 96),
                content: Text(
                  "تم تسجيل الدخول بنجاح",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "font",
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            );
          });
        }
        if (state is LoginFaild) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "الرجاء التاكد من الايميل او كلمة المرور",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "font",
                ),
                textAlign: TextAlign.end,
              ),
            ),
          );
        }
      },
    );
  }
}
