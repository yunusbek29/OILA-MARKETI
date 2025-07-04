import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/bag_bloc/bag_cubit.dart';
import 'package:flutter_application_1/bloc/bag_bloc/bag_state.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/config/app_texts.dart';
import 'package:flutter_application_1/ui/screens/pages/detail_page.dart';
import 'package:flutter_application_1/ui/screens/pages/global_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<BagCubit>(context).isEmptys();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Bag"),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: BlocBuilder<BagCubit, BagState>(
        builder: (context, state) {
          return state.isEmpty
              ? Center(
                  child: Text(
                    AppTexts.noBag,
                    style: TextStyle(fontSize: 20, color: AppColors.grey),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: bagList.length,
                        itemBuilder: (context, index) {
                          final product = bagList[index];
                          return InkWell(
                            onTap: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(product: product),
                                ),
                              );
                              if (result == "setState") {
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
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.grey),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: CachedNetworkImage(
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.orange,
                                            ),
                                          );
                                        },
                                        imageUrl: product.image,
                                      ),
                                    ),
                                    SizedBox(width: 10),
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
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                product.category,
                                                style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  RatingBar.readOnly(
                                                    initialRating: product.rate,
                                                    maxRating: 5,
                                                    filledIcon: Icons.star,
                                                    emptyIcon:
                                                        Icons.star_border,
                                                    halfFilledIcon:
                                                        Icons.star_half,
                                                    filledColor:
                                                        AppColors.amber,
                                                    emptyColor: AppColors.grey,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "(${product.ratingCount})",
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "${product.price * product.count}\$",
                                                style: TextStyle(
                                                  color: AppColors.green,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            bottom: -10,
                                            left: 80,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      product.count++;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.add_shopping_cart,
                                                    color: AppColors.green,
                                                  ),
                                                  iconSize: 24,
                                                ),
                                                Text(
                                                  "x${product.count}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.orange,
                                                  ),
                                                ),
                                                IconButton(
                                                  onLongPress: () {
                                                    setState(() {
                                                      product.count = 1;
                                                    });
                                                  },
                                                  onPressed: () {
                                                    setState(() {
                                                      if (product.count > 1) {
                                                        product.count--;
                                                      } else {
                                                        // bagList.remove(product);
                                                        BlocProvider.of<
                                                              BagCubit
                                                            >(context)
                                                            .isEmptys();
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.remove_shopping_cart,
                                                    color: AppColors.red,
                                                  ),
                                                  iconSize: 24,
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
                      ),
                    ),
                    Container(
                      height: 50,
                      color: AppColors.black,
                      child: Row(
                        children: [
                          // Expanded(
                          //   child: Text(
                          //     'Total Product: ${bagList.length}',
                          //     style: TextStyle(
                          //       color: AppColors.white,
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                          Text(
                            'Total Price: \$${BlocProvider.of<BagCubit>(context).getTotalPrice().toString()}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
