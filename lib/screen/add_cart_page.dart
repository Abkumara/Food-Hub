import 'package:flutter/material.dart';
import 'package:foods_hub/controller/api_controller/cart_controller.dart';
import 'package:foods_hub/controller/api_controller/product_controller.dart';
import 'package:get/get.dart';

class AddCartPage extends StatelessWidget {
  final CartController _cartController = Get.put(CartController());
  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    _productController.fetchProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add to Cart"),
      ),
      body: Obx(() {
        if (_productController.isLoadingProducts.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_productController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              _productController.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (_productController.productList.isEmpty) {
          return const Center(child: Text("No products available"));
        }

        return ListView.builder(
          itemCount: _productController.productList.length,
          itemBuilder: (context, index) {
            final product = _productController.productList[index];

            RxInt quantity = 0.obs;

            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(product.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price: ₹${product.inputPrice}"),
                    Obx(
                      () => Text("Quantity: ${quantity.value}"),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.red),
                      onPressed: () {
                        if (quantity.value > 1) {
                          quantity.value--;
                          _cartController.addCart(product.id, quantity.value);
                        } else {
                          Get.snackbar(
                            "Notice",
                            "Minimum quantity is 1",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                    ),
                    Text('${quantity.value}'),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.green),
                      onPressed: () {
                        quantity.value++;
                        _cartController.addCart(product.id, quantity.value);
                        Get.snackbar(
                          "Success",
                          "${product.name} quantity updated to ${quantity.value}",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
