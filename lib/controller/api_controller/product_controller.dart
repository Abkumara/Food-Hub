import 'package:foods_hub/model/product_model.dart';
import 'package:foods_hub/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  // Observables
  var isLoadingProducts = false.obs;
  var isLoadingTopProducts = false.obs;
  var isLoadingPastOrders = false.obs;
  var isLoading = false.obs;

  var productList = <ProductListModel>[].obs;
  var productTopList = <TopProductModel>[].obs;
  var pastOrderList = <PastOrderProductModel>[].obs;
  var product = Rxn<ProductIdModel>();

  var errorMessage = ''.obs;

  final ProductService _productService = ProductService();

  // Fetch all products
  Future<void> fetchProducts() async {
    isLoadingProducts(true);
    errorMessage.value = '';
    try {
      final fetchedList = await _productService.fetchProducts();
      productList.assignAll(fetchedList);
    } catch (e) {
      errorMessage.value = 'Failed to fetch products: ${e.toString()}';
    } finally {
      isLoadingProducts(false);
    }
  }

  // Fetch top products
  Future<void> fetchTopProducts() async {
    isLoadingTopProducts(true);
    errorMessage.value = '';
    try {
      final fetchedList = await _productService.fetchTopProducts();
      productTopList.assignAll(fetchedList);
    } catch (e) {
      errorMessage.value = 'Failed to fetch top products: ${e.toString()}';
    } finally {
      isLoadingTopProducts(false);
    }
  }

  // Fetch past order products
  Future<void> fetchPastOrderProducts() async {
    isLoadingPastOrders(true);
    errorMessage.value = '';
    try {
      final fetchedList = await _productService.fetchPastOrderProducts();
      pastOrderList.assignAll(fetchedList);
    } catch (e) {
      errorMessage.value =
          'Failed to fetch past order products: ${e.toString()}';
    } finally {
      isLoadingPastOrders(false);
    }
  }

  Future<void> fetchProductById(String productId) async {
    isLoading(true);
    errorMessage.value = '';
    try {
      final fetchedProduct = await _productService.fetchProductById(productId);
      product.value = fetchedProduct;
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }
}
