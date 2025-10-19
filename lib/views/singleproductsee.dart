import 'package:ecommerce_aug4/controler/cartcontroler.dart';
import 'package:ecommerce_aug4/controler/productcontrolers.dart';

import 'package:ecommerce_aug4/views/bottomnavscreen/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Singleproduct extends StatefulWidget {
  const Singleproduct({super.key});

  @override
  State<Singleproduct> createState() => _SingleproductState();
}

class _SingleproductState extends State<Singleproduct> {
  @override
  Widget build(BuildContext context) {
    final providersee = context.watch<Productcontrolers>();
    // print(context.watch<Productcontrolers>().singleprodetails!.id!.toString());
    List<String> sizes = ['S', 'M', 'L'];
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [Icon(Icons.notification_important), SizedBox(width: 10)],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.amber,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: 60,
        child: Row(
          spacing: 10,
          children: [
            Container(
              width: 150,
              height: double.infinity,

              child: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('price'),

                    Text(
                      context
                              .watch<Productcontrolers>()
                              .singleprodetails
                              ?.price
                              ?.toString() ??
                          '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  await context.read<Cartcontroler>().addtocart(
                    providersee.singleprodetails!,
                    context,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Icon(Icons.card_travel, color: Colors.white),
                      Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child:
            context.watch<Productcontrolers>().issingleload
                ? Center(child: CircularProgressIndicator())
                : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // spacing: 5,
                    children: [
                      _imagecontainer(),
                      Text(
                        'Regular Fit Slogan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Text('4.5/5(45 Reviews)'),
                        ],
                      ),
                      Text(
                        'The name says it all,The right size slightly snugs\nthe body leaving enough room the comfort in the\nsleeves and waist.',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        context
                            .watch<Productcontrolers>()
                            .singleprodetails!
                            .id!
                            .toString(),

                        // 'Choose size',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        spacing: 10,
                        children: List.generate(
                          3,
                          (index) => Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                sizes[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  Container _imagecontainer() {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
            context.watch<Productcontrolers>().singleprodetails?.thumbnail ??
                "",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: () async {},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Icon(Icons.favorite_border),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
