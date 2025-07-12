import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/profile_bloc/profile_cubit.dart';
import 'package:flutter_application_1/bloc/profile_bloc/profile_state.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/config/app_texts.dart';
import 'package:flutter_application_1/ui/screens/BottomPage/bag_page.dart';
import 'package:flutter_application_1/ui/screens/BottomPage/favorite_page.dart';
import 'package:flutter_application_1/ui/screens/settings/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).requestBacend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return state.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.orange,
                    strokeAlign: 5,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 90.h),
                      Text(
                        "\t\tMy Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.sp, top: 10.sp),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30.r,
                              backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlie4MsQ9pJSSKY7DoEpxn3uBAq-rT7in1sA&s',
                              ),
                            ),
                            SizedBox(width: 10.w),
                            state.userModel != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.userModel?.username ?? "",
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                      Text(
                                        state.userModel?.email ?? "",
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BagPage()),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'My bag',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, size: 17.sp),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      MaterialButton(
                        height: 50.h,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritePage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Wishlist',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, size: 17.sp),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      MaterialButton(
                        height: 50.h,
                        onPressed: () {
                          BlocProvider.of<ProfileCubit>(
                            context,
                          ).getShowAddress();
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Shipping addresses',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              state.showAddress
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 17.sp,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: state.showAddress,
                        child: Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.grey,
                                width: 1.sp,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.grey,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: ${state.userModel!.username}",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Email: ${state.userModel!.email}",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Password: ${state.userModel!.password}",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Address: ${state.userModel!.address.city}",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Phone: ${state.userModel!.phone}",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      MaterialButton(
                        height: 50.h,
                        onPressed: () {
                          BlocProvider.of<ProfileCubit>(context).getShowTerms();
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Terms of Use',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              state.showTerms
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 17.sp,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: state.showTerms,
                        child: Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: AppColors.grey),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppTexts.text_1),
                                SizedBox(height: 5.sp),
                                Text(AppTexts.text_2),
                                SizedBox(height: 5.sp),
                                Text(AppTexts.text_3),
                                SizedBox(height: 5.sp),
                                Text(AppTexts.text_4),
                                SizedBox(height: 5.sp),
                                Text(AppTexts.text_5),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),
                      MaterialButton(
                        height: 50.h,
                        onPressed: () {
                          if (state.userModel != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Setting(userModel: state.userModel!),
                              ),
                            );
                          }
                        },

                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Setings',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, size: 17.sp),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
