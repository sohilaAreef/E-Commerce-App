import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  void getProductDetails(String id) {
    emit(ProductDetailsLoading());
    Future.delayed(Duration(seconds: 1), () {
      final selectedItem = dummyProductItems.firstWhere(
        (product) => product.id == id,
      );
      emit(ProdutDetailsLoaded(product: selectedItem));
    });
  }

  void incrementCounter(String productId) {
    final selectedIndex = dummyProductItems.indexWhere(
      (item) => item.id == productId,
    );
    dummyProductItems[selectedIndex] = dummyProductItems[selectedIndex]
        .copyWith(quantity: dummyProductItems[selectedIndex].quantity + 1);
    emit(ProdutDetailsLoaded(product: dummyProductItems[selectedIndex]));
  }

  void decrementCounter(String productId) {
    final selectedIndex = dummyProductItems.indexWhere(
      (item) => item.id == productId,
    );
    final current = dummyProductItems[selectedIndex].quantity;
    if (current > 0) {
      dummyProductItems[selectedIndex] = dummyProductItems[selectedIndex]
          .copyWith(quantity: dummyProductItems[selectedIndex].quantity - 1);
      emit(ProdutDetailsLoaded(product: dummyProductItems[selectedIndex]));
    }
  }
}
