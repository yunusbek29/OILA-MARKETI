import 'package:flutter_application_1/bloc/search_bloc/search_state.dart';
import 'package:flutter_application_1/data/remote/fakestoreapi/product.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());

  void searchget(dynamic searchController) {
    final search = searchController.text.toLowerCase();

    emit(state.copyWith(filteredProducts: [],isLoading: true));

    if (search.isNotEmpty) {
      for (int i = 0; i < state.allProducts.length; i++) {
        if (state.allProducts[i].title.toLowerCase().contains(search) ||
            state.allProducts[i].category.contains(search)) {
          state.filteredProducts.add(state.allProducts[i]);
        }
      }
    }
    emit(
      state.copyWith(isEmpty: state.filteredProducts.isEmpty, isLoading: false),
    );
  }

  void getLoadList() async {
    emit(state.copyWith(isLoading: false));

    final respone = await Product.GET(Product.GET_PRODUCT, {});

    if (respone != null) {
      final newProduct = userFromJson(respone);
      emit(state.copyWith(allProducts: newProduct, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}
