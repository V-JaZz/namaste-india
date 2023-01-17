import 'package:flutter/material.dart';
import '../models/homeMenuModel.dart';
import 'package:intl/intl.dart';

class CartStateMgmt extends ChangeNotifier {
  //parse double to de locale
  static String deFormat(String val) {
    // final deFormat = NumberFormat.decimalPattern('de',);
    final deFormat = NumberFormat('###.00#', 'de');
    return deFormat.format(double.parse(val));
  }
  //convert back to double
  static num enFormat(String val) {
    final deFormat = NumberFormat.decimalPattern(
      'de',
    );
    return deFormat.parse(val);
  }

  /// Internal, private state of the cart.
  final List<CartItemModel> cartItems = [];
  bool cartVisible = false;
  double tip = 0;
  int? toppingIndex;
  int? optionIndex;

  void changeToppingIndex(int index){
    toppingIndex = index;
    notifyListeners();
  }
  void changeOptionIndex(int index){
    optionIndex = index;
    notifyListeners();
  }

  void addTip(double d){
    tip = d;
    notifyListeners();
  }
  void add(Items? item) {
    if (!cartVisible) {
      cartVisible = true;
    }
    int itemIndex = cartItems.indexWhere((e) => e.item == item);

    if(cartItems.where((e) => e.item == item).isEmpty){
      cartItems.add(CartItemModel(item: item, count: 1));
    }else{
      cartItems[itemIndex].count = cartItems[itemIndex].count! + 1;
    }
    // cartItems.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(Items? item) {
    int itemIndex = cartItems.indexWhere((e) => e.item == item);
    int? itemCount = cartItems[itemIndex].count;
    // foods[foods.indexWhere((element) => element.uid == food.uid)] = food;
    if(itemCount! > 1 ){
      cartItems[itemIndex].count = cartItems[itemIndex].count! - 1;
    }else{
      cartItems.removeAt(itemIndex);
    }

    if (cartItems.isEmpty) {
      cartVisible = false;
    }

    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }

  String? getPriceSum() {
    double sum = 0;
    for (int i = 0; i < cartItems.length; i++) {
      sum += (double.parse(cartItems[i].item!.price!)) * cartItems[i].count!;
      // sum += cartItems[i].price!;
    }
      return sum.toStringAsFixed(2);
  }

  String? getCartTotal() {
    return (double.parse(getPriceSum()!) + 2.90 + 1.90 + tip).toStringAsFixed(2);
  }
}
class CartItemModel {
  Items? item;
  int? count;
  CartItemModel({this.count, this.item});
}
