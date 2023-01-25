import 'dart:io';

import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:url_launcher/url_launcher.dart';

class MessageScreenSupport extends StatefulWidget {
  final String idMoqadem;
  final String nameMoqadem;

  const MessageScreenSupport(
      {Key? key, required this.idMoqadem, required this.nameMoqadem})
      : super(key: key);

  @override
  State<MessageScreenSupport> createState() => _MessageScreenSupportState();
}

class _MessageScreenSupportState extends State<MessageScreenSupport> {
  var messageController = TextEditingController();
  bool x = true;
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bool x = true;
    LayoutCubit.get(context).getMessagesSupport(
      receiverId: widget.idMoqadem,
    );
    Future.delayed(Duration(milliseconds: 500)).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: primaryColor,
              title: Text(
                "${widget.nameMoqadem}",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'font',
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: LayoutCubit.get(context).messagesSupport.isEmpty
                          ? Center(
                              child: Text("Start Message"),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 5,
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  primary: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  reverse: false,
                                  itemBuilder: (context, index) {
                                    if (LayoutCubit.token ==
                                        LayoutCubit.get(context)
                                            .messagesSupport[index]['senderId'])
                                      return buildMyMessage(
                                        LayoutCubit.get(context)
                                            .messagesSupport[index]['text'],
                                        LayoutCubit.get(context)
                                            .messagesSupport[index]['type'],
                                        context,
                                      );

                                    return buildMessage(
                                        LayoutCubit.get(context)
                                            .messagesSupport[index]['text'],
                                        LayoutCubit.get(context)
                                            .messagesSupport[index]['type'],
                                        context);
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 15.0,
                                  ),
                                  itemCount: LayoutCubit.get(context)
                                      .messagesSupport
                                      .length,
                                ),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 209, 209, 209),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here ...',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 50.0,
                          color: Color.fromARGB(255, 82, 81, 81),
                          child: MaterialButton(
                            onPressed: () {
                              LayoutCubit.get(context).sendMessageSupport(
                                context: context,
                                name: widget.nameMoqadem,
                                receiverId: this.widget.idMoqadem,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                              );

                              setState(() {
                                messageController.clear();
                              });
                            },
                            minWidth: 1.0,
                            child: Icon(
                              Icons.send,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     _mainScrollController
            //         .jumpTo(_mainScrollController.position.maxScrollExtent);
            //   },
            //   child: Icon(Icons.directions_car_rounded),
            //   mini: true,
            //   isExtended: true,
            // ),
          );
        },
        listener: (context, state) {},
      );
    });
  }
}

Widget buildMessage(String model, String type, context) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 224, 224, 224),
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              10.0,
            ),
            topStart: Radius.circular(
              10.0,
            ),
            topEnd: Radius.circular(
              10.0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: type == "image"
            ? InkWell(
                onTap: () async {
                  final url = model;
                  await launch(
                    url,
                    enableJavaScript: true,
                    enableDomStorage: true,
                    forceSafariVC: true,
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: model,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )
            : Text(
                model,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'fontMy',
                ),
              ),
      ),
    );

Widget buildMyMessage(
  String model,
  String type,
  context,
) =>
    Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 109, 109, 109),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(
              10.0,
            ),
            topStart: Radius.circular(
              10.0,
            ),
            topEnd: Radius.circular(
              10.0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: type == "image"
            ? InkWell(
                onTap: () async {
                  final url = model;
                  await launch(
                    url,
                    enableJavaScript: true,
                    enableDomStorage: true,
                    forceSafariVC: true,
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: model,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )
            : Text(
                model,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'fontMy',
                ),
              ),
      ),
    );
