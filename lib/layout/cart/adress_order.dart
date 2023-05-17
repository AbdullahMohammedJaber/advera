import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/server/server.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdressOrder extends StatefulWidget {
  const AdressOrder({Key key}) : super(key: key);

  @override
  State<AdressOrder> createState() => _AdressOrderState();
}

class _AdressOrderState extends State<AdressOrder> {
  bool addAdress = false;
  bool canselAdress = true;
  @override
  void initState() {
    LayoutCubit.get(context).getAllAdressUser();
    addAdress = false;
    canselAdress = true;
    super.initState();
  }

  int idStrett = 0;
  var nameStrettController = TextEditingController();
  var noumberFlowerController = TextEditingController();
  var buildingNoumberController = TextEditingController();
  var flat_numberController = TextEditingController();
  var coponController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "عنوان الطلبية",
                  style: TextStyle(fontFamily: "font", fontSize: 18),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: LayoutCubit.get(context).adressUser.isEmpty == [] ||
                    LayoutCubit.get(context).adressUser == [] ||
                    LayoutCubit.get(context).adressUser.length == 0
                ? addAdress == true && canselAdress == false
                    ? addAddress(
                        context,
                        state,
                      )
                    : Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "لم تقم باضافة عناوين توصيل مسبقا",
                                style: TextStyle(
                                  fontFamily: "font",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  addAdress = true;
                                  canselAdress = false;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 47,
                                decoration: BoxDecoration(
                                  color: secondColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    "اضافة عنوان",
                                    style: TextStyle(
                                      fontFamily: "font",
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                : addAdress == true && canselAdress == false
                    ? addAddress(
                        context,
                        state,
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()),
                                      borderRadius: BorderRadius.circular(12),
                                      icon: Icon(Icons.arrow_downward_rounded),
                                      iconSize: 15,
                                      elevation: 10,
                                      isExpanded: true,
                                      dropdownColor: primaryColor,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hint: Text("اختر عنوان التوصيل"),
                                      items: LayoutCubit.get(context)
                                          .adressUser
                                          .map((e) {
                                        //+ '\t' + '\t' + ', building_number :' + e[0]['userAddresses']['building_number'] + '\t' + '\t' + ', floor_number :' + e[0]['userAddresses']['floor_number']
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            "${e['street_name']}",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              idStrett = e['id'];
                                            });
                                          },
                                        );
                                      }).toList(),
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          idStrett = value['id'];
                                        });
                                        print(idStrett);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "أدخل كوبون الخصم",
                                          style: TextStyle(
                                            fontFamily: "font",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: coponController,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          fontFamily: "font",
                                          color: Colors.black,
                                          fontSize: 12),
                                      decoration: InputDecoration(
                                        hintText: "ادخل الكوبون الخاص بك",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (coponController.text.isEmpty) {
                                      } else {
                                        LayoutCubit.get(context).validateCopon(
                                            copon: coponController.text);
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: state is ValedateCoponLoaded
                                            ? CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text(
                                                "تفعيل الكود",
                                                style: TextStyle(
                                                    fontFamily: "font",
                                                    color: Colors.white),
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        state is GetCartLoaded
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        color: primaryColor),
                                              )
                                            : Text(
                                                "₪ ${LayoutCubit.total}",
                                                style: TextStyle(
                                                  fontFamily: "font",
                                                ),
                                              ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          ": السعر النهائي للطلبية",
                                          style: TextStyle(
                                            fontFamily: "font",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                  ),
                                  //   Spacer(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        addAdress = true;
                                        canselAdress = false;
                                      });
                                    },
                                    child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: secondColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "اضافة عنوان جديد",
                                          style: TextStyle(
                                            fontFamily: "font",
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (idStrett == 0) {
                                      } else {
                                        LayoutCubit.get(context).addOrder();
                                      }
                                    },
                                    child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: swichColor,
                                      ),
                                      child: Center(
                                        child: state is AddOrderLoaded
                                            ? CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text(
                                                "تنفيذ الطلبية",
                                                style: TextStyle(
                                                  fontFamily: "font",
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ValedateCoponDone) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                state.msg,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "font",
                ),
                textAlign: TextAlign.end,
              ),
            ),
          );
        }
        if (state is ValedateCoponFaild) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                state.msg,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "font",
                ),
                textAlign: TextAlign.end,
              ),
            ),
          );
        }
        if (state is AddOrderDone) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "تم تنفيذ طلبك قيد المراجعة",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "font",
                ),
                textAlign: TextAlign.end,
              ),
            ),
          );
          Navigator.pop(context);
          LayoutCubit.get(context).changeIndexOrder();
        }
        if (state is AddAdressDone) {
          nameStrettController.clear();
          noumberFlowerController.clear();
          flat_numberController.clear();
          buildingNoumberController.clear();
          setState(() {
            addAdress = false;
            canselAdress = true;
          });
        }
      },
    );
  }

  addAddress(BuildContext context, LayoutState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    addAdress = false;
                    canselAdress = true;
                  });
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.cancel),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            addAdress = false;
                            canselAdress = true;
                          });
                        },
                        child: Text(
                          "الغاء الامر",
                          style: TextStyle(
                            fontFamily: "font",
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameStrettController,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontFamily: "font", color: Colors.black, fontSize: 12),
                decoration: InputDecoration(
                  hintText: "اسم الشارع",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: buildingNoumberController,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontFamily: "font", color: Colors.black, fontSize: 12),
                decoration: InputDecoration(
                  hintText: "رقم العمارة",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: noumberFlowerController,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontFamily: "font", color: Colors.black, fontSize: 12),
                decoration: InputDecoration(
                  hintText: "رقم الطابق",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: flat_numberController,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontFamily: "font", color: Colors.black, fontSize: 12),
                decoration: InputDecoration(
                  hintText: "رقم الشقة",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (nameStrettController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "الرجاء ادخال اسم الشارع",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "font",
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    );
                  } else {
                    LayoutCubit.get(context).addAdressUser(
                      nameStreet: nameStrettController.text,
                      building_number:
                          int.parse(buildingNoumberController.text),
                      floor_number: int.parse(noumberFlowerController.text),
                      flat_number: int.parse(flat_numberController.text),
                    );
                  }
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondColor,
                  ),
                  child: Center(
                    child: state is AddAdressLoaded
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "اضافة",
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
    );
  }
}
