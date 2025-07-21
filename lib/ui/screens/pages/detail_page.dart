import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/bag_bloc/bag_cubit.dart';
import 'package:flutter_application_1/bloc/detail_bloc/detail_cubit.dart';
import 'package:flutter_application_1/bloc/detail_bloc/detail_state.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/data/local/database_servise.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPage extends StatefulWidget {
  final ProductModel product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        title: Text(widget.product.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, "setState");
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [Icon(Icons.info), Text("Mahsulot saqlangan")],
                    ),
                    showCloseIcon: true,
                  ),
                );
              await DatabaseServise.database?.productDao.saveProduct(
                widget.product,
              );
              BlocProvider.of<BagCubit>(context).count();
            },
            icon: Icon(
              widget.product.isLiked ? Icons.favorite : Icons.favorite_border,
              color: AppColors.red,
            ),
          ),
        ],
      ),
      body: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: CachedNetworkImage(
                        width: MediaQuery.sizeOf(context).width,
                        imageUrl: widget.product.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.category,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                          Text(
                            "\$${widget.product.price}",
                            style: TextStyle(
                              color: AppColors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RatingBar.readOnly(
                            initialRating: widget.product.rate,
                            maxRating: 5,
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            halfFilledIcon: Icons.star_half,
                            filledColor: AppColors.amber,
                            size: 20.sp,
                          ),
                          Text(
                            "(${widget.product.ratingCount.toString()})",
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        widget.product.description,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Shipping info",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Support",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<DetailCubit>(
                      context,
                    ).addToBag(widget.product);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.info),
                              Text("Mahsulot qoshildi"),
                            ],
                          ),
                          showCloseIcon: true,
                        ),
                      );
                    await DatabaseServise.database?.productDao.saveProduct(
                      widget.product,
                    );
                    BlocProvider.of<BagCubit>(context).count();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  ),
                  child: Text(
                    "ADD TO BAG",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
