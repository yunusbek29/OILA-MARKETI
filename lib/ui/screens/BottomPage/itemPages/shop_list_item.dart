import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';
import 'package:flutter_application_1/ui/screens/pages/detail_page.dart';

class ShopPageList extends StatefulWidget {
  final ProductModel product;
  const ShopPageList({super.key, required this.product});

  @override
  State<ShopPageList> createState() => _ShopPageListState();
}

class _ShopPageListState extends State<ShopPageList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        final back = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(product: widget.product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 10,
                  bottom: 10,
                  right: 10,
                  left: 10,
                ),
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                  imageUrl: widget.product.image,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(color: AppColors.orange),
                  ),
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
                          "${widget.product.title}...",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.product.category,
                          style: TextStyle(color: AppColors.grey, fontSize: 13),
                        ),
                        SizedBox(height: 4),
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
                            SizedBox(width: 4),
                            Text("(${widget.product.ratingCount})"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${widget.product.price}\$",
                          style: TextStyle(
                            color: AppColors.green,
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
  }
}
