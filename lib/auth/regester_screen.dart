import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/advera_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RegesterScreen extends StatefulWidget {
  const RegesterScreen({Key? key}) : super(key: key);

  @override
  State<RegesterScreen> createState() => _RegesterScreenState();
}

class _RegesterScreenState extends State<RegesterScreen> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
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
                          vertical: 30,
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
                                  controller: nameController,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    hintText: "الاسم",
                                    hintStyle: const TextStyle(
                                      fontFamily: "font",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: TextFormField(
                                  controller: phoneController,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    hintText: "رقم الهاتف",
                                    hintStyle: const TextStyle(
                                      fontFamily: "font",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: TextFormField(
                                  controller: emailController,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    hintText: "البريد الالكتروني",
                                    hintStyle: const TextStyle(
                                      fontFamily: "font",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: TextFormField(
                                  controller: passwordController,
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
                              const SizedBox(
                                height: 30,
                              ),
                              state is RegesterUserLoaded
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        if (passwordController.text.isEmpty) {
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
                                        } else if (phoneController
                                            .text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                "الرجاء ادخال رقم الجوال",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "font",
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          );
                                        } else if (emailController
                                            .text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                "الرجاء ادخال  البريد الالكتروني",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "font",
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          );
                                        } else if (nameController
                                            .text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                "الرجاء ادخال  اسم المستخدم",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "font",
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          );
                                        } else if (passwordController
                                                .text.isEmpty &&
                                            phoneController.text.isEmpty &&
                                            nameController.text.isEmpty &&
                                            emailController.text.isEmpty) {
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
                                              .regesterUserAccount(
                                                  email: emailController.text,
                                                  name: nameController.text,
                                                  password:
                                                      passwordController.text,
                                                  phone: phoneController.text);
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
                                            "انشاء الحساب",
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
                                  Navigator.pop(context);
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
                                      "لدي حساب سابق",
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
      listener: (context, state) {
        if (state is RegesterUserSuccessfully) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "تم انشاء الحساب بنجاح",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "font",
                ),
                textAlign: TextAlign.end,
              ),
            ),
          );
        } else if (state is RegesterUserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "حدث مشاكل بتسجيل الدخول حاول لاحقا",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "font",
                ),
                textAlign: TextAlign.end,
              ),
            ),
          );
        } else if (state is ReqesterAccountFound) {
          if (state.msg == "The phone has already been taken.") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "رقم الجوال مسجل مسبقا",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "font",
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            );
          } else if (state.msg == "The email has already been taken.") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  " البريد الالكتروني مسجل مسبقا",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "font",
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            );
          }
        }
      },
    );
  }
}
