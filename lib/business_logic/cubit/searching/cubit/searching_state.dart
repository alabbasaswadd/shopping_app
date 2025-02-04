part of 'searching_cubit.dart';

@immutable
sealed class SearchingState {}

final class SearchingInitial extends SearchingState {}

class IsSearching extends SearchingState{
 final List<ProductsModel> productsSearching; 
 IsSearching(this.productsSearching);
}
class NotSearching extends SearchingState{
   final List<ProductsModel> products; 
   NotSearching(this.products);
}