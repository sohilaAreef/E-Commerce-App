import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  int quantity = 1;
  ProductSize? selectdSize;

  void getProductDetails(String id) {
    emit(ProductAddingToCart());
    Future.delayed(Duration(seconds: 1), () {
      final selectedItem = dummyProductItems.firstWhere(
        (product) => product.id == id,
      );
      emit(ProdutDetailsLoaded(product: selectedItem));
    });
  }

  void addToCart(String ProductId) {
    emit(ProductAddingToCart());
    final AddToCartModel cartItem = AddToCartModel(
      id: DateTime.now().toIso8601String(),
      product: dummyProductItems.firstWhere(
        (product) => product.id == ProductId,
      ),
      size: selectdSize!,
      quantity: quantity,
    );
    dummyCartItems.add(cartItem);
    Future.delayed(Duration(seconds: 1), () {
      emit(ProductAddedToCart(ProductId: ProductId));
    });
  }

  void selectSize(ProductSize size) {
    selectdSize = size;
    emit(SizeSelected(size: size));
  }

  void incrementCounter(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String productId) {
    quantity--;
    emit(QuantityCounterLoaded(value: quantity));
  }
}
