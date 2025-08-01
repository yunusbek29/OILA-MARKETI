import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/search_bloc/search_cubit.dart';
import 'package:flutter_application_1/bloc/search_bloc/search_state.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/ui/screens/pages/detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<SearchCubit>(context).getLoadList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'Search',
          style: TextStyle(color: AppColors.white, fontSize: 20.sp),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.sp, left: 10.sp, right: 10.sp),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                    child: TextField(
                      controller: controller,
                      onChanged: (text) {
                        BlocProvider.of<SearchCubit>(
                          context,
                        ).search(controller.text);
                      },
                      style: TextStyle(color: AppColors.white),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: AppColors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              state.isLoading
                  ? Center(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.orange,
                        ),
                      ),
                    )
                  : Expanded(
                      child: state.filteredProducts.isEmpty
                          ? Center(child: Text('Siz qidirgan mahsulot yoq'))
                          : ListView.builder(
                              itemCount: state.filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = state.filteredProducts[index];
                                return InkWell(
                                  borderRadius: BorderRadius.circular(30.r),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPage(product: product),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10.sp,
                                      right: 10.sp,
                                      bottom: 10.sp,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        border: Border.all(
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(10.sp),
                                            child: CachedNetworkImage(
                                              height: 100.h,
                                              width: 100.w,
                                              imageUrl: product.image,
                                              placeholder: (context, url) =>
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color:
                                                              AppColors.orange,
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
                                                      product.title,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      product.category,
                                                      style: TextStyle(
                                                        color: AppColors.grey,
                                                        fontSize: 13.sp,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    Row(
                                                      children: [
                                                        RatingBar.readOnly(
                                                          initialRating:
                                                              product.rate,
                                                          maxRating: 5,
                                                          filledIcon:
                                                              Icons.star,
                                                          emptyIcon:
                                                              Icons.star_border,
                                                          halfFilledIcon:
                                                              Icons.star_half,
                                                          filledColor:
                                                              AppColors.amber,
                                                          size: 20.sp,
                                                        ),
                                                        SizedBox(width: 4.w),
                                                        Text(
                                                          "(${product.ratingCount})",
                                                          style: TextStyle(
                                                            fontSize: 17.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    Text(
                                                      "${product.price}\$",
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
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
                            ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
