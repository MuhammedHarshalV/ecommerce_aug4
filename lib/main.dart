import 'package:ecommerce_aug4/controler/cartcontroler.dart';
import 'package:ecommerce_aug4/controler/homecontroler.dart';
import 'package:ecommerce_aug4/controler/productcontrolers.dart';
import 'package:ecommerce_aug4/controler/search.dart';
import 'package:ecommerce_aug4/serviceclass/sqlservices/sqlservices.dart';
import 'package:ecommerce_aug4/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sqlservices.initdb();
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Homecontroler()),
        ChangeNotifierProvider(create: (context) => Productcontrolers()),
        ChangeNotifierProvider(create: (context) => Search()),
        ChangeNotifierProvider(create: (context) => Cartcontroler()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}
