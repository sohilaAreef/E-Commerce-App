import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyCaregries.length,
      itemBuilder: (context, index) {
        final category = dummyCaregries[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: category.bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 32),
                child: Column(
                  children: [
                    Text(
                      category.name,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: category.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${category.productNum} product',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: category.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
