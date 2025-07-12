import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/bag_bloc/bag_cubit.dart';
import 'package:flutter_application_1/bloc/bag_bloc/bag_state.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/config/app_texts.dart';
import 'package:flutter_application_1/ui/screens/pages/detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BagCubit>(context).getTotalPrice();
    BlocProvider.of<BagCubit>(context).isEmptys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Bag", style: TextStyle(fontSize: 17.sp)),
        centerTitle: true,
      ),
      body: BlocBuilder<BagCubit, BagState>(
        builder: (context, state) {
          return state.bagList.isEmpty
              ? Center(
                  child: Text(
                    AppTexts.noBag,
                    style: TextStyle(fontSize: 20.sp, color: AppColors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: state.bagList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(30.r),
                      onTap: () async {
                        final back = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(product: state.bagList[index]),
                          ),
                        );
                        if (back == "setState") {
                          setState(() {});
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.grey),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: CachedNetworkImage(
                                  height: 100.h,
                                  width: 100.w,
                                  fit: BoxFit.contain,
                                  imageUrl: state.bagList[index].image,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.orange,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${state.bagList[index].title}...",
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          state.bagList[index].category,
                                          style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Row(
                                          children: [
                                            RatingBar.readOnly(
                                              initialRating:
                                                  state.bagList[index].rate,
                                              maxRating: 5,
                                              filledIcon: Icons.star,
                                              emptyIcon: Icons.star_border,
                                              halfFilledIcon: Icons.star_half,
                                              filledColor: AppColors.amber,
                                              size: 20.sp,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "(${state.bagList[index].ratingCount})",
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "${state.bagList[index].price}\$",
                                          style: TextStyle(
                                            color: AppColors.green,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: -10,
                                      right: 0,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onLongPress: () => setState(() {
                                              state.bagList[index].count = 1;
                                            }),
                                            onPressed: () {
                                              if (state.bagList[index].count ==
                                                  1) {
                                                setState(() {
                                                  state.bagList.remove(
                                                    state.bagList[index],
                                                  );
                                                });
                                              } else {
                                                setState(() {
                                                  state.bagList[index].count--;
                                                });
                                              }
                                            },
                                            icon: Icon(
                                              Icons.remove_shopping_cart_sharp,
                                              color: AppColors.red,
                                            ),
                                          ),
                                          Text('${state.bagList[index].count}'),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                state.bagList[index].count++;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.add_shopping_cart,
                                              color: AppColors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
