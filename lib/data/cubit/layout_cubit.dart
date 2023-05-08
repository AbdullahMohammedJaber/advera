import 'package:advera/auth/login_screen.dart';
import 'package:advera/controller/color.dart';
import 'package:advera/controller/token.dart';
import 'package:advera/data/cubit/advera_cubit.dart';
import 'package:advera/helper/shared_refrence.dart';
import 'package:advera/layout/cart/cart.dart';
import 'package:advera/layout/favourit/favouraite.dart';
import 'package:advera/layout/home/home_screen.dart';
import 'package:advera/layout/profile/profile.dart';
import 'package:advera/server/server.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);
  var index = 0;

  static var token = 'null';
  static var notefication = 'null';

  List<Widget> screen = [
    const HomeScreen(),
    const CartScreen(),
    const FavScreen(),
    const ProfileScreen(),
  ];

  void changeBottom(x, context) {
    if (token == 'null') {
      if (x == 1) {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.warning,
          body: const Center(
            child: Text(
              "لم يتم تسجيل الدخول ",
              style: TextStyle(
                fontFamily: 'font',
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          title: 'This is Ignored',
          btnOkOnPress: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false);
          },
          btnOkColor: swichColor,
          btnOkText: "تسجيل الدخول",
        ).show();
      } else if (x == 2) {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.warning,
          body: const Center(
            child: Text(
              "لم يتم تسجيل الدخول ",
              style: TextStyle(
                fontFamily: 'font',
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          title: 'This is Ignored',
          btnOkOnPress: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false);
          },
          btnOkColor: swichColor,
          btnOkText: "تسجيل الدخول",
        ).show();
      } else if (x == 3) {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.warning,
          body: const Center(
            child: Text(
              "لم يتم تسجيل الدخول ",
              style: TextStyle(
                fontFamily: 'font',
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          title: 'This is Ignored',
          btnOkOnPress: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false);
          },
          btnOkColor: swichColor,
          btnOkText: "تسجيل الدخول",
        ).show();
      } else {
        index = x;
        emit(ChangeBottom());
      }
    } else {
      index = x;
      emit(ChangeBottom());
    }
  }

  // function get category .
  List<Map<dynamic, dynamic>> category = [];

  Future getCategory() async {
    emit(GetCategoryLoaded());
    category = [];

    await DioServer.getData(url: "/categories").then((value) {
      category.add(value.data);

      emit(GetCategoryDone());
    }).catchError((onError) {
      emit(GetCategoryError());
    });
  }

  // function get products home screen
  List<Map<String, dynamic>> productHome = [];
  List<Map<String, dynamic>> productHomeNotOffer = [];
  List<Map<String, dynamic>> productHomeOffer = [];
  static int limit = 10;
  static bool isLoading = false;

  Future getProductHomeScreen() async {
    emit(GetProductHomeLoaded());
    productHome = [];
    productHomeNotOffer = [];
    productHomeOffer = [];
    isLoading = true;
    emit(Loadeingtrue());
    await DioServer.getDataProduct(
      limit: limit,
      url: "/products",
      token: token,
    ).then((value) {
      productHome.add(value.data);

      for (int i = 0;
          i < productHome[0]['data']['records']['posts'].length;
          i++) {
        if (productHome[0]['data']['records']['posts'][i]['discount_price'] ==
            0) {
          productHomeNotOffer
              .add(productHome[0]['data']['records']['posts'][i]);
        } else {
          productHomeOffer.add(productHome[0]['data']['records']['posts'][i]);
        }
      }
      isLoading = false;
      emit(Loadeingfalse());
      emit(GetProductHomeDone());
    });
  }

  List<Map<String, dynamic>> slidertHome = [];

  Future getSliderHomeScreen() async {
    emit(GetSliderHomeLoaded());
    slidertHome = [];
    await DioServer.getData(
      url: "/slider",
    ).then((value) {
      slidertHome.add(value.data);

      emit(GetSliderHomeDone());

      // ignore: avoid_
    });
  }

  List<Map<String, dynamic>> productCategory = [];

  void getProductCategoryScreen({required int id_category}) {
    emit(GetProductCategoryLoaded());
    productCategory = [];
    DioServer.getDataCategory(
      url: "/products",
      token: token,
      categoryId: id_category,
    ).then((value) {
      productCategory.add(value.data);
      // ignore: avoid_
      (productCategory);
      emit(GetProductCategoryDone());
      // ignore: avoid_
      (productCategory.length);
    });
  }

  // void get list item favoraites
  List<Map<String, dynamic>> favItem = [];

  void getListFav() {
    emit(GetFavLoaded());
    favItem = [];
    ("Favv--------------------------------------");
    (token);
    DioServer.getData(url: '/productsWishlist', token: token).then((value) {
      ("The Favoraite List is :");
      favItem.add(value.data);
      (value.data);
      emit(GetFavDone());
    });
  }

  void addFav({required int id}) {
    emit(AddFavLoaded());

    DioServer.getData(
      url: '/products/wishlist/add',
      query: {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      getListFav();
      getProductHomeScreen();
      emit(AddFavDone(value.data['status']));
    });
  }

  void deleteFav({required int id}) {
    emit(RemoveFavLoaded());

    DioServer.getData(
      url: '/products/wishlist/remove',
      query: {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      // getListFav();
      getProductHomeScreen();

      emit(RemoveFavDone(value.data['status']));
    });
  }

  List<Map<String, dynamic>> searchData = [];

  void searchProduct({
    required String nameProduct,
  }) {
    emit(SearchLoaded());
    searchData = [];

    DioServer.getDataSearch(url: '/products', query: {
      'search': nameProduct,
    }).then((value) {
      searchData.add(value.data);
      (searchData);
      emit(SearchDone());
    });
  }

  void clearSearch() {
    searchData = [];
    emit(EbtySearch());
  }

  List<Map<String, dynamic>> cartItem = [];

  void getListCart() {
    emit(GetCartLoaded());
    cartItem = [];

    DioServer.getData(url: '/carts', token: token).then((value) {
      cartItem.add(value.data);

      emit(GetCartDone());
      totalPriseCart();
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  static dynamic total = 0;

  void totalPriseCart() {
    total = cartItem[0]['data']['carts']['total_after_discount'];
    emit(ChangePriseDone());
  }

  late int indexCart;

  void getIndexCart() async {
    indexCart = await CacheHelper.getData(key: 'indexCart') ?? 1;
  }

  void addCart({required int id, required int amount}) {
    emit(AddCartLoaded());
    getIndexCart();
    (indexCart);
    (id);
    (amount);
    DioServer.postData(
      url: '/carts',
      query: {
        'products[$indexCart][id]': id,
        'products[$indexCart][amount]': amount,
      },
      token: token,
    ).then((value) {
      CacheHelper.setData(key: 'indexCart', value: indexCart + 1);
      getListCart();
      getProductHomeScreen();
      emit(AddCartDone());
    });
  }

  void addOrder() {
    emit(AddOrderLoaded());
    DioServer.postData(
      url: "/orders",
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        CacheHelper.setData(key: 'indexCart', value: 0).then((value) {
          getIndexCart();
        });
        emit(AddOrderDone());
      } else if (value.statusCode == 422) {
        emit(AddOrderFaild());
      }
    });
  }

  void changeIndexOrder() {
    index = 0;
    emit(Change());
  }

  void sendMessageSupport({
    required String receiverId,
    required String dateTime,
    required String text,
    required String name,
    required BuildContext context,
  }) {
    var dateString = DateTime.now();
    var id = Uuid().v4();
    var id2 = Uuid().v4();

    FirebaseFirestore.instance.collection('Support').doc(token).set({
      'name': AdveraCubit.get(context).user[0]['data']['userDetails']['name'],
      'id': token,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('Support')
          .doc(token)
          .collection('chat')
          .doc(receiverId)
          .set({'id': receiverId, 'name': name}).then((value) {
        FirebaseFirestore.instance
            .collection('Support')
            .doc(token)
            .collection('chat')
            .doc(receiverId)
            .collection('massege')
            .add({
          'dateTime': dateString,
          'text': text,
          'type': "message",
          'receiverId': receiverId,
          'senderId': token,
        }).then((value) {
          emit(sendMassegeSucces());
        });
      });

      FirebaseFirestore.instance
          .collection('Support')
          .doc(receiverId)
          .collection('chat')
          .doc(token)
          .set({
        'id': token,
        'name': AdveraCubit.get(context).user[0]['data']['userDetails']['name'],
      }).then((value) {
        FirebaseFirestore.instance
            .collection('Support')
            .doc(receiverId)
            .collection('chat')
            .doc(token)
            .collection('massege')
            .add({
          'dateTime': dateString,
          'text': text,
          'type': "message",
          'receiverId': receiverId,
          'senderId': token,
        }).then((value) {
          emit(sendMassegeSucces());
        });
      });
    });
  }

  List<Map<String, dynamic>> messagesSupport = [];

  void getMessagesSupport({
    required String receiverId,
  }) {
    emit(GetMessageLoaded());
    messagesSupport = [];
    FirebaseFirestore.instance
        .collection('Support')
        .doc(token)
        .collection('chat')
        .doc(receiverId)
        .collection('massege')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messagesSupport = [];
      event.docs.forEach((element) {
        messagesSupport.add(element.data());

        emit(getMassegeSucces());
      });
    });
  }

  List<Map<String, dynamic>> subCategoryList = [];

  Future getSubCategory({required int categoryId}) async {
    emit(GetSubCategoryLoaded());
    subCategoryList = [];
    await DioServer.getData(url: '/subCategories', query: {
      'category_id': categoryId,
    }).then((value) {
      subCategoryList.add(value.data);
      (subCategoryList);
      emit(GetSubCategoryDone());
    });
  }

  List<Map<String, dynamic>> adressUser = [];

  void getAllAdressUser() {
    emit(GetAdressLoaded());
    adressUser = [];
    DioServer.getData(
      url: "/users/address",
      token: token,
    ).then((value) {
      for (int i = 0; i < value.data['data']['userAddresses'].length; i++) {
        adressUser.add(value.data['data']['userAddresses'][i]);
      }

      print(adressUser);
      emit(GetAdressDone());
    });
  }

  void addAdressUser({
    required String nameStreet,
    required int building_number,
    required int floor_number,
    required int flat_number,
  }) {
    emit(AddAdressLoaded());
    DioServer.postData(
      url: "/users/address",
      token: token,
      data: {
        "area_id": 1,
        "street_name": nameStreet,
        "building_number": building_number,
        "floor_number": floor_number,
        "flat_number": flat_number,
        "is_default": 1,
      },
    ).then((value) {
      emit(AddAdressDone());
      getAllAdressUser();
    });
  }

  void deleteItem({required int id}) {
    emit(DeleteItemLoaded());
    DioServer.deleteData(
      url: "https://store.advera.ps/api/carts/$id",
      token: token,
    ).then((value) {
      getListCart();
      emit(DeleteItemDone());
    });
  }

  List<Map<String, dynamic>> notifecationList = [];

  Future getAllNotifecation() async {
    emit(GetNotifecationLoaded());
    notifecationList = [];
    await DioServer.postData(
      url: '/users/userNotifications',
      token: token,
    ).then((value) {
      notifecationList.add(value.data);
      emit(GetNotifecationDone());
      print(notifecationList);
    });
  }

  void validateCopon({required dynamic copon}) {
    emit(ValedateCoponLoaded());
    DioServer.getData(
      url: '/coupon/valid',
      query: {
        'coupon': copon,
      },
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        print(value.data['msg']);
        emit(ValedateCoponDone(value.data['msg']));
        getListCart();
      } else {
        print(value.data);
        emit(ValedateCoponFaild(value.data['msg']));
      }
    });
  }
}
