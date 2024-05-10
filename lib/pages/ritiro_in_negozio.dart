import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../models/shop.dart';

class RitiroInNegozioPage extends StatefulWidget {
  final String title;

  const RitiroInNegozioPage({Key? key, required this.title}) : super(key: key);

  @override
  State<RitiroInNegozioPage> createState() => _RitiroInNegozioPageState();
}

class _RitiroInNegozioPageState extends State<RitiroInNegozioPage> {
  late Future<List<Shop>> futureShops;

  @override
  void initState() {
    super.initState();
    futureShops = fetchShops().catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to fetch shops: $error'),
      ));
      return Future.value([]); // Return an empty list wrapped in a Future
    });
  }

  Future<List<Shop>> fetchShops() async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('Y41EKEKA2BES3BZ4QXW1M31TU9UYGIYH:'));
    List<Shop> shops = [];

    // Fetch the list of shops
    final response = await http.get(
      Uri.parse('https://speasy.it/api/shops'),
      headers: <String, String>{'Authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      List<Future<Shop>> shopRequests = [];

      // Iterate through each 'shop' element
      for (final element in document.findAllElements('shop')) {
        final shopLink = element.getAttribute('xlink:href');

        // Fetch each shop details if the link is available
        if (shopLink != null) {
          shopRequests.add(fetchShopDetails(shopLink, basicAuth));
        }
      }

      // Wait for all HTTP requests to complete
      shops = await Future.wait(shopRequests);
    } else {
      throw Exception('Failed to load shops - Status code: ${response.statusCode}');
    }

    return shops;
  }

  // Function to fetch individual shop details
  Future<Shop> fetchShopDetails(String shopLink, String basicAuth) async {
    final response = await http.get(
      Uri.parse(shopLink),
      headers: <String, String>{'Authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      return Shop.fromXml(document.findAllElements('shop').first, 'Default Group'); // Pass a default group name
    } else {
      throw Exception('Failed to load shop details - Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Shop>>(
        future: futureShops,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No shops found');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final shop = snapshot.data![index];
                return ListTile(
                  title: Text(shop.groupName),
                  subtitle: Text(shop.name),
                  trailing: Text('ID: ${shop.id}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
