import 'package:advera/controller/token.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/helper/shared_refrence.dart';
import 'package:advera/server/server.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'advera_state.dart';

class AdveraCubit extends Cubit<AdveraState> {
  AdveraCubit() : super(AdveraInitial());
  static AdveraCubit get(context) => BlocProvider.of(context);

  // function show password
  bool visibale = false;
  void changeModePassword() {
    visibale = !visibale;
    emit(ChangeModePassword());
  }

  // function login user

  List<Map<String, dynamic>> userData = [];
  void loginUserAccount({required var user, required String password}) {
    emit(LoginLoaded());
    DioServer.postData(url: "/users/login", data: {
      "emailOrPhone": user.toString().trim(),
      "password": password,
    }).then((value) {
      userData = [];
      if (value.statusCode == 200) {
        if (value.data['code'] == null) {
          userData.add(value.data);
          // ignore: avoid_print
          print(value.data['status']);
          // ignore: avoid_print
          print("LoginDone");
          LayoutCubit.token =
              userData[0]['data']['userDetails']['remember_token'];

          emit(LoginSuccessfully(status: value.data['status']));
        } else if (value.data['code'] == 200) {
          // ignore: avoid_print
          print("LoginFaild");
          emit(LoginFaild());
        }
      } else if (value.statusCode == 422) {
        // ignore: avoid_print
        print(value.data['status']);
        // ignore: avoid_print
        print("LoginError");
        emit(LoginErorr());
      }
    }).catchError((onError) {
      emit(LoginErorr());
    });
  }

  // function regester user
  void regesterUserAccount({
    required String name,
    required String phone,
    required String password,
    required String email,
  }) {
    String zip = "  ";
    emit(RegesterUserLoaded());
    userData = [];
    DioServer.postData(url: "/users/register", data: {
      "name": name,
      "email": email,
      "phone": "${zip + phone}",
      "password": password
    }).then((value) {
      if (value.statusCode == 422) {
        // ignore: avoid_print
        print(value.data);
        // ignore: avoid_print
        print(value.statusCode);
        emit(ReqesterAccountFound(msg: value.data['msg']));
      } else if (value.statusCode == 200) {
        // ignore: avoid_print
        print(value.data);
        userData.add(value.data);
        emit(RegesterUserSuccessfully());
      }
    }).catchError((onError) {
      // ignore: avoid_print
      print(onError.toString());
      emit(RegesterUserError());
    });
  }

// function get profile user
  List<Map<String, dynamic>> user = [];
  void getUserProfile({required String token}) {
    emit(GetProfileUserLoaded());
    user = [];
    DioServer.postData(
      url: "/users/profile",
      token: token,
    ).then((value) {
      user.add(value.data);

      // ignore: avoid_print
      print("the profile user is : ${value.data}");
      emit(GetProfileUserDone());
    });
  }

  void logoutUser() {
    emit(LogoutUserLoaded());
    CacheHelper.deleteData(key: 'token');
    CacheHelper.reloadData().then((value) {
      emit(LogoutUserDone());
    });
  }

  List<Map<String, dynamic>> deleteAcount = [];
  void deleteAccount() {
    deleteAcount = [];
    emit(DeleteAccountLoaded());
    DioServer.getData(
      url: "/deleteAccount",
      token: LayoutCubit.token,
    ).then((value) {
      deleteAcount.add(value.data);
      emit(DeleteAccountDone(value.data['msg']));
    });
  }
}
