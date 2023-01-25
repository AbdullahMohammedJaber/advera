import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/layout/cart/cart_empty.dart';
import 'package:advera/layout/cart/cart_full.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    LayoutCubit.get(context).getListCart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "السلة",
                  style: TextStyle(fontFamily: "font", fontSize: 18),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            backgroundColor: primaryColor,
          ),
          body: state is GetCartLoaded ||
                  LayoutCubit.get(context).cartItem.isEmpty ||
                  LayoutCubit.get(context).cartItem[0]['data']['carts'].isEmpty
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                )
              : LayoutCubit.get(context).cartItem[0]['data']['carts'].isEmpty ||
                      LayoutCubit.get(context).cartItem[0]['data']['carts'] ==
                          []
                  ? const CartEmpty()
                  : const CartFull(),
        );
      },
      listener: (context, state) {},
    );
  }
}
