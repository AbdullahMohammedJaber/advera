import 'package:advera/auth/login_screen.dart';
import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/layout/product/details_product.dart';
import 'package:advera/widget/font_styles.dart';
import 'package:advera/widget/shimmerEffect.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  @override
  void initState() {
    searchController.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontFamily: "font",
                          color: Colors.black,
                          fontSize: 14),
                      decoration: InputDecoration(
                        prefixIcon: searchController.text.isEmpty
                            ? Icon(Icons.search)
                            : InkWell(
                                onTap: () {
                                  searchController.clear();
                                  LayoutCubit.get(context).clearSearch();
                                },
                                child: Icon(Icons.cancel),
                              ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        LayoutCubit.get(context)
                            .searchProduct(nameProduct: searchController.text);
                      },
                    ),
                    Expanded(
                      child: LayoutCubit.get(context).searchData.isEmpty ||
                              LayoutCubit.get(context).searchData[0]['data']
                                      ['products'] ==
                                  []
                          ? const Center(
                              child: Text(
                                "لا يوجد نتائج بحث",
                                style: TextStyle(
                                  fontFamily: "font",
                                ),
                              ),
                            )
                          : state is SearchLoaded
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: LayoutCubit.get(context)
                                        .searchData[0]['data']['products']
                                        .length,
                                    physics: const BouncingScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
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
                                                  product:
                                                      LayoutCubit.get(context)
                                                                  .searchData[0]
                                                              ['data']
                                                          ['products'][index]),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 225.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.white),
                                          child: BuildProuduct(context, index),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Column BuildProuduct(BuildContext context, int index) {
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: LayoutCubit.get(context).searchData[0]['data']
                      ['products'][index]['images'][0],
                  fit: BoxFit.contain,
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
            LayoutCubit.get(context).searchData[0]['data']['products'][index]
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
                        "% ${LayoutCubit.get(context).searchData[0]['data']['products'][index]['discount_price']}",
                        style: FontStyles.montserratBold17()
                            .copyWith(fontSize: 11.0, color: Colors.white),
                      ),
                    ),
                  ),
            Positioned(
              bottom: -15.0,
              right: 10.0,
              child: InkWell(
                onTap: () {
                  if (LayoutCubit.token == 'null') {
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
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false);
                      },
                      btnOkColor: swichColor,
                      btnOkText: "تسجيل الدخول",
                    ).show();
                  } else {
                    if (LayoutCubit.get(context).searchData[0]['data']
                            ['products'][index]['auth']['is_liked'] ==
                        0) {
                      LayoutCubit.get(context).addFav(
                          id: LayoutCubit.get(context).searchData[0]['data']
                              ['products'][index]['id']);
                    } else if (LayoutCubit.get(context).searchData[0]['data']
                            ['products']['auth']['is_liked'] ==
                        1) {
                      LayoutCubit.get(context).deleteFav(
                          id: LayoutCubit.get(context).searchData[0]['data']
                              ['products'][index]['id']);
                    }
                  }
                },
                child: Container(
                  height: 36.0,
                  width: 36.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36.0),
                  ),
                  child: Icon(
                    LayoutCubit.get(context).searchData[0]['data']['products']
                                [index]['auth']['is_liked'] ==
                            1
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: LayoutCubit.get(context).searchData[0]['data']
                                ['products'][index]['auth']['is_liked'] ==
                            1
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -15.0,
              child: InkWell(
                onTap: () {
                  if (LayoutCubit.token == 'null') {
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
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false);
                      },
                      btnOkColor: swichColor,
                      btnOkText: "تسجيل الدخول",
                    ).show();
                  } else {
                    if (LayoutCubit.get(context).searchData[0]['data']
                            ['products'][index]['auth']['is_added_to_cart'] ==
                        1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.green,
                          content: Text(
                            "تم اضافته للسلة مسبقا",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "font",
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetails(
                                  product:
                                      LayoutCubit.get(context).searchData[0]
                                          ['data']['products'][index])));
                    }
                  }
                },
                child: Container(
                  height: 36.0,
                  width: 36.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36.0),
                  ),
                  child: Icon(
                    LayoutCubit.get(context).searchData[0]['data']['products']
                                [index]['auth']['is_added_to_cart'] ==
                            1
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                    color: LayoutCubit.get(context).searchData[0]['data']
                                    ['products'][index]['auth']
                                ['is_added_to_cart'] ==
                            1
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        // _buildRatings(context),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${LayoutCubit.get(context).searchData[0]['data']['products'][index]['name']}",
              style: TextStyle(
                fontFamily: "font",
                color: Colors.black,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.end,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LayoutCubit.get(context).searchData[0]['data']['products'][index]
                          ['discount_price'] ==
                      0
                  ? SizedBox()
                  : Text(
                      "\$ ${LayoutCubit.get(context).searchData[0]['data']['products'][index]['price']}",
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
                "\$ ${LayoutCubit.get(context).searchData[0]['data']['products'][index]['price_after_discount']}",
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
            return Icon(
              Icons.star,
              color: Colors.amber,
              size: 15.0,
            );
          }),
    );
  }
}
