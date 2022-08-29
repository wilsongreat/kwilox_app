import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwilox/app/pages/drink_details.dart';
import 'package:kwilox/extension/string_ext.dart';
import 'package:lottie/lottie.dart';

import '../app/Provider/providers.dart';
import '../models/drink_model.dart';

class DrinkDisplay extends ConsumerWidget {
  const DrinkDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Drink>>(
        stream: ref.read(databaseProvider)!.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Lottie.network(
                        "https://assets2.lottiefiles.com/packages/lf20_v4d0iG.json", // here
                        width: 200,
                        repeat: true),
                    const Text("No Drinks  Available..."),
                  ],
                ),
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 15,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final drink = snapshot.data![index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DrinkDetail(drink: drink)));
                        },
                        child: Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.1),
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                drink.imageUrl,
                                height: 100,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                drink.name.capitalize(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Color(0xFF3D16D6),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 30.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFF3D16D6),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Center(
                                  child: Text(
                                    '\$${drink.price.toString()}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                        // Container(
                        //   padding: const EdgeInsets.all(10.0),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //   ),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Expanded(
                        //         child: Hero(
                        //           tag: product.name,
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(15.0),
                        //             child: Image.network(
                        //               product.imageUrl,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       const SizedBox(height: 10),
                        //       Text(
                        //         product.name,
                        //         style: const TextStyle(
                        //             fontWeight: FontWeight.bold, fontSize: 16),
                        //       ),
                        //       const SizedBox(height: 5),
                        //       Text(
                        //         "\$" + product.price.toString(),
                        //         style: TextStyle(
                        //             color: Theme.of(context).colorScheme.primary,
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 12),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        );
                  }),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
