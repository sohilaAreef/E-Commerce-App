import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void getCartItems() {
    emit(CartLoading());
    emit(CartLoaded(dummyCartItems));
  }
}
