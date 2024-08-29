import 'package:flutter/material.dart';

class BestSellersPage extends StatefulWidget {
  @override
  _BestSellersPageState createState() => _BestSellersPageState();
}

class _BestSellersPageState extends State<BestSellersPage> {
  bool isAscending = true;

  List<Map<String, dynamic>> products = [
    {
      "image": "assets/nike/best1.png",
      "name": "Nike Air Force",
      "category": "Men's Shoes",
      "price": 367.76,
      "colors": [Colors.blue, Colors.green, Colors.orange],
    },
    {
      "image": "assets/nike/best2.png",
      "name": "Nike Air Max",
      "category": "Men's Shoes",
      "price": 254.89,
      "colors": [Colors.red, Colors.blue, Colors.orange],
    },
    {
      "image": "assets/nike/best3.png",
      "name": "Nike Jordan",
      "category": "Men's Shoes",
      "price": 367.76,
      "colors": [Colors.blue, Colors.green, Colors.red],
    },
    {
      "image": "assets/nike/best4.png",
      "name": "Nike Air Max",
      "category": "Men's Shoes",
      "price": 254.89,
      "colors": [Colors.pink, Colors.blue, Colors.purple],
    },
    {
      "image": "assets/nike/best5.png",
      "name": "Adidas Ultraboost",
      "category": "Men's Shoes",
      "price": 289.99,
      "colors": [Colors.red, Colors.black, Colors.white],
    },
    {
      "image": "assets/nike/best6.png",
      "name": "Puma RS-X",
      "category": "Men's Shoes",
      "price": 219.95,
      "colors": [Colors.green, Colors.yellow, Colors.blue],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Best Sellers'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              setState(() {
                isAscending = !isAscending;
                products.sort((a, b) =>
                    isAscending ? a["price"].compareTo(b["price"]) : b["price"].compareTo(a["price"]));
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
             
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(product["image"], height: 100, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BEST SELLER",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          product["name"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          product["category"],
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "\$${product["price"].toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),  
                        SizedBox(height: 10),
                        Row(
                          children: product["colors"].map<Widget>((color) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: color,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
