import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/views/widgets/product_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: BlocProvider.of<ProductDetailsCubit>(context),
      buildWhen: (previous, current) =>
          current is ProductDetailsLoading ||
          current is ProdutDetailsLoaded ||
          current is ProductDetailsError,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is ProdutDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade200,
              elevation: 0,
              title: Text('Product Details'),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '\$',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        children: [
                          TextSpan(
                            text: product.price.toString(),
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                      bloc: BlocProvider.of<ProductDetailsCubit>(context),
                      buildWhen: (previous, current) =>
                          current is ProductAddedToCart ||
                          current is ProductAddingToCart,
                      builder: (context, state) {
                        if (state is ProductAddingToCart) {
                          return ElevatedButton(
                            onPressed: () => null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor,
                              ),
                              foregroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                            ),
                            child: const CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is ProductAddedToCart) {
                          return ElevatedButton(
                            onPressed: () => null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor,
                              ),
                              foregroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                            ),
                            child: const Text('Added to cart'),
                          );
                        }
                        return ElevatedButton.icon(
                          onPressed: () {
                            if (BlocProvider.of<ProductDetailsCubit>(
                                  context,
                                ).selectdSize !=
                                null) {
                              BlocProvider.of<ProductDetailsCubit>(
                                context,
                              ).addToCart(product.id);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please select size')),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor,
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                          ),
                          label: const Text('Add to Cart'),
                          icon: Icon(Icons.shopping_bag_outlined),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * .43,
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * .01),
                      CachedNetworkImage(
                        imageUrl: product.imgUrl,
                        height: size.height * .35,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.33),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber),
                                    SizedBox(width: 3),
                                    Text(
                                      product.averageRate.toString(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                                BlocBuilder<
                                  ProductDetailsCubit,
                                  ProductDetailsState
                                >(
                                  bloc: BlocProvider.of<ProductDetailsCubit>(
                                    context,
                                  ),
                                  buildWhen: (previous, current) =>
                                      current is QuantityCounterLoaded ||
                                      current is ProdutDetailsLoaded,
                                  builder: (context, state) {
                                    if (state is QuantityCounterLoaded) {
                                      return ProductCounter(
                                        value: state.value,
                                        productId: product.id,
                                        cubit:
                                            BlocProvider.of<
                                              ProductDetailsCubit
                                            >(context),
                                      );
                                    } else if (state is ProdutDetailsLoaded) {
                                      return ProductCounter(
                                        value: 1,
                                        productId: product.id,
                                        cubit:
                                            BlocProvider.of<
                                              ProductDetailsCubit
                                            >(context),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Size',
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            BlocBuilder<
                              ProductDetailsCubit,
                              ProductDetailsState
                            >(
                              bloc: BlocProvider.of<ProductDetailsCubit>(
                                context,
                              ),
                              buildWhen: (previous, current) =>
                                  current is SizeSelected ||
                                  current is ProdutDetailsLoaded,
                              builder: (context, state) {
                                return Row(
                                  children: ProductSize.values
                                      .map(
                                        (size) => Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                            right: 7,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              BlocProvider.of<
                                                    ProductDetailsCubit
                                                  >(context)
                                                  .selectSize(size);
                                            },
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    state is SizeSelected &&
                                                        state.size == size
                                                    ? Theme.of(
                                                        context,
                                                      ).primaryColor
                                                    : Colors.grey.shade200,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  12.0,
                                                ),
                                                child: Text(
                                                  size.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                        color:
                                                            state is SizeSelected &&
                                                                state.size == size
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Description',
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              product.description,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ProductDetailsError) {
          return Scaffold(body: Center(child: Text("Something went wrong!")));
        } else {
          return Scaffold(body: SizedBox.shrink());
        }
      },
    );
  }
}
