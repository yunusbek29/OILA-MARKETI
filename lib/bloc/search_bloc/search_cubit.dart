import 'package:flutter_application_1/bloc/search_bloc/search_state.dart';
import 'package:flutter_application_1/data/remote/fakestoreapi/product.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());
  void search(String controller) {
    final searchText = controller.trim().toLowerCase();
    emit(state.copyWith(isLoading: true));

    if (searchText.isEmpty) {
      emit(
        state.copyWith(filteredProducts: state.allProducts, isLoading: false),
      );
      return;
    }

    List<ProductModel> result = [];

    for (int i = 0; i < state.allProducts.length; i++) {
      final product = state.allProducts[i];
      final title = product.title.toLowerCase();
      final category = product.category.toLowerCase();

      if (title.contains(searchText) || category.contains(searchText)) {
        result.add(product);
      }
    }

    emit(state.copyWith(filteredProducts: result, isLoading: false));
  }

  void getLoadList() async {
    emit(state.copyWith(isLoading: true));

    final respone = await Product.GET(Product.GET_PRODUCT, {});

    if (respone != null) {
      final newProduct = ProductFromJson(respone);
      emit(
        state.copyWith(
          allProducts: newProduct,
          filteredProducts: newProduct,
          isLoading: false,
        ),
      );
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void resetSearch() {
    emit(state.copyWith(filteredProducts: state.allProducts, isLoading: false));
  }
}
