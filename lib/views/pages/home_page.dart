import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/home_carousel_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/views/widgets/category.dart';
import 'package:ecommerce_app/views/widgets/product_item.dart';
import 'package:ecommerce_app/views/widgets/tab_bar_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeData();
        return cubit;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(
                            'https://media.licdn.com/dms/image/v2/D4D03AQHqh00QKBiqag/profile-displayphoto-scale_200_200/B4DZgEeVbPH0AY-/0/1752421719551?e=1758153600&v=beta&t=W79D1PduzfhdcyETHNeUzsB7WtTUsejgDBTtbMSc_Yw',
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sohila Arif',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              'Let\'s go shopping!',
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TabBar(
                  dividerHeight: 0,

                  unselectedLabelColor: Colors.grey,
                  tabs: [Text('Home'), Text('Category')],
                  controller: _controller,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [TabBarHome(), Category()],
                  ),
                ),

                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
