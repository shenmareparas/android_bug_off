import 'package:engage_files/Pages/details.dart';
import 'package:engage_files/models/products.dart';
import 'package:engage_files/models/user_model.dart';
import 'package:engage_files/responsivescreen.dart';
import 'package:flutter/material.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "My Cart",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  "You have ${CurrentUser.currentUser?.cart.length ?? [].length} items in your cart",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Visibility(
                  visible: CurrentUser.currentUser!.cart.isEmpty,
                  child: const Text(
                    "No items in your cart",
                    style: TextStyle(
                      fontSize: 36,
                      letterSpacing: -4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: CurrentUser.currentUser!.cart.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Details(
                                product: CurrentUser.currentUser!.cart[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: ResponsiveScreen.screenWidth,
                          height: ResponsiveScreen.screenHeight! * 0.16,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    productData[index]['thumbnail'],
                                    width:
                                        ResponsiveScreen.screenHeight! * 0.14,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      productData[index]['name'].length > 20
                                          ? "${productData[index]['name']
                                                  .toString()
                                                  .substring(0, 20)}..."
                                          : productData[index]['name'],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      productData[index]['description']
                                                  .toString()
                                                  .length >
                                              30
                                          ? "${productData[index]['description']
                                                  .toString()
                                                  .substring(0, 30)}..."
                                          : productData[index]['description'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      productData[index]['price']
                                          .toString()
                                          .replaceAll("to ", "-")
                                          .replaceAll("C", " ")
                                          .trim(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      productData[index]['logistics_cost'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      productData[index]['product_location'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
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
