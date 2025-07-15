import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/shop_bloc/shop_cubit.dart';
import 'package:flutter_application_1/bloc/shop_bloc/shop_state.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/ui/screens/BottomPage/itemPages/shop_grid_item.dart';
import 'package:flutter_application_1/ui/screens/BottomPage/itemPages/shop_list_item.dart';
import 'package:flutter_application_1/ui/screens/pages/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ShopCubit>(context).getLoadList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.white,

        title: Text(
          'Products',
          style: TextStyle(color: AppColors.orange, fontSize: 23.sp),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            icon: Icon(Icons.search, color: AppColors.orange, size: 23.sp),
          ),
        ],
      ),
      body: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          return RefreshIndicator(
            backgroundColor: AppColors.red,
            color: AppColors.black,

            onRefresh: BlocProvider.of<ShopCubit>(context).refresh,
            child: Column(
              children: [
                Container(
                  color: AppColors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 50.h,
                  child: Row(
                    children: [
                      Icon(Icons.filter_list, size: 17.sp),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Popular',
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Icon(Icons.swap_vert, size: 20.sp),
                      ),

                      IconButton(
                        onPressed: () {
                          BlocProvider.of<ShopCubit>(context).getIsOrder();
                        },
                        icon: Icon(
                          state.isOrder
                              ? Icons.grid_view_outlined
                              : Icons.format_list_bulleted,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.orange,
                            strokeAlign: 10.r,
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: state.isOrder
                                  ? ListView.builder(
                                      itemCount: state.productmodel.length,
                                      itemBuilder: (context, index) {
                                        final product =
                                            state.productmodel[index];
                                        return ShopPageList(product: product);
                                      },
                                    )
                                  : GridView.builder(
                                      itemCount: state.productmodel.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                            childAspectRatio: 0.59,
                                          ),
                                      itemBuilder: (context, index) {
                                        final product =
                                            state.productmodel[index];
                                        return ShopPageGrid(product: product);
                                      },
                                    ),
                            ),
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
