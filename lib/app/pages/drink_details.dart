import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/drink_model.dart';

class DrinkDetail extends ConsumerWidget {
  final Drink drink;
  const DrinkDetail({required this.drink, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.white70, shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      iconSize: 30,
                    ),
                    Text(
                      "Details",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.favorite,
                      size: 30,
                      color: Color(0xFF3D16D6),
                    )
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 7,
                      child: Column(
                        children: [
                          Text(
                            "Label: ${drink.name}",
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Price: ${drink.price}"),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Avail.: ${drink.price} Bottles")
                        ],
                      )),
                  Flexible(flex: 5, child: Image.network(drink.imageUrl))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
