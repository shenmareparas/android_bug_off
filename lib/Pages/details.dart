import 'package:engage_files/models/firestore_model.dart';
import 'package:engage_files/models/products.dart';
import 'package:engage_files/models/user_model.dart';
import 'package:engage_files/responsivescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatefulWidget {
  Map<String, dynamic> product;
  Details({super.key, required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late bool fav = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Details',
              style: GoogleFonts.montserrat(
                  fontSize: ResponsiveScreen.halfRepWidth(context, 30),
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (() {
                setState(() {
                  fav = !fav;
                });
              }),
              icon: fav
                  ? const Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width, //double.infinity,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5),
                child: PageView.builder(
                    itemCount: 1,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                widget.product['thumbnail'],
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, top: 5),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              widget.product['name'].length >
                                      ResponsiveScreen.fullRepWidth(context, 22)
                                          .round()
                                  ? widget.product['name'].substring(
                                          0,
                                          ResponsiveScreen.fullRepWidth(
                                                  context, 22)
                                              .round()) +
                                      '...'
                                  : widget.product['name'],
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            widget.product['price']
                                .toString()
                                .replaceAll('C', " ")
                                .replaceAll('to ', "-")
                                .trim(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 20),
                      child: Text(
                        widget.product['description'],
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 20),
                      child: Text(
                        widget.product['product_location'],
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 20),
                      child: Text(
                        widget.product['logistics_cost'],
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 20),
                      child: Text(
                        widget.product['condition'],
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 20),
                      child: Text(
                        widget.product['uninformed'] ?? "",
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    Visibility(
                      visible: widget.product['reviews'] != null,
                      child: InkWell(
                        onTap: () async {
                          //launch url
                          await myUrlLauncher(urlPtoduct);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 15, right: 20),
                          child: Text(
                            "Click here for reviews",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  CurrentUser.currentUser?.cart == null
                      ? [widget.product]
                      : CurrentUser.currentUser!.cart.add(
                          widget.product,
                        );
                  await FirestoreuserData.setMyCart(
                      CurrentUser.currentUserUid!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.blue[100],
                      content: const Text('Added to cart'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: Colors.black)),
                  child: Text(
                    'Add to Cart',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (CurrentUser.currentUser?.orders
                          .contains(widget.product) ==
                      true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          textColor: Colors.white,
                          label: "Dismiss",
                          onPressed: () {},
                        ),
                        content: const Text('Already ordered'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                    return;
                  }
                  CurrentUser.currentUser?.orders == null
                      ? [widget.product]
                      : CurrentUser.currentUser!.orders.add(
                          widget.product,
                        );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: Colors.black)),
                  child: Text(
                    'Buy Now',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
