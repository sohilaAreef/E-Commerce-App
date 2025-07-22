import 'package:flutter/material.dart';

class ProductCounter extends StatelessWidget {
  final int value;
  final String productId;
  final dynamic cubit;
  const ProductCounter({
    super.key,
    required this.value,
    required this.productId,
    this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              cubit.decrementCounter(productId);
            },
            icon: Icon(Icons.remove),
          ),
          Text(value.toString()),
          IconButton(
            onPressed: () {
              cubit.incrementCounter(productId);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
