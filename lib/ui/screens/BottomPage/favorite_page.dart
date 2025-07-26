import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:flutter_application_1/bloc/favorite_bloc/favorite_state.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/config/app_texts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoriteCubit>(context).getFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Favorites", style: TextStyle(fontSize: 23.sp)),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          return state.favoriteModel.isEmpty
              ? Center(
                  child: Text(
                    AppTexts.nofavorite,
                    style: TextStyle(fontSize: 20.sp, color: AppColors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: state.favoriteModel.length,
                  itemBuilder: (context, index) {
                    final product = state.favoriteModel[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 10.sp,
                        right: 10.sp,
                        top: 10.sp,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.sp),
                          border: Border.all(color: AppColors.grey),
                          boxShadow: [
                            BoxShadow(color: AppColors.grey, blurRadius: 4.r),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CachedNetworkImage(
                                height: 50.w,
                                width: 50.h,
                                imageUrl: product.image,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.orange,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.sp),
                                  Text(
                                    "\$${product.price}",
                                    style: TextStyle(
                                      color: AppColors.green,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: AppColors.red,
                                size: 20.sp,
                              ),
                              onPressed: () {
                                BlocProvider.of<FavoriteCubit>(
                                  context,
                                ).removerFavoriteList(index);
                                setState(() {});
                              },
                            ),
                          ],
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
