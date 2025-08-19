import 'package:ecommerce_aug4/controler/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController searchcontroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchresult = context.watch<Search>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 20,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: searchcontroler,
                          decoration: InputDecoration(
                            hintText: 'search',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            context.read<Search>().searchProducts(
                              query: searchcontroler.text,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (searchcontroler.text.isNotEmpty) {
                        context.read<Search>().searchProducts(
                          query: searchcontroler.text,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter valid product name')),
                        );
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.blue,
                      child: Center(child: Icon(Icons.search)),
                    ),
                  ),
                ],
              ),
              Expanded(
                child:
                    searchresult.issearchloading
                        ? Center(child: CircularProgressIndicator())
                        : Builder(
                          builder: (context) {
                            if (searchresult.productdatas.isEmpty) {
                              return Center(child: Text('No matches found'));
                            } else {
                              return GridView.builder(
                                itemCount: searchresult.productdatas.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                itemBuilder:
                                    (context, index) => Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    searchresult
                                                            .productdatas[index]
                                                            .thumbnail
                                                            .toString() ??
                                                        '',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'price ${context.watch<Search>().productdatas[index].price.toString()}' ??
                                                '',
                                          ),
                                          Text(
                                            '${searchresult.productdatas[index].title}' ??
                                                '',
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              );
                            }
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
