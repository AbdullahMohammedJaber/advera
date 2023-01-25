import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/layout/cart/adress_order.dart';
import 'package:advera/widget/shimmerEffect.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartFull extends StatefulWidget {
  const CartFull({Key? key}) : super(key: key);

  @override
  State<CartFull> createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ItemCart(
                            context: context,
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: LayoutCubit.get(context)
                            .cartItem[0]['data']['carts']['products']
                            .length),
                  ),
                ),
                Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            if (LayoutCubit.get(context).cartItem[0]['data']
                                    ['carts']['totalPrice'] ==
                                0) {
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AdressOrder()));
                              // LayoutCubit.get(context).addOrder();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 47,
                            decoration: BoxDecoration(
                              color: pageColor,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: state is AddOrderLoaded
                                  ? Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    )
                                  : Text(
                                      "تنفيذ الطلبية",
                                      style: TextStyle(
                                        fontFamily: "font",
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          height: 47,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$${LayoutCubit.get(context).cartItem[0]['data']['carts']['totalPrice']}",
                                style: const TextStyle(
                                  fontFamily: "font",
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                " : اجمالي السعر",
                                style: TextStyle(
                                  fontFamily: "font",
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AddOrderDone) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "تم تنفيذ طلبك قيد المراجعة",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "font",
                ),
                textAlign: TextAlign.end,
              ),
            ),
          );
          LayoutCubit.get(context).changeIndexOrder();
        }
      },
    );
  }
}

class ItemCart extends StatelessWidget {
  final int index;
  final BuildContext context;

  const ItemCart({Key? key, required this.index, required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${LayoutCubit.get(context).cartItem[0]['data']['carts']['products'][index]['name']}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: "font",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "\$${LayoutCubit.get(context).cartItem[0]['data']['carts']['products'][index]['price_after_discount']}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: "font",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${LayoutCubit.get(context).cartItem[0]['data']['carts']['products'][index]['amount']}",
                      style: TextStyle(fontFamily: "font", fontSize: 16),
                      textAlign: TextAlign.end,
                    ),
                    Text(
                      " : عدد القطع",
                      style: TextStyle(fontFamily: "font", fontSize: 16),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: LayoutCubit.get(context).cartItem[0]['data']['carts']
                  ['products'][index]['images'][0],
              height: 120,
              placeholder: (context, name) {
                return ShimmerEffect(
                  borderRadius: 10.0,
                  height: 120,
                );
              },
              errorWidget: (context, error, child) {
                return ShimmerEffect(
                  borderRadius: 10.0,
                  height: 120,
                );
              },
            ),

            //  Image(
            //   image: NetworkImage(
            //     "${LayoutCubit.get(context).cartItem[0]['data']['carts']['products'][index]['images'][0]}",
            //   ),
            //   height: 120,
            // ),
          ),
        ],
      ),
    );
  }
}
