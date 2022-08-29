import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kwilox/app/pages/edit_drink.dart';

import '../models/drink_model.dart';

class DrinkListTile extends StatelessWidget {
  final Drink drink;
  final Function()? onPressed;
  final Function() onDelete;
  const DrinkListTile(
      {required this.drink, this.onPressed, required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (onPressed != null) onPressed!();
      },
      child: Slidable(
        key: ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (c) => onDelete(),
              backgroundColor: const Color(0xFFFE4A49), // a red color
              foregroundColor: Colors.white,
              icon: Icons.delete, // Delete icon
              label: 'Delete',
            )
          ],
        ),
        child: Container(
          width: screenSize.width,
          height: 75,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 20),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.05)),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(drink.imageUrl,
                      height: 59, fit: BoxFit.cover)),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: screenSize.width / 2.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(drink.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    Text(drink.description,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => EditDrinkPage(drink: drink,)));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xFF3D16D6),
                      )),
                  Text(
                    "\$" + drink.price.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
