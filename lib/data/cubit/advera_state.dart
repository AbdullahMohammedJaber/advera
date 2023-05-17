part of 'advera_cubit.dart';

@immutable
abstract class AdveraState {}

class AdveraInitial extends AdveraState {}

class ChangeModePassword extends AdveraState {}

class LoginSuccessfully extends AdveraState {
  final bool status;

  LoginSuccessfully({@required this.status});
}

class LoginFaild extends AdveraState {}

class LoginErorr extends AdveraState {}

class LoginLoaded extends AdveraState {}

class RegesterUserLoaded extends AdveraState {}

class ReqesterAccountFound extends AdveraState {
  final String msg;

  ReqesterAccountFound({@required this.msg});
}

class RegesterUserSuccessfully extends AdveraState {}

class RegesterUserError extends AdveraState {}

class GetProfileUserLoaded extends AdveraState {}

class GetProfileUserDone extends AdveraState {}

class LogoutUserLoaded extends AdveraState {}

class LogoutUserDone extends AdveraState {}

class DeleteAccountLoaded extends AdveraState {}

class DeleteAccountDone extends AdveraState {
  final String message;

  DeleteAccountDone(this.message);
}
