import 'package:flutter/material.dart';
import 'package:namastey_india/models/restaurantProfileModel.dart';
import '../models/orderModel.dart';
import '../models/homeMenuModel.dart';
import 'package:intl/intl.dart';

enum DeliveryMode { lieferung, abholung }

class CartStateMgmt extends ChangeNotifier {

  final List<ItemDetail> cartItems = [];
  DeliveryMode? _deliveryMode = DeliveryMode.lieferung;
  bool cartVisible = false;
  double _tip = 0;
  String _note ='';
  RestaurantData? _restaurantData;
  DistanceDetail _distanceDetail = DistanceDetail(id: null,deliveryCharge: '2.90' ,deliveryTime: '30',minOrder: '0',postcode: '60486');

  //delivery charges getter setter
  DistanceDetail get distanceDetail => _distanceDetail;
  set distanceDetail(DistanceDetail data){
    _distanceDetail = data;
    notifyListeners();
  }

  //get item discount, cart sub-total, discount sub-total, total and overall discount
  List<num> getItemDiscount(int index){
    final item = cartItems[index];
    int discount = 0;
    num itemPrice = item.price??0;
    num priceAfterDiscount = itemPrice;
    num discountPercentage = 0;

    if(item.excludeDiscount == false){
      if(item.discount! > 0){
        discount = item.discount ?? 0;
      }else if(item.catDiscount! > 0){
        discount = item.catDiscount ?? 0;
      }else if(_deliveryMode == DeliveryMode.abholung){
        discount = _restaurantData?.collectionDiscount ?? 0;
      }else if(_deliveryMode == DeliveryMode.lieferung){
        discount = _restaurantData?.deliveryDiscount ?? 0;
      }

      if(itemPrice !=0){
        priceAfterDiscount = itemPrice * (100-discount)/100;
        discountPercentage = (itemPrice - priceAfterDiscount)/itemPrice * 100;
      }
    }

    return [discountPercentage.round() ,priceAfterDiscount];
  }
  num getTotalDiscountPrice() {
    num totalDiscountPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      int itemIndex = cartItems.indexWhere((e) => e.id == cartItems[i].id);
      totalDiscountPrice += (cartItems[i].price! - getItemDiscount(itemIndex)[1]) * cartItems[i].quantity!.toDouble();
    }
    return totalDiscountPrice;
  }
  int getOverallDiscount(){
    num subtotal = getSubTotal();
    return ((subtotal-getTotalDiscountPrice())/subtotal*100).round();
  }
  num getItemPrice(int i) {
    num toppingsPrice = 0;
    if(cartItems[i].toppings != null && cartItems[i].toppings != [] && cartItems[i].toppings!.isNotEmpty){
      for (int j = 0; j < cartItems[i].toppings!.length; j++){
        toppingsPrice += cartItems[i].toppings![j].price ?? 0;
      }
    }
    return cartItems[i].price! + toppingsPrice;
  }
  num getSubTotal() {
    num subTotal = 0;
    for (int i = 0; i < cartItems.length; i++) {
      subTotal += getItemPrice(i) * cartItems[i].quantity!.toDouble();
    }
    return subTotal;
  }
  num getTotal() {
    return (getSubTotal() + (_deliveryMode == DeliveryMode.lieferung ? double.parse(_distanceDetail.deliveryCharge!) : 0) - getTotalDiscountPrice() + tip);
  }

  //restaurant profile data getter setter
  RestaurantData? get restaurantData => _restaurantData;
  set restaurantData(RestaurantData? data){
    _restaurantData = data;
    notifyListeners();
  }

  //delivery mode getter setter
  DeliveryMode? get deliveryMode => _deliveryMode;
  set deliveryMode(DeliveryMode? data){
    _deliveryMode = data;
    notifyListeners();
  }

  //add Item or add Quantity
  void addItem(Item? item, int? optionIndex, List<Topping> topping) {
    if (!cartVisible) {
      cartVisible = true;
    }
    if(cartItems.where((e) => e.id == item?.id).isEmpty){
      double? itemPrice = optionIndex != null ? double.tryParse(item?.options![optionIndex].price??'') : item?.price;
      cartItems.add(ItemDetail(id: item?.id ?? '',name: item?.name??'',price: itemPrice??0,quantity: 1,note: '',toppings: topping ,variant:'',variantPrice:null,subVariant:null,subVariantPrice:null,option: optionIndex!=null ? item!.options![optionIndex].name : null, discount:item?.discount??0,catDiscount:item?.category?.discount??0,excludeDiscount: item?.excludeDiscount??false,overallDiscount: null));
    }else{
        int itemIndex = cartItems.indexWhere((e) => e.id == item?.id);
        if(optionIndex!=null){
          cartItems[itemIndex].option = item!.options![optionIndex].name;
          cartItems[itemIndex].price = double.tryParse(item.options![optionIndex].price!);
          cartItems[itemIndex].toppings = topping;
        }
        addQuantity(itemIndex);
      }
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  void addQuantity(int itemIndex){
    cartItems[itemIndex].quantity = (cartItems[itemIndex].quantity! + 1);
    notifyListeners();
  }

  //remove Item or remove Quantity
  void removeItemOrQuantity(int itemIndex) {

    int? itemQuantity = cartItems[itemIndex].quantity;

    if(itemQuantity! > 1 ){
      cartItems[itemIndex].quantity = itemQuantity - 1;
    }else{
      cartItems.removeAt(itemIndex);
    }
    cartItems.isEmpty ? (cartVisible=false) : null;
    // Tell dependent widgets to rebuild _every time_
    notifyListeners();
  }

  //note getter setter
  String get note => _note;
  set note(String data){
    _note = data;
    notifyListeners();
  }

  //tip getter setter
  double get tip => _tip;
  set tip(double data){
    _tip = data;
    notifyListeners();
  }

  //price de to english and vice versa formatters
  static String deFormat(String val) {
    final deFormat = NumberFormat('###0.00#', 'de');
    return deFormat.format(double.parse(val));
  }
  static num enFormat(String val) {
    final deFormat = NumberFormat.decimalPattern(
      'de',
    );
    return deFormat.parse(val);
  }

}
