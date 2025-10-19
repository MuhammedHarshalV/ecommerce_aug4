import 'package:ecommerce_aug4/controler/cartcontroler.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get totalPrice {
    var cartitemss = context.read<Cartcontroler>().cartitems;
    return cartitemss.fold(
      0,
      (sum, item) => sum + (item['price'] as double) * (item['qty'] as int),
    );
  }

  get cartItemss => null;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<Cartcontroler>().getcartitems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartprovider = context.watch<Cartcontroler>();
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        title: Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),

        centerTitle: true,
      ),
      body:
          cartprovider.cartitems.isEmpty
              ? Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(12),
                      itemCount: cartprovider.cartitems.length,
                      itemBuilder: (context, index) {
                        final item = cartprovider.cartitems[index];

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item['img'],
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "\$${item['price'] * item['qty']}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                            ),
                                            onPressed: () async {
                                              if (item['qty'] > 1) {
                                                await context
                                                    .read<Cartcontroler>()
                                                    .decrementqty(
                                                      item['id'],
                                                      item['qty'] - 1,
                                                    );
                                              }
                                            },

                                            color: Colors.grey[700],
                                          ),
                                          Text(
                                            '${item['qty']}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                            ),
                                            onPressed: () async {
                                              await context
                                                  .read<Cartcontroler>()
                                                  .incrementqty(
                                                    item['id'],
                                                    item['qty'] + 1,
                                                  );
                                            },
                                            color: Colors.teal,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await context
                                        .read<Cartcontroler>()
                                        .deleteproduct(item['id']);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, -1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total: \$${cartprovider.totalprice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Razorpay razorpay = Razorpay();
                            var options = {
                              'key': 'rzp_test_1DP5mmOlF5G5ag',
                              'amount': 100,
                              'name': 'Acme Corp.',
                              'description': 'Fine T-Shirt',
                              'retry': {'enabled': true, 'max_count': 1},
                              'send_sms_hash': true,
                              'prefill': {
                                'contact': '8888888888',
                                'email': 'test@razorpay.com',
                              },
                              'external': {
                                'wallets': ['paytm'],
                              },
                            };
                            razorpay.on(
                              Razorpay.EVENT_PAYMENT_ERROR,
                              handlePaymentErrorResponse,
                            );
                            razorpay.on(
                              Razorpay.EVENT_PAYMENT_SUCCESS,
                              handlePaymentSuccessResponse,
                            );
                            razorpay.on(
                              Razorpay.EVENT_EXTERNAL_WALLET,
                              handleExternalWalletSelected,
                            );
                            razorpay.open(options);
                            // Checkout logic here
                          },
                          child: Text(
                            "Checkout",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(
      context,
      "Payment Failed",
      "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}",
    );
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
      context,
      "Payment Successful",
      "Payment ID: ${response.paymentId}",
    );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
      context,
      "External Wallet Selected",
      "${response.walletName}",
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(title: Text(title), content: Text(message));
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
