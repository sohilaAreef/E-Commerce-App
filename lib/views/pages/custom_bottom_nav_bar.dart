import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/views/pages/cart_page.dart';
import 'package:ecommerce_app/views/pages/favorites_page.dart';
import 'package:ecommerce_app/views/pages/home_page.dart';
import 'package:ecommerce_app/views/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: BlocProvider<HomeCubit>(
              create: (context) {
                final cubit = HomeCubit();
                cubit.getHomeData();
                return cubit;
              },
              child: HomePage(),
            ),
            item: ItemConfig(icon: Icon(CupertinoIcons.home), title: "Home"),
          ),
          PersistentTabConfig(
            screen: BlocProvider(
              create: (context) {
                final cubit = CartCubit();
                cubit.getCartItems();
                return cubit;
              },
              child: CartPage(),
            ),
            item: ItemConfig(
              icon: Icon(CupertinoIcons.shopping_cart),
              title: "Cart",
            ),
          ),
          PersistentTabConfig(
            screen: FavoritesPage(),
            item: ItemConfig(
              icon: Icon(CupertinoIcons.heart),
              title: "Favorites",
            ),
          ),
          PersistentTabConfig(
            screen: ProfilePage(),
            item: ItemConfig(
              icon: Icon(CupertinoIcons.person),
              title: "Profile",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style7BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
