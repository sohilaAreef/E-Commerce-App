import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class TabBarHome extends StatefulWidget {
  const TabBarHome({super.key});

  @override
  State<TabBarHome> createState() => _TabBarHomeState();
}

class _TabBarHomeState extends State<TabBarHome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                FlutterCarousel(
                  options: FlutterCarouselOptions(
                    height: 150,
                    showIndicator: true,
                    slideIndicator: CircularSlideIndicator(),
                    autoPlay: true,
                  ),
                  items: state.carousel.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(end: 16),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(16),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: i.imgUrl,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator.adaptive(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'New Arrivals',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'See All',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                GridView.builder(
                  itemCount: state.item.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          AppRoutes.productDetailsRoute,
                          arguments: state.item[index].id,
                        );
                      },
                      child: ProductItem(productItem: state.item[index]),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is HomeError) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
