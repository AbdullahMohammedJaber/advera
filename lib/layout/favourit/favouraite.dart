import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/layout/favourit/fav_empty.dart';
import 'package:advera/layout/favourit/fav_full.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    LayoutCubit.get(context).getListFav();

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
                  "المفضلة",
                  style: TextStyle(fontFamily: "font", fontSize: 18),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            backgroundColor: primaryColor,
          ),
          body: state is GetFavLoaded
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                )
              : LayoutCubit.get(context)
                          .favItem[0]['data']['products']
                          .isEmpty ||
                      LayoutCubit.get(context).favItem[0]['data']['products'] ==
                          []
                  ? const FavEmbty()
                  : const FavFull(),
        );
      },
      listener: (context, state) {},
    );
  }
}
