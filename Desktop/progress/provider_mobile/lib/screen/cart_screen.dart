import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mobile/providers/providers.dart';
import 'package:provider_mobile/widgets/cart_item.dart' as wgt;

class CartScreen extends StatelessWidget {
  static const routName = "/Cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      "\$${cart.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false).addOrder(
                              cart.item.values.toList(), cart.totalAmount);
                          cart.clear();
                        },
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        child: const Text("ORDER NOW")),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.item.length,
              itemBuilder: ((context, index) {
                return wgt.CartItem(
                  cart.item.values.toList()[index].id,
                  cart.item.keys.toList()[index],
                  cart.item.values.toList()[index].title,
                  cart.item.values.toList()[index].price,
                  cart.item.values.toList()[index].quantity,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
