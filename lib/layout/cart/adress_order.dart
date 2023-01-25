import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdressOrder extends StatefulWidget {
  const AdressOrder({Key? key}) : super(key: key);

  @override
  State<AdressOrder> createState() => _AdressOrderState();
}

class _AdressOrderState extends State<AdressOrder> {
  @override
  void initState() {
    LayoutCubit.get(context).getAllAdressUser();

    super.initState();
  }

  int idStrett = 0;

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
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
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
                          hint: Text("null"),
                          items: LayoutCubit.get(context).adressUser.map((e) {
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
                              idStrett = value!['id'];
                            });
                            print(idStrett);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
