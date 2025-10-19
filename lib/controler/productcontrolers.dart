import 'package:ecommerce_aug4/models/product/productsample.dart';
import 'package:ecommerce_aug4/models/singleproductmodel/singleproductget.dart';
import 'package:ecommerce_aug4/serviceclass/apiservices/apiservice.dart';

import 'package:flutter/material.dart';

class Productcontrolers with ChangeNotifier {
  List<Product> productdatas = [];
  bool iscateloading = false;
  bool issingleload = false;
  Singleproduct? singleprodetails;

  Future<void> getproduct({String? category}) async {
    String enponit = 'products';
    if (category != null) {
      enponit = 'products/category/$category';
    }
    iscateloading = true;
    notifyListeners();
    final productdata = await Apiservice.getdata(enponit);
    if (productdata != null) {
      Getallproduct responsemodal = getallproductFromJson(productdata);
      productdatas = responsemodal.products ?? [];
    }
    iscateloading = false;
    notifyListeners();
  }

  Future<void> getsingle({String? single}) async {
    issingleload = true;
    notifyListeners();
    String enponitsingle = 'products/';
    final singledata = await Apiservice.getdata('$enponitsingle$single');
    if (singledata != null) {
      singleprodetails = singleproductFromJson(singledata);
    }
    issingleload = false;
    notifyListeners();
  }
}
