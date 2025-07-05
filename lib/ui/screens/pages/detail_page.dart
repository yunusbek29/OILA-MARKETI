import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/detail_bloc/detail_cubit.dart';
import 'package:flutter_application_1/bloc/detail_bloc/detail_state.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/data/local/shared/shared_pref.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';
import 'package:flutter_application_1/ui/screens/BottomPage/bag_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  final ProductModel product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int son = 1;
  SharedPref shared = SharedPref();
  @override
  void initState() {
    super.initState();
    getBool();
    loadBagList();
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
              setBool();
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
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.category,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Text(
                            "\$${widget.product.price}",
                            style: TextStyle(
                              color: AppColors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                            size: 20,
                          ),
                          Text(
                            "(${widget.product.ratingCount.toString()})",
                            style: TextStyle(color: AppColors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.product.description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
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
                            fontSize: 20,
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
                SizedBox(height: 10),
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Support",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
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
                    List<ProductModel> bagList = await shared.getProductList(
                      'bagList',
                    );
                    List<int> bagQuantity = await shared.getIntList(
                      'bagQuantity',
                    );

                    int index = bagList.indexWhere(
                      (item) => item.id == widget.product.id,
                    );

                    if (index != -1) {
                      bagQuantity[index] += son;
                    } else {
                      bagList.add(widget.product);
                      bagQuantity.add(son);
                    }

                    await shared.saveProductList('bagList', bagList);
                    await shared.saveIntList('bagQuantity', bagQuantity);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    "ADD TO BAG",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getBool() async {
    final liked =
        await SharedPref.getBool('isLiked${widget.product.id}') ?? false;
    setState(() {
      widget.product.isLiked = liked;
    });
  }

  void setBool() async {
    if (widget.product.isLiked) {
      await SharedPref.remove('isLiked${widget.product.id}');
    } else {
      await SharedPref.setBool('isLiked${widget.product.id}', true);
    }
    setState(() {
      widget.product.isLiked = !widget.product.isLiked;
    });
  }

  Future<void> saveBagList(List<ProductModel> bagList) async {
    List<String> jsonList = bagList
        .map((product) => jsonEncode(product.toJson()))
        .toList();
    await SharedPref.setStringList("bag", jsonList);
  }

  Future<List<ProductModel>> loadBagList() async {
    List<String>? jsonList = await SharedPref.getStringList("bag");
    if (jsonList == null) return [];

    return jsonList
        .map((jsonString) => ProductModel.fromJson(jsonDecode(jsonString)))
        .toList();
  }
}
