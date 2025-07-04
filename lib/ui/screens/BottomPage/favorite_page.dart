import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/config/app_texts.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';
import 'package:flutter_application_1/ui/screens/pages/global_list.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<ProductModel> favorite = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: favoriteList.isEmpty
          ? const Center(
              child: Text(
                AppTexts.nofavorite,
                style: TextStyle(fontSize: 20, color: AppColors.grey),
              ),
            )
          : ListView.builder(
              // itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                // final product = favoriteList[index];
                return InkWell(
                  // onTap: () => Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  // builder: (context) => DetailPage(product: product),
                  // ),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey,
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Expanded(
                          // flex: 1,
                          // child: CachedNetworkImage(
                          //   height: 50,
                          //   width: 50,
                          //   imageUrl: product.image,
                          // ),
                          // ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                // product.title,
                                // maxLines: 1,
                                // overflow: TextOverflow.ellipsis,
                                // style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                // fontSize: 16,
                                // ),
                                // ),
                                const SizedBox(height: 4),
                                // Text(
                                //   "\$${product.price}",
                                //   style: const TextStyle(
                                //     color: AppColors.green,
                                //     fontSize: 14,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.red,
                            ),
                            onPressed: () {
                              // setState(() {
                              //   favoriteList.remove(product);
                              //   product.isLiked = false;
                              // });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
