import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavEmbty extends StatefulWidget {
  const FavEmbty({Key? key}) : super(key: key);

  @override
  State<FavEmbty> createState() => _FavEmbtyState();
}

class _FavEmbtyState extends State<FavEmbty> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: state is GetFavLoaded
                ? CircularProgressIndicator(
                    color: primaryColor,
                  )
                : Text(
                    "لا يوجد منتجات بالمفضلة",
                    style: TextStyle(fontFamily: "font", fontSize: 20),
                  ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
