import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_app/homescreen/home.dart';

// الأحداث (Events)
abstract class FavoriteEvent {}

class ToggleFavoriteEvent extends FavoriteEvent {
  final Product product;

  ToggleFavoriteEvent(this.product);
}

// الحالة (States)
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteUpdated extends FavoriteState {
  final List<Product> favoriteProducts;

  FavoriteUpdated(this.favoriteProducts);
}


class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  List<Product> _favoriteProducts = [];

  FavoriteBloc() : super(FavoriteInitial());

  @override
  Stream<FavoriteState> mapEventToState (FavoriteEvent event) async* {
    if (event is ToggleFavoriteEvent) {
      if (_favoriteProducts.contains(event.product)) {
        _favoriteProducts.remove(event.product);
      } else {
        _favoriteProducts.add(event.product);
      }
      yield FavoriteUpdated(_favoriteProducts);
    }
  }
}
