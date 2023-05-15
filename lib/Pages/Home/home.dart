import 'package:engage_files/Pages/details.dart';
import 'package:engage_files/color_schemes.dart';
import 'package:engage_files/models/products.dart';
import 'package:engage_files/responsivescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchcontroller = TextEditingController();

  List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover Product',
            style: GoogleFonts.montserrat(
                fontSize: ResponsiveScreen.halfRepWidth(context, 30),
                fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _searchcontroller,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  hintText: "Search",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: ResponsiveScreen.halfRepWidth(context, 16),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                  border: const UnderlineInputBorder(),
                  contentPadding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
                ),
              ),
              SizedBox(
                height: ResponsiveScreen.fullRepHeight(context, 18),
              ),
              Expanded(
                child: MasonryGridView.builder(
                  itemCount: productData.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Details(
                                    product: productData[index],
                                  )));
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  productData[index]['thumbnail'],
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              SizedBox(
                                height:
                                    ResponsiveScreen.fullRepHeight(context, 4),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    productData[index]['name'],
                                    style: GoogleFonts.montserrat(
                                      fontSize: ResponsiveScreen.halfRepWidth(
                                          context, 12),
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      productData[index]['price'].toString(),
                                      style: GoogleFonts.montserrat(
                                        color: lightColorScheme.primary,
                                        fontSize: ResponsiveScreen.halfRepWidth(
                                            context, 12),
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ResponsiveScreen.halfRepWidth(
                                        context, 4),
                                  ),
                                  Center(
                                    child: Text(
                                      " ",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.blue[700],
                                        fontSize: ResponsiveScreen.halfRepWidth(
                                            context, 12),
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ],
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
