import 'package:foods_hub/model/category_model.dart';
import 'package:foods_hub/services/category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var categories = <CategoryModel>[].obs;
  var productByCategory = Rxn<ProductByCategoryModel>();
  var errorMessage = ''.obs;

  final CategoryService _categoryService = CategoryService();

  Future<void> fetchCategories() async {
    isLoading(true);
    try {
      final fetchedCategories = await _categoryService.fetchCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProductsByCategory(String categoryId,
      {String query = ""}) async {
    isLoading(true);
    try {
      final fetchedProducts = await _categoryService
          .fetchProductsByCategory(categoryId, query: query);
      productByCategory.value = fetchedProducts;
      print("Fetched products: ${fetchedProducts.toRawJson()}");
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
