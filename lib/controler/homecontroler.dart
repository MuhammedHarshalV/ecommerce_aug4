import 'package:ecommerce_aug4/models/homepagecategorymodel/category.dart';
import 'package:ecommerce_aug4/serviceclass/apiservices/apiservice.dart';
import 'package:flutter/material.dart';

class Homecontroler with ChangeNotifier {
  bool isloading = false;
  List<Category> categories = [];
  Future<void> fetchdata() async {
    isloading = true;
    notifyListeners();
    final data = await Apiservice.getdata('products/categories');
    if (data != null) {
      categories = categoryFromJson(data);
    }
    isloading = false;
    notifyListeners();
  }
}
