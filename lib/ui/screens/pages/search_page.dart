import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/data/remote/fakestoreapi/product.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';
import 'package:flutter_application_1/ui/screens/pages/detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  bool isLoading = false;
  bool isEmpty = false;
  bool isEmptyPage = false;

  @override
  void initState() {
    super.initState();
    getLoadList();
    searchget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onChanged: (text) {
            searchget();
          },
          style: TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: AppColors.white),
            border: InputBorder.none,
          ),
        ),
        backgroundColor: AppColors.orange,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: filteredProducts.isEmpty
                  ? allProducts.length
                  : filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts.isEmpty
                    ? allProducts[index]
                    : filteredProducts[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(product: product),
                      ),
                    );
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
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              right: 10,
                              left: 10,
                            ),
                            child: CachedNetworkImage(
                              height: 100,
                              width: 100,
                              imageUrl: product.image,
                              placeholder: (context, url) =>
                           Center(child: CircularProgressIndicator(color: AppColors.orange,)),
                      
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      maxLines: 1,
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
                                          emptyIcon: Icons.star_border,
                                          halfFilledIcon: Icons.star_half,
                                          filledColor: AppColors.amber,
                                          size: 20,
                                        ),
                                        SizedBox(width: 4),
                                        Text("(${product.ratingCount})"),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${product.price}\$",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
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
    );
  }

  void searchget() {
    final search = searchController.text.toLowerCase();

    setState(() {
      filteredProducts.clear();
      isLoading = true;
    });

    if (search.isNotEmpty) {
      for (int i = 0; i < allProducts.length; i++) {
        if (allProducts[i].title.toLowerCase().contains(search) ||
            allProducts[i].category.contains(search)) {
          filteredProducts.add(allProducts[i]);
          setState(() {
            isEmptyPage = false;
          });
        } else {
          setState(() {
            isEmptyPage = true;
          });
        }
      }
    }
    setState(() {
      isEmpty = filteredProducts.isEmpty;
      isLoading = false;
    });
  }

  void getLoadList() async {
    setState(() {
      isLoading = true;
    });

    final respone = await Product.GET(Product.GET_PRODUCT, {});

    if (respone != null) {
      final newProduct = userFromJson(respone);
      setState(() {
        allProducts.addAll(newProduct);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
