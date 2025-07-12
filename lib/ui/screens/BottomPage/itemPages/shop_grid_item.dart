import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';
import 'package:flutter_application_1/ui/screens/pages/detail_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopPageGrid extends StatefulWidget {
  final ProductModel product;
  const ShopPageGrid({super.key, required this.product});

  @override
  State<ShopPageGrid> createState() => _ShopPageGridState();
}

class _ShopPageGridState extends State<ShopPageGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.r),
      onTap: () async {
        final back = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(product: widget.product),
          ),
        );
        if (back == 'setState') {
          setState(() {});
        } else {
          setState(() {});
        }
      },
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColors.grey),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10.sp,
                          left: 2.sp,
                          right: 4.sp,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.product.image,
                          height: 150.h,
                          width: 150.w,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: AppColors.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
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
                          "(${widget.product.ratingCount})",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "${widget.product.title}...",
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      widget.product.category,
                      style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                    ),
                    Text(
                      "${widget.product.price.toString()}\$",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                        fontSize: 16.sp,
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
  }
}
