import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.withOpacity(.1),
                ),
                height: 100,
                width: 170,
                child: CachedNetworkImage(
                  imageUrl: productItem.imgUrl,
                  height: 130,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      CircularProgressIndicator.adaptive(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white38,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Text(productItem.name, style: Theme.of(context).textTheme.titleSmall),

          Text(
            productItem.category,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.grey),
          ),

          Text(
            '\$ ${productItem.price}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
