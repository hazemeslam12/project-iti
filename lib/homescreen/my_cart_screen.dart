import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartItem {
  final String name;
  final String size;
  final double price;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.name,
    required this.size,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });


  Map<String, dynamic> toJson() => {
    'name': name,
    'size': size,
    'price': price,
    'quantity': quantity,
    'imageUrl': imageUrl,
  };

 
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    name: json['name'],
    size: json['size'],
    price: json['price'],
    quantity: json['quantity'],
    imageUrl: json['imageUrl'],
  );
}

class MyCartScreen extends StatefulWidget {
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartItems().then((items) {
      setState(() {
        cartItems = items;
      });
    });
  }

  @override
  void dispose() {
    saveCartItems(cartItems);
    super.dispose();
  }

  Future<void> saveCartItems(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonItems = items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cart_items', jsonItems);
  }

  Future<List<CartItem>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonItems = prefs.getStringList('cart_items');
    
    if (jsonItems == null) return [];
    
    return jsonItems.map((jsonItem) {
      Map<String, dynamic> data = jsonDecode(jsonItem);
      return CartItem.fromJson(data);
    }).toList();
  }

  double get subtotal => cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get shipping => 40.90; 

  double get totalCost => subtotal + shipping;

  void increaseQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void decreaseQuantity(CartItem item) {
    setState(() {
      if (item.quantity > 1) item.quantity--;
    });
  }

  void removeItem(CartItem item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Image.asset(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('\$${item.price}', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(item.size),
                      SizedBox(width: 16),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => decreaseQuantity(item),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => increaseQuantity(item),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeItem(item),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                SizedBox(height: 8),
                _buildSummaryRow('Shipping', '\$${shipping.toStringAsFixed(2)}'),
                Divider(thickness: 2, height: 32),
                _buildSummaryRow('Total Cost', '\$${totalCost.toStringAsFixed(2)}', isTotal: true),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                   
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, 
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Checkout',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: isTotal ? 18 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
        ),
        Text(
          value,
          style: TextStyle(fontSize: isTotal ? 18 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
