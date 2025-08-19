import 'package:ecommerce_aug4/controler/homecontroler.dart';
import 'package:ecommerce_aug4/controler/productcontrolers.dart';
import 'package:ecommerce_aug4/serviceclass/sqlservices/sqlservices.dart';
import 'package:ecommerce_aug4/views/searchscreen.dart';
import 'package:ecommerce_aug4/views/singleproductsee.dart';
import 'package:ecommerce_aug4/widgets/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Productlist extends StatefulWidget {
  const Productlist({super.key});

  @override
  State<Productlist> createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {
  int? clickfilter;
  int navindex = 0;
  List<String> filter = ['All', 'Men', 'Women', 'Kids'];
  @override
  void initState() {
    initialdata();
    super.initState();
  }

  Future<void> initialdata() async {
    await context.read<Homecontroler>().fetchdata();
    await context.read<Productcontrolers>().getproduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          InkWell(
            onTap: () {
              Sqlservices.getdatacart();
            },
            child: Icon(Icons.notification_important),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.card_travel),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.red,
        currentIndex: navindex,
        onTap: (value) {
          navindex = value;
          //setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(Icons.home, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: 'Sved',
            icon: Icon(Icons.favorite_border, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.card_travel, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            _top(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _filter(),
            ),
            Expanded(
              child:
                  context.watch<Homecontroler>().isloading
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                        itemCount:
                            context
                                .watch<Productcontrolers>()
                                .productdatas
                                .length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 220,
                          crossAxisCount: 2,
                        ),
                        itemBuilder:
                            (context, index) => InkWell(
                              onTap: () async {
                                context.read<Productcontrolers>().getsingle(
                                  single:
                                      context
                                          .read<Productcontrolers>()
                                          .productdatas[index]
                                          .id
                                          .toString(),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Singleproduct(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              context
                                                  .watch<Productcontrolers>()
                                                  .productdatas[index]
                                                  .images![0],
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      context
                                          .watch<Productcontrolers>()
                                          .productdatas[index]
                                          .title
                                          .toString(),

                                      // 'Regular Fit Color Block',
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      context
                                          .watch<Productcontrolers>()
                                          .productdatas[index]
                                          .price
                                          .toString(),

                                      // 'PKR 1190',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Row _filter() {
    return Row(
      spacing: 10,
      children: List.generate(
        context.watch<Homecontroler>().categories.length,
        (index) => InkWell(
          onTap: () async {
            await context.read<Productcontrolers>().getproduct(
              category: context.read<Homecontroler>().categories[index].slug,
            );
            clickfilter = index;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: index == clickfilter ? Colors.black : Colors.grey,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  context.watch<Homecontroler>().categories[index].name ?? '',
                  style: TextStyle(
                    color: index == clickfilter ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _top() {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Searchscreen()),
              );
            },
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Icon(Icons.search),
                    Expanded(child: Text('Search anything..')),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Center(child: Icon(Icons.menu, color: Colors.white)),
        ),
      ],
    );
  }
}
