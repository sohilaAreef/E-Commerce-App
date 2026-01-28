import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String id;
  final int productNum;
  final Color bgColor;
  final Color textColor;

  CategoryModel({
    required this.name,
    required this.id,
    required this.productNum,
    required this.bgColor,
    required this.textColor,
  });
}

List<CategoryModel> dummyCaregries = [
  CategoryModel(
    name: "New Arrivals",
    id: '1',
    productNum: 200,
    bgColor: const Color.fromARGB(255, 81, 145, 218),
    textColor: Colors.black,
  ),
  CategoryModel(
    name: "Clothes",
    id: '2',
    productNum: 150,
    bgColor: const Color.fromARGB(255, 177, 147, 190),
    textColor: Colors.white,
  ),
  CategoryModel(
    name: "Bags",
    id: '3',
    productNum: 120,
    bgColor: const Color.fromARGB(255, 242, 248, 159),
    textColor: Colors.black,
  ),
  CategoryModel(
    name: "Shoes",
    id: '4',
    productNum: 348,
    bgColor: const Color.fromARGB(255, 231, 128, 44),
    textColor: Colors.white,
  ),
  CategoryModel(
    name: "Electronics",
    id: '5',
    productNum: 500,
    bgColor: const Color.fromARGB(255, 116, 212, 113),
    textColor: Colors.white,
  ),
];
