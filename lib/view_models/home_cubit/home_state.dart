part of 'home_cubit.dart';

class HomeState {}

final class HomeCubitInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  List<HomeCarouselItemModel> carousel;
  List<ProductItemModel> item;

  HomeLoaded({required this.carousel, required this.item});
}

final class HomeError extends HomeState {
  String message;

  HomeError({required this.message});
}
