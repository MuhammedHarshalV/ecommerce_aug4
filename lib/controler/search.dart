import 'package:ecommerce_aug4/models/product/productsample.dart';
import 'package:ecommerce_aug4/serviceclass/apiservices/apiservice.dart';
import 'package:flutter/material.dart';

class Search with ChangeNotifier {
  List<Product> productdatas = [];
  bool issearchloading = false;
  Future<void> searchProducts({String? query}) async {
    issearchloading = true;
    notifyListeners();
    final data = await Apiservice.getdata("products/search?q=$query");
    if (data != null) {
      Getallproduct resModel = getallproductFromJson(data);

      productdatas = resModel.products ?? [];
    } else {
      print("Failed to fetch Categories");
    }

    issearchloading = false;
    notifyListeners();
  }
}
