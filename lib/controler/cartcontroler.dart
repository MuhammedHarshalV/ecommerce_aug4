import 'package:ecommerce_aug4/models/singleproductmodel/singleproductget.dart';
import 'package:ecommerce_aug4/serviceclass/sqlservices/sqlservices.dart';
import 'package:flutter/material.dart';

class Cartcontroler with ChangeNotifier {
  List<Map> cartitems = [];
  num totalprice = 0.00;
  void totalpriceget() {
    totalprice = 0.00;
    for (var item in cartitems) {
      totalprice += item['qty'] * item['price'];
    }
  }

  Future<void> getcartitems() async {
    cartitems = await Sqlservices.getdatacart();
    totalpriceget();
    notifyListeners();
  }

  Future<void> addtocart(
    Singleproduct producttocart,
    BuildContext context,
  ) async {
    try {
      await Sqlservices.addatacart({
        'id': producttocart.id,
        'title': producttocart.title,
        'img': producttocart.thumbnail,
        'qty': 1,
        'price': producttocart.price,
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('This item Already in the cart')));
    }
    await getcartitems();
  }

  Future<void> incrementqty(int incrementid, int incrementqty) async {
    await Sqlservices.editdatacart(
      quantity: incrementqty,
      productid: incrementid,
    );
    await getcartitems();
  }

  Future<void> decrementqty(int decrementid, int decrementqty) async {
    await Sqlservices.editdatacart(
      quantity: decrementqty,
      productid: decrementid,
    );
    await getcartitems();
  }

  Future<void> deleteproduct(num productids) async {
    await Sqlservices.deletedatacart(productids);
    await getcartitems();
  }
}
