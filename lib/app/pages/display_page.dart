import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwilox/app/pages/home_screen.dart';

import '../../widgets/drink_display.dart';
import '../Provider/providers.dart';
import 'add_product_page.dart';

class DisplayDrinksPage extends ConsumerWidget {
  const DisplayDrinksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0xFF3D16D6),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Image.network(
                      'https://www.pinterest.com/pin/emoji-updates-for-apples-ios-145-revealed--94786767148006834/')),
              GestureDetector(
                onTap: () => ref.read(firebaseAuthProvider).signOut(),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(Icons.logout, size: 30, color: Colors.white)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1, color: Colors.grey.withOpacity(.5))),
                    child: IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      // onPressed: () => Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => HomeScreen())),
                      iconSize: 20,
                      icon: Icon(
                        Icons.menu,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Kwilox,',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: 'Drink',
                        style: TextStyle(color: Colors.black, fontSize: 25)),
                    TextSpan(
                        text: ' Responsibly',
                        style:
                            TextStyle(color: Color(0xFF3D16D6), fontSize: 25))
                  ]))
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: 70,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                decoration: BoxDecoration(
                    color: Colors.white60.withOpacity(.9),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.05),
                          blurRadius: 5,
                          spreadRadius: 7,
                          offset: Offset(4, 4))
                    ],
                    borderRadius: BorderRadius.circular(15.0)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 60.0,
                        width: 40.0,
                        // padding: EdgeInsets.symmetric(
                        //     vertical: 15.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.grey.withOpacity(.5), width: 1)),
                        child: Center(
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey.withOpacity(.9),
                          ),
                        )),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Address',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text('EkpewerechieWilson@gmail.com',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3D16D6))),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Available Drinks',
                    style: TextStyle(color: Colors.black, fontSize: 21.0),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HomeScreen())),
                    child: Text(
                      'See all',
                      style: TextStyle(color: Color(0xFF3D16D6), fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(child: DrinkDisplay())
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Color(0xFF3D16D6),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddProductPage()));
        },
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
    );
  }
}
