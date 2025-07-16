import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/data/repository/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Setting extends StatefulWidget {
  final UserModel userModel;
  const Setting({super.key, required this.userModel});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.userModel.username);
    emailController = TextEditingController(text: widget.userModel.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit profile',
          style: TextStyle(color: AppColors.white, fontSize: 20.sp),
        ),
        backgroundColor: AppColors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: AppColors.grey, blurRadius: 5.r),
                  ],
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey,
                      spreadRadius: 1.r,
                      blurRadius: 5.r,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 60.h,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.white,
                      spreadRadius: 0.1.r,
                      blurRadius: 5.r,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: InkWell(
                  splashColor: AppColors.white,
                  borderRadius: BorderRadius.circular(50.r),
                  onTap: () {
                    String name = nameController.text;
                    String email = emailController.text;
                    print('Name: $name, Email: $email');
                    Navigator.pop(context, "load");
                  },
                  child: Center(
                    child: Text('Save', style: TextStyle(fontSize: 20.sp)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
