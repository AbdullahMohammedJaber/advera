import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Notifecation extends StatefulWidget {
  const Notifecation({Key? key}) : super(key: key);

  @override
  State<Notifecation> createState() => _NotifecationState();
}

class _NotifecationState extends State<Notifecation> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var not = LayoutCubit.get(context).notifecationList[0]['data']
            ['userNotifications'];
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "الاشعارات",
                  style: TextStyle(
                      fontFamily: "font", fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: LayoutCubit.get(context).notifecationList.isEmpty ||
                    LayoutCubit.get(context)
                        .notifecationList[0]['data']['userNotifications']
                        .isEmpty ||
                    LayoutCubit.get(context).notifecationList[0]['data']
                            ['userNotifications'] ==
                        [] ||
                    LayoutCubit.get(context)
                            .notifecationList[0]['data']['userNotifications']
                            .length ==
                        0
                ? Center(
                    child: Text(
                      "لا يوجد اشعارات",
                      style: TextStyle(
                        fontFamily: "font",
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${not[index]['notification']['created_at']}",
                                        style: TextStyle(
                                            fontFamily: "font",
                                            color: Colors.grey,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    child: Text(
                                      "${not[index]['notification']['id']}",
                                      style: TextStyle(fontFamily: "font"),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Text(
                                      "${not[index]['notification']['title']}",
                                      style: TextStyle(
                                        fontFamily: "font",
                                        fontSize: 15,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Text(
                                      "${not[index]['notification']['description']}",
                                      style: TextStyle(
                                        fontFamily: "font",
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Divider(
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                      );
                    },
                    itemCount: not.length,
                  ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
