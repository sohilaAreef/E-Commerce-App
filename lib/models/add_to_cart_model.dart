import 'package:ecommerce_app/models/product_item_model.dart';

class AddToCartModel {
  final ProductItemModel product;
  final String id;
  final ProductSize size;
  final int quantity;

  AddToCartModel({
    required this.size,
    required this.quantity,
    required this.product,
    required this.id,
  });
}

final List<AddToCartModel> dummyCartItems = [];
