import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/config/app_texts.dart';
import 'package:flutter_application_1/data/local/shared/shared_pref.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  Map<ProductModel, int> cartItems = {};

  @override
  void initState() {
    super.initState();
    _getBag();
  }

  Future<void> _getBag() async {
    final shared = SharedPref();
    List<ProductModel> bagList = await shared.getProductList('bagList');
    List<int> bagQuantity = await shared.getIntList('bagQuantity');

    Map<ProductModel, int> tempMap = {};
    for (int i = 0; i < bagList.length; i++) {
      final product = bagList[i];
      final quantity = i < bagQuantity.length ? bagQuantity[i] : 1;
      tempMap[product] = quantity;
    }

    setState(() {
      cartItems = tempMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Bag"),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                AppTexts.noBag,
                style: TextStyle(fontSize: 20, color: AppColors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems.keys.elementAt(index);
                      final son = cartItems[product]!;
                      final totalPrice = product.price * son;

                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: CachedNetworkImage(
                                  fit: BoxFit.contain,
                                  height: 100,
                                  width: 100,
                                  imageUrl: product.image,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      product.category,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "\$${product.price.toStringAsFixed(2)} each",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              if (son > 1) {
                                                cartItems[product] = son - 1;
                                              } else {
                                                cartItems.remove(product);
                                              }
                                            });

                                            final shared = SharedPref();
                                            List<ProductModel> products =
                                                cartItems.keys.toList();
                                            List<int> quantities = products
                                                .map((p) => cartItems[p] ?? 1)
                                                .toList();

                                            await shared.saveProductList(
                                              'bagList',
                                              products,
                                            );
                                            await shared.saveIntList(
                                              'bagQuantity',
                                              quantities,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.remove_shopping_cart,
                                          ),
                                          color: Colors.red,
                                        ),
                                        Text(
                                          son.toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              cartItems[product] = son + 1;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.add_shopping_cart_rounded,
                                          ),
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Total: \$${totalPrice.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price: \$${getTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  double getTotalPrice() {
    double total = 0;
    cartItems.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }
}
