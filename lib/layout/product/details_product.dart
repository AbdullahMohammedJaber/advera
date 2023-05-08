import 'package:advera/auth/login_screen.dart';
import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/widget/font_styles.dart';
import 'package:advera/widget/shimmerEffect.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatefulWidget {
  final dynamic product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final controller = PageController(
    viewportFraction: 0.8,
    keepPage: true,
  );
  int amount = 1;
  @override
  void initState() {
    LayoutCubit.get(context).getProductCategoryScreen(
      id_category: widget.product['category']['category_id'],
    );
    amount = 1;
    super.initState();
  }

  void addAmount() {
    setState(() {
      amount++;
    });
  }

  void removAmount() {
    if (amount == 0) {
      setState(() {});
    } else {
      setState(() {
        amount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = List.generate(
        widget.product['images'].length,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Container(
                child: Image.network(
                  widget.product['images'][index],
                  // fit: BoxFit.cover,
                  width: 100,
                ),
              ),
            ));
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: primaryColor,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: PageView.builder(
                            reverse: true,
                            controller: controller,
                            itemBuilder: (_, index) {
                              return images[index % images.length];
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SmoothPageIndicator(
                          controller: controller,
                          count: images.length,
                          effect: const WormEffect(
                            dotHeight: 10,
                            dotWidth: 20,
                            type: WormType.thin,
                            // strokeWidth: 5,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.product['category']['name'],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "font",
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              const Spacer(),
                              Text(
                                widget.product['name'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "font",
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "₪ ${widget.product['price_after_discount']}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "font",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0;
                            i < widget.product['specifications'][0].length;
                            i++)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${widget.product['specifications'][1][i]}",
                                      style: TextStyle(
                                        fontFamily: "font",
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      ": ${widget.product['specifications'][0][i]}",
                                      style: TextStyle(
                                        fontFamily: "font",
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        _montagatMoshabeha(),
                        _montagatMoshabehaAll(),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      addCart(
                        state: state,
                        p: widget.product,
                        amount: amount,
                        productId: widget.product['id'],
                      ),
                      Container(
                          child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              addAmount();
                            },
                            icon: Icon(Icons.add),
                            color: green,
                          ),
                          Text("$amount",
                              style: TextStyle(
                                  fontFamily: "font",
                                  fontWeight: FontWeight.bold)),
                          IconButton(
                            onPressed: () {
                              removAmount();
                            },
                            icon: Icon(Icons.remove),
                            color: Colors.red,
                          ),
                        ],
                      )),
                      addFav(
                        product: widget.product,
                      ),
                    ],
                  ),
                ),
              ],
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
        } else if (state is AddCartDone) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: Colors.green,
              content: Text(
                "تم الاضافة الى السلة",
                style: TextStyle(
                  fontFamily: "font",
                  color: Colors.white,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          );
          setState(() {
            amount = 0;
          });
          Navigator.pop(context);
        }
      },
    );
  }
}

class addFav extends StatelessWidget {
  final dynamic product;

  const addFav({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false);
            },
            btnOkColor: swichColor,
            btnOkText: "تسجيل الدخول",
          ).show();
        } else {
          if (product['auth']['is_liked'] == 0) {
            LayoutCubit.get(context).addFav(id: product['id']);
          } else if (product['auth']['is_liked'] == 1) {
            LayoutCubit.get(context).deleteFav(id: product['id']);
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: 47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          Icons.favorite,
          color: product['auth']['is_liked'] == 1 ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}

class addCart extends StatelessWidget {
  final int productId;
  final int amount;
  final dynamic p;
  final LayoutState state;

  const addCart(
      {Key? key,
      required this.productId,
      required this.amount,
      required this.p,
      required this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false);
              },
              btnOkColor: swichColor,
              btnOkText: "تسجيل الدخول",
            ).show();
          } else {
            if (p['auth']['is_added_to_cart'] == 1) {
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
              LayoutCubit.get(context).addCart(id: productId, amount: amount);
            }
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 47,
          decoration: BoxDecoration(
            color: secondColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: state is AddCartLoaded
                ? Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : p['auth']['is_added_to_cart'] == 1
                    ? Text(
                        "في السلة",
                        style: TextStyle(
                          fontFamily: "font",
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "اضافة للسلة",
                        style: TextStyle(
                          fontFamily: "font",
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}

class _montagatMoshabeha extends StatelessWidget {
  const _montagatMoshabeha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text(
            ": منتجات مشابهة",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "font",
                fontSize: 14,
                decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}

class _montagatMoshabehaAll extends StatelessWidget {
  const _montagatMoshabehaAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 225.h,
      width: double.infinity,
      child: LayoutCubit.get(context).productCategory.isEmpty
          ? ShimmerEffect(
              borderRadius: 10.0.r,
              height: 80.h,
              width: 343.w,
            )
          : Swiper(
              itemCount: 6,
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
                                product:
                                    LayoutCubit.get(context).productCategory[0]
                                        ['data']['records']['posts'][index])));
                  },
                  child: Container(
                    width: 155.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(1),
                    ),
                    child: BuildProuduct(context, index),
                  ),
                );
              },
            ),
    );
  }
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
                imageUrl: LayoutCubit.get(context).productCategory[0]['data']
                    ['records']['posts'][index]['images'][0],
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
          LayoutCubit.get(context).productCategory[0]['data']['records']
                      ['posts'][index]['discount_price'] ==
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
                      "% ${LayoutCubit.get(context).productCategory[0]['data']['records']['posts'][index]['discount_price']}",
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
                  if (LayoutCubit.get(context).productCategory[0]['data']
                          ['records']['posts'][index]['auth']['is_liked'] ==
                      0) {
                    LayoutCubit.get(context).addFav(
                        id: LayoutCubit.get(context).productCategory[0]['data']
                            ['records']['posts'][index]['id']);
                  } else if (LayoutCubit.get(context).productCategory[0]['data']
                          ['records']['posts']['auth']['is_liked'] ==
                      1) {
                    LayoutCubit.get(context).deleteFav(
                        id: LayoutCubit.get(context).productCategory[0]['data']
                            ['records']['posts'][index]['id']);
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
                  LayoutCubit.get(context).productCategory[0]['data']['records']
                              ['posts'][index]['auth']['is_liked'] ==
                          1
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: LayoutCubit.get(context).productCategory[0]['data']
                              ['records']['posts'][index]['auth']['is_liked'] ==
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
                  if (LayoutCubit.get(context).productCategory[0]['data']
                              ['records']['posts'][index]['auth']
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
                                product:
                                    LayoutCubit.get(context).productCategory[0]
                                        ['data']['records']['posts'][index])));
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
                  LayoutCubit.get(context).productCategory[0]['data']['records']
                              ['posts'][index]['auth']['is_added_to_cart'] ==
                          1
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                  color: LayoutCubit.get(context).productCategory[0]['data']
                                  ['records']['posts'][index]['auth']
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
      SizedBox(
        height: 10,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "${LayoutCubit.get(context).productCategory[0]['data']['records']['posts'][index]['name']}",
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
            LayoutCubit.get(context).productCategory[0]['data']['records']
                        ['posts'][index]['discount_price'] ==
                    0
                ? SizedBox()
                : Text(
                    "₪ ${LayoutCubit.get(context).productCategory[0]['data']['records']['posts'][index]['price']}",
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
              "₪ ${LayoutCubit.get(context).productCategory[0]['data']['records']['posts'][index]['price_after_discount']}",
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
