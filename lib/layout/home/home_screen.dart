import 'package:advera/auth/login_screen.dart';
import 'package:advera/controller/color.dart';
import 'package:advera/controller/token.dart';
import 'package:advera/data/cubit/advera_cubit.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/helper/shared_refrence.dart';
import 'package:advera/layout/category/all_category.dart';
import 'package:advera/layout/category/product_in_category.dart';
import 'package:advera/layout/category/sub_category.dart';
import 'package:advera/layout/notifecation/notifecation.dart';
import 'package:advera/layout/product/all_product.dart';
import 'package:advera/layout/product/details_product.dart';
import 'package:advera/layout/search/search_page.dart';
import 'package:advera/widget/font_styles.dart';

import 'package:advera/widget/shimmerEffect.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            title: const Text(
              "Advera Store",
              style: TextStyle(
                fontFamily: "font",
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Notifecation(),
                    ),
                  );
                },
                icon: Icon(Icons.notification_important_rounded),
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    state is GetSliderHomeLoaded ||
                            LayoutCubit.get(context).slidertHome.isEmpty
                        ? ShimmerEffect(
                            borderRadius: 10.0.r,
                            height: 88.h,
                            width: 343.w,
                          )
                        : SizedBox(
                            height: 100,
                            // child: PageView.builder(
                            //   allowImplicitScrolling: true,
                            //   controller: controller,
                            //   itemCount: pages.length,
                            //   itemBuilder: (_, index) {
                            //     return pages[index % pages.length];
                            //   },
                            // ),
                            child: CarouselSlider.builder(
                                unlimitedMode: true,
                                autoSliderDelay: const Duration(seconds: 5),
                                enableAutoSlider: true,
                                slideBuilder: (index) {
                                  return InkWell(
                                    onTap: () async {
                                      final Uri _url = Uri.parse(
                                          LayoutCubit.get(context)
                                                  .slidertHome[0]['data']
                                              ['sliders'][index]['link']);

                                      if (!await launchUrl(_url)) {
                                        throw 'Could not launch $_url';
                                      }
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: LayoutCubit.get(context)
                                              .slidertHome[0]['data']['sliders']
                                          [index]['image'],
                                      color:
                                          const Color.fromRGBO(42, 3, 75, 0.35),
                                      colorBlendMode: BlendMode.srcOver,
                                      fit: BoxFit.fill,
                                      placeholder: (context, name) {
                                        return ShimmerEffect(
                                          borderRadius: 10.0.r,
                                          height: 88.h,
                                          width: 343.w,
                                        );
                                      },
                                      errorWidget: (context, error, child) {
                                        return ShimmerEffect(
                                          borderRadius: 10.0.r,
                                          height: 88.h,
                                          width: 343.w,
                                        );
                                      },
                                    ),
                                  );
                                },
                                slideTransform: DefaultTransform(),
                                slideIndicator: CircularSlideIndicator(
                                  currentIndicatorColor: Colors.white,
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.only(
                                      bottom: 10.h, left: 20.0.w),
                                ),
                                itemCount: LayoutCubit.get(context)
                                    .slidertHome[0]['data']['sliders']
                                    .length),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AllCategory(),
                              ),
                            );
                          },
                          child: Text(
                            "الكل",
                            style: TextStyle(
                              color: primaryColor,
                              fontFamily: "font",
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Text(
                          "التصنيفات",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "font",
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    state is GetCategoryLoaded
                        ? ShimmerEffect(
                            borderRadius: 10.0.r,
                            height: 88.h,
                            width: 343.w,
                          )
                        : Container(
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 2),
                              child: LayoutCubit.get(context).category.isEmpty
                                  ? ShimmerEffect(
                                      borderRadius: 10.0.r,
                                      height: 88.h,
                                      width: 343.w,
                                    )
                                  : ListView.separated(
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            // LayoutCubit.get(context)
                                            //     .getProductCategoryScreen(
                                            //         id_category: LayoutCubit.get(
                                            //                             context)
                                            //                         .category[0]
                                            //                     ['data']
                                            //                 ['categories']
                                            //             [index]['id']);
                                            // print(LayoutCubit.get(context)
                                            //         .category[0]['data']
                                            //     ['categories'][index]['id']);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => SubCategory(
                                                          category_id: LayoutCubit.get(
                                                                              context)
                                                                          .category[
                                                                      0]['data']
                                                                  ['categories']
                                                              [index]['id'],
                                                        )));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 7,
                                                  offset: const Offset(0,
                                                      2), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            // 55 80

                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      LayoutCubit.get(context)
                                                                      .category[0]
                                                                  ['data']
                                                              ['categories']
                                                          [index]['name'],
                                                      style: const TextStyle(
                                                          fontFamily: 'font',
                                                          fontSize: 15),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl: LayoutCubit.get(
                                                                      context)
                                                                  .category[0][
                                                              'data']['categories']
                                                          [index]['image'],
                                                      // fit: BoxFit.contain,
                                                      height: 55,
                                                      width: 80,
                                                      placeholder:
                                                          (context, name) {
                                                        return const ShimmerEffect(
                                                            borderRadius: 10.0,
                                                            height: 55,
                                                            width: 80);
                                                      },
                                                      errorWidget: (context,
                                                          error, child) {
                                                        return ShimmerEffect(
                                                          borderRadius: 10.0,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .20,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .45,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 10,
                                        );
                                      },
                                      itemCount: LayoutCubit.get(context)
                                          .category[0]['data']['categories']
                                          .length),
                            ),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AllProduct(),
                              ),
                            );
                          },
                          child: Text(
                            "الكل",
                            style: TextStyle(
                              color: primaryColor,
                              fontFamily: "font",
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Text(
                          "اخر العروض",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "font",
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    state is GetProductHomeLoaded
                        ? ShimmerEffect(
                            borderRadius: 10.0.r,
                            height: 88.h,
                            width: 343.w,
                          )
                        : Container(
                            height: 225.h,
                            child: LayoutCubit.get(context).productHome.isEmpty
                                ? ShimmerEffect(
                                    borderRadius: 10.0.r,
                                    height: 80.h,
                                    width: 343.w,
                                  )
                                : Swiper(
                                    itemCount: LayoutCubit.get(context)
                                        .productHomeOffer
                                        .length,
                                    autoplay: true,
                                    viewportFraction: 0.4 + 0.05,
                                    scale: 0.7,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => ProductDetails(
                                                      product: LayoutCubit.get(
                                                                  context)
                                                              .productHomeOffer[
                                                          index])));
                                        },
                                        child: Container(
                                          width: 155.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white.withOpacity(1),
                                          ),
                                          child: BuildProuduct(context, index),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AllProduct(),
                              ),
                            );
                          },
                          child: Text(
                            "الكل",
                            style: TextStyle(
                              color: primaryColor,
                              fontFamily: "font",
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Text(
                          "المنتجات",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "font",
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    state is GetProductHomeLoaded
                        ? ShimmerEffect(
                            borderRadius: 10.0.r,
                            height: 88.h,
                            width: 343.w,
                          )
                        : Container(
                            height: 225.h,
                            child: LayoutCubit.get(context).productHome.isEmpty
                                ? ShimmerEffect(
                                    borderRadius: 10.0.r,
                                    height: 80.h,
                                    width: 343.w,
                                  )
                                : Swiper(
                                    itemCount: LayoutCubit.get(context)
                                        .productHomeNotOffer
                                        .length,
                                    autoplay: true,
                                    viewportFraction: 0.4 + 0.05,
                                    scale: 0.7,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => ProductDetails(
                                                      product: LayoutCubit.get(
                                                                  context)
                                                              .productHomeNotOffer[
                                                          index])));
                                        },
                                        child: Container(
                                          width: 155.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white.withOpacity(1),
                                          ),
                                          child: BuildProuductNotOffer(
                                              context, index),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AddFavDone) {
          if (state.status == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
                content: Text(
                  "تم الاضافة الى المفضلة",
                  style: TextStyle(
                    fontFamily: "font",
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            );
          } else if (state.status == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                backgroundColor: Colors.red,
                content: Text(
                  "تم الاضافة مسبقا",
                  style: TextStyle(
                    fontFamily: "font",
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            );
          }
        }
      },
    );
  }

  Column BuildProuductNotOffer(BuildContext context, int index) {
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
                  imageUrl: LayoutCubit.get(context).productHomeNotOffer[index]
                      ['images'][0],
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
            // LayoutCubit.get(context).productHomeNotOffer[index]
            //             ['discount_price'] >
            //         0
            //     ? SizedBox()
            //     : Container(
            //         margin: const EdgeInsets.only(top: 10.0),
            //         width: 47.0,
            //         decoration: const BoxDecoration(
            //           borderRadius: BorderRadius.only(
            //             bottomRight: Radius.circular(10.0),
            //             topRight: Radius.circular(10.0),
            //           ),
            //           gradient: LinearGradient(
            //             colors: [Color(0xFFF49763), Color(0xFFD23A3A)],
            //             stops: [0, 1],
            //             begin: Alignment.bottomRight,
            //             end: Alignment.topLeft,
            //           ),
            //         ),
            //         child: Center(
            //           child: Text(
            //             "% ${LayoutCubit.get(context).productHomeNotOffer[index]['discount_price']}",
            //             style: FontStyles.montserratBold17()
            //                 .copyWith(fontSize: 11.0, color: Colors.white),
            //           ),
            //         ),
            //       ),
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
                    if (LayoutCubit.get(context).productHomeNotOffer[index]
                            ['auth']['is_liked'] ==
                        0) {
                      LayoutCubit.get(context).addFav(
                          id: LayoutCubit.get(context)
                              .productHomeNotOffer[index]['id']);
                    } else if (LayoutCubit.get(context)
                            .productHomeNotOffer[index]['is_liked'] ==
                        1) {
                      LayoutCubit.get(context).deleteFav(
                          id: LayoutCubit.get(context)
                              .productHomeNotOffer[index]['id']);
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
                    LayoutCubit.get(context).productHomeNotOffer[index]['auth']
                                ['is_liked'] ==
                            1
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: LayoutCubit.get(context).productHomeNotOffer[index]
                                ['auth']['is_liked'] ==
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
                    if (LayoutCubit.get(context).productHomeNotOffer[index]
                            ['auth']['is_added_to_cart'] ==
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
                                  product: LayoutCubit.get(context)
                                      .productHomeNotOffer[index])));
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
                    LayoutCubit.get(context).productHomeNotOffer[index]['auth']
                                ['is_added_to_cart'] ==
                            1
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                    color: LayoutCubit.get(context).productHomeNotOffer[index]
                                ['auth']['is_added_to_cart'] ==
                            1
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        //  _buildRatings(context),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${LayoutCubit.get(context).productHomeNotOffer[index]['name']}",
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
              // LayoutCubit.get(context).productHomeNotOffer[index]
              //             ['discount_price'] !=
              //         0
              //     ? SizedBox()
              //     : Text(
              //         "\$ ${LayoutCubit.get(context).productHomeNotOffer[index]['price']}",
              //         style: TextStyle(
              //           color: pageColor,
              //           fontSize: 16,
              //           decoration: TextDecoration.lineThrough,
              //         ),
              //       ),
              const SizedBox(
                width: 30,
              ),
              Text(
                "₪ ${LayoutCubit.get(context).productHomeNotOffer[index]['price_after_discount']}",
                style: TextStyle(
                    color: green, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
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
                  imageUrl: LayoutCubit.get(context).productHomeOffer[index]
                      ['images'][0],
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
            LayoutCubit.get(context).productHomeOffer[index]
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
                        "% ${LayoutCubit.get(context).productHomeOffer[index]['discount_price']}",
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
                    if (LayoutCubit.get(context).productHomeOffer[index]['auth']
                            ['is_liked'] ==
                        0) {
                      LayoutCubit.get(context).addFav(
                          id: LayoutCubit.get(context).productHomeOffer[index]
                              ['id']);
                    } else if (LayoutCubit.get(context).productHomeOffer[index]
                            ['is_liked'] ==
                        1) {
                      LayoutCubit.get(context).deleteFav(
                          id: LayoutCubit.get(context).productHomeOffer[index]
                              ['id']);
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
                    LayoutCubit.get(context).productHomeOffer[index]['auth']
                                ['is_liked'] ==
                            1
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: LayoutCubit.get(context).productHomeOffer[index]
                                ['auth']['is_liked'] ==
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
                    if (LayoutCubit.get(context).productHomeOffer[index]['auth']
                            ['is_added_to_cart'] ==
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
                                  product: LayoutCubit.get(context)
                                      .productHomeOffer[index])));
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
                    LayoutCubit.get(context).productHomeOffer[index]['auth']
                                ['is_added_to_cart'] ==
                            1
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                    color: LayoutCubit.get(context).productHomeOffer[index]
                                ['auth']['is_added_to_cart'] ==
                            1
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        //  _buildRatings(context),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${LayoutCubit.get(context).productHomeOffer[index]['name']}",
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
        FittedBox(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LayoutCubit.get(context).productHomeOffer[index]
                            ['discount_price'] ==
                        0
                    ? SizedBox()
                    : Text(
                        "₪ ${LayoutCubit.get(context).productHomeOffer[index]['price']}",
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
                  "₪ ${LayoutCubit.get(context).productHomeOffer[index]['price_after_discount']}",
                  style: TextStyle(
                      color: green, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



  Widget makeSlider() {
    return CarouselSlider.builder(
        unlimitedMode: true,
        autoSliderDelay: const Duration(seconds: 5),
        enableAutoSlider: true,
        slideBuilder: (index) {
          return CachedNetworkImage(
            imageUrl: LayoutCubit.get(context).category[0]['data']['sliders']
                [index]['image'],
            color: const Color.fromRGBO(42, 3, 75, 0.35),
            colorBlendMode: BlendMode.srcOver,
            fit: BoxFit.fill,
            placeholder: (context, name) {
              return ShimmerEffect(
                borderRadius: 10.0.r,
                height: 88.h,
                width: 343.w,
              );
            },
            errorWidget: (context, error, child) {
              return ShimmerEffect(
                borderRadius: 10.0.r,
                height: 88.h,
                width: 343.w,
              );
            },
          );
        },
        slideTransform: DefaultTransform(),
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: Colors.lightGreen,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10.h, left: 20.0.w),
        ),
        itemCount:
            LayoutCubit.get(context).category[0]['data']['sliders'].length);
  }
}
