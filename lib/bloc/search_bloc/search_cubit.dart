
import 'package:flutter_application_1/bloc/search_bloc/search_state.dart';
import 'package:flutter_application_1/data/remote/fakestoreapi/product.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());


  void searchget(String controlle) {
    final controller = controlle.toLowerCase();
    emit(state.copyWith(isLoading: true));
    if (controller.isEmpty) {
      emit(state.copyWith(filteredProducts: state.allProducts));
      return;
    }
    
    List<ProductModel> result = [];

    for (int i = 0; i < state.allProducts.length; i++) {
      if (state.allProducts[i].title.toLowerCase().contains(controller) ||
          state.allProducts[i].category.toLowerCase().contains(controller)) {
        result.add(state.allProducts[i]);
      }
    }
    print(state.filteredProducts.length);
    emit(state.copyWith(filteredProducts: result, isLoading: false));
  }

  void getLoadList() async {
    emit(state.copyWith(isLoading: true));

    final respone = await Product.GET(Product.GET_PRODUCT, {});

    if (respone != null) {
      final newProduct = userFromJson(respone);
      emit(
        state.copyWith(
          allProducts: newProduct,
          filteredProducts: state.allProducts,
          isLoading: false,
        ),
      );
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}
