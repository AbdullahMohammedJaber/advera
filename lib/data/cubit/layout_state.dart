part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class GetCategoryLoaded extends LayoutState {}

class GetCategoryDone extends LayoutState {}

class GetCategoryError extends LayoutState {}

class ChangeBottom extends LayoutState {}

class GetProductHomeLoaded extends LayoutState {}

class GetProductHomeDone extends LayoutState {}

class GetSliderHomeLoaded extends LayoutState {}

class GetSliderHomeDone extends LayoutState {}

class GetProductCategoryLoaded extends LayoutState {}

class GetProductCategoryDone extends LayoutState {}

class GetFavLoaded extends LayoutState {}

class GetFavDone extends LayoutState {}

class AddFavLoaded extends LayoutState {}

class ChangeFavSuc extends LayoutState {}

class AddFavDone extends LayoutState {
  final bool status;

  AddFavDone(this.status);
}

class RemoveFavLoaded extends LayoutState {}

class RemoveFavDone extends LayoutState {
  final bool status;

  RemoveFavDone(this.status);
}

class SearchLoaded extends LayoutState {}

class EbtySearch extends LayoutState {}

class SearchDone extends LayoutState {}

class GetCartLoaded extends LayoutState {}

class GetCartDone extends LayoutState {}

class AddCartLoaded extends LayoutState {}

class GetSubCategoryLoaded extends LayoutState {}

class GetSubCategoryDone extends LayoutState {}

class sendMassegeSucces extends LayoutState {}

class getMassegeSucces extends LayoutState {}

class GetMessageLoaded extends LayoutState {}

class DeleteItemLoaded extends LayoutState {}

class DeleteItemDone extends LayoutState {}

class ValedateCoponLoaded extends LayoutState {}

class ValedateCoponDone extends LayoutState {
  final String msg;

  ValedateCoponDone(this.msg);
}

class ValedateCoponFaild extends LayoutState {
  final String msg;

  ValedateCoponFaild(this.msg);
}

class GetNotifecationLoaded extends LayoutState {}

class GetNotifecationDone extends LayoutState {}

class Loadeingtrue extends LayoutState {}

class AddAdressDone extends LayoutState {}

class AddAdressLoaded extends LayoutState {}

class GetAdressLoaded extends LayoutState {}

class GetAdressDone extends LayoutState {}

class Loadeingfalse extends LayoutState {}

class AddCartDone extends LayoutState {}

class AddOrderLoaded extends LayoutState {}

class GetOfferList extends LayoutState {}

class Change extends LayoutState {}

class AddOrderFaild extends LayoutState {}

class AddOrderDone extends LayoutState {}
