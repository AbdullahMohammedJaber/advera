import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartEmpty extends StatefulWidget {
  const CartEmpty({Key? key}) : super(key: key);

  @override
  State<CartEmpty> createState() => _CartEmptyState();
}

class _CartEmptyState extends State<CartEmpty> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: state is GetCartLoaded
                ? CircularProgressIndicator(
                    color: primaryColor,
                  )
                : Text(
                    "لا يوجد منتجات بالسلة",
                    style: TextStyle(fontFamily: "font", fontSize: 20),
                  ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
