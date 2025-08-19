import 'package:ecommerce_aug4/appconfig/appconfig.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  static Future<String?> getdata(String urll) async {
    final url = Uri.parse('${Appconfig.baseurl}${urll}');
    final response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    }
  }

  void post() {}
  void put() {}
  void patch() {}
  void delete() {}
}
