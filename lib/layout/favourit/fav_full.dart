import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/layout/favourit/fav_empty.dart';
import 'package:advera/layout/favourit/favouraite.dart';
import 'package:advera/layout/product/details_product.dart';
import 'package:advera/widget/font_styles.dart';
import 'package:advera/widget/shimmerEffect.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavFull extends StatefulWidget {
  const FavFull({Key key}) : super(key: key);

  @override
  State<FavFull> createState() => _FavFullState();
}

class _FavFullState extends State<FavFull> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: state is GetFavLoaded
              ? ShimmerEffect(
                  borderRadius: 10.0.r,
                  height: 88.h,
                  width: 343.w,
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: LayoutCubit.get(context)
                        .favItem[0]['data']['products']
                        .length,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 230.0.h,
                        crossAxisSpacing: 10.0.w),
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetails(
                                  product: LayoutCubit.get(context).favItem[0]
                                      ['data']['products'][index]),
                            ),
                          );
                        },
                        child: Container(
                          height: 225.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: BuildProuduct(context, index, state),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
      listener: (context, state) async {
        if (state is RemoveFavDone) {
          await LayoutCubit.get(context).getListFav();
          setState(() {});
        }
      },
    );
  }

  Column BuildProuduct(BuildContext context, int index, LayoutState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 130.h,
                width: 160.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: LayoutCubit.get(context).favItem[0]['data']
                      ['products'][index]['images'][0],
                  fit: BoxFit.cover,
                  placeholder: (context, name) {
                    return ShimmerEffect(
                        borderRadius: 10.0,
                        height: MediaQuery.of(context).size.height * .15,
                        width: MediaQuery.of(context).size.width * .40);
                  },
                  errorWidget: (context, error, child) {
                    return ShimmerEffect(
                      borderRadius: 10.0,
                      height: MediaQuery.of(context).size.height * .20,
                      width: MediaQuery.of(context).size.width * .45,
                    );
                  },
                ),
              ),
            ),
            LayoutCubit.get(context).favItem[0]['data']['products'][index]
                        ['discount_price'] ==
                    0
                ? SizedBox()
                : Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    width: 47.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      gradient: LinearGradient(
                        colors: [Color(0xFFF49763), Color(0xFFD23A3A)],
                        stops: [0, 1],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "% ${LayoutCubit.get(context).favItem[0]['data']['products'][index]['discount_price']}",
                        style: FontStyles.montserratBold17()
                            .copyWith(fontSize: 11.0, color: Colors.white),
                      ),
                    ),
                  ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  LayoutCubit.get(context).deleteFav(
                      id: LayoutCubit.get(context).favItem[0]['data']
                          ['products'][index]['id']);
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  width: 30.0,
                  child: IconButton(
                    onPressed: () async {
                      LayoutCubit.get(context).deleteFav(
                          id: LayoutCubit.get(context).favItem[0]['data']
                              ['products'][index]['id']);
                    },
                    icon: state is RemoveFavLoaded
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : Icon(
                            Icons.delete,
                            size: 20,
                          ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -15.0,
              right: 10.0,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 36.0,
                  width: 36.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36.0),
                  ),
                  child: Icon(
                    LayoutCubit.get(context).favItem[0]['data']['products']
                                [index]['auth']['is_liked'] ==
                            1
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: LayoutCubit.get(context).favItem[0]['data']
                                ['products'][index]['auth']['is_liked'] ==
                            1
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        //  _buildRatings(context),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  "${LayoutCubit.get(context).favItem[0]['data']['products'][index]['name']}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    overflow: TextOverflow.fade,
                  ),
                  maxLines: 3,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LayoutCubit.get(context).favItem[0]['data']['products'][index]
                          ['discount_price'] ==
                      0
                  ? SizedBox()
                  : Text(
                      "₪ ${LayoutCubit.get(context).favItem[0]['data']['products'][index]['price']}",
                      style: TextStyle(
                        color: pageColor,
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
              const SizedBox(
                width: 30,
              ),
              Text(
                "₪ ${LayoutCubit.get(context).favItem[0]['data']['products'][index]['price_after_discount']}",
                style: TextStyle(
                    color: green, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatings(BuildContext context) {
    return SizedBox(
      height: 20,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
              size: 15.0,
            );
          }),
    );
  }
}
