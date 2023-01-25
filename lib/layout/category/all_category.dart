import 'package:advera/controller/color.dart';
import 'package:advera/data/cubit/layout_cubit.dart';
import 'package:advera/layout/category/product_in_category.dart';
import 'package:advera/layout/category/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "المصنفات",
                  style: TextStyle(fontFamily: "font", fontSize: 18),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          body: Container(
            color: Colors.grey[100],
            width: double.infinity,
            height: double.infinity,
            child: SizedBox(
              child: state is GetProductHomeLoaded
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: LayoutCubit.get(context)
                            .category[0]['data']['categories']
                            .length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            mainAxisExtent: 165.0.h,
                            crossAxisSpacing: 18.0.w),
                        itemBuilder: (_, index) {
                          return BuildCategory(context, index);
                        },
                      ),
                    ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

Widget BuildCategory(BuildContext context, int index) {
  return InkWell(
    onTap: () {
      // LayoutCubit.get(context).getProductCategoryScreen(
      //     id_category: LayoutCubit.get(context).category[0]['data']
      //         ['categories'][index]['id']);
      print(LayoutCubit.get(context).category[0]['data']['categories'][index]
          ['id']);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => SubCategory(
                    category_id: LayoutCubit.get(context).category[0]['data']
                        ['categories'][index]['id'],
                  )));
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 100.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(
                  LayoutCubit.get(context).category[0]['data']['categories']
                      [index]['image'],
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.black.withOpacity(0.6),
            ),
            child: Center(
              child: Text(
                LayoutCubit.get(context).category[0]['data']['categories']
                    [index]['name'],
                style: TextStyle(
                    fontFamily: "font", fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
