import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/bloc/bloc.dart';
import '/homescreen/favorite.dart';
import 'details.dart';
import 'my_cart_screen.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:proj_app/homescreen/sidemenu.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _favoriteProducts = [];

  void _handleFavoriteToggle(Product product) {
    setState(() {
      if (_favoriteProducts.contains(product)) {
        _favoriteProducts.remove(product);
      } else {
        _favoriteProducts.add(product);
      }
    });
  }

  Future<void> _addToCart(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cart_items') ?? [];
    Map<String, dynamic> productJson = {
      'name': product.name,
      'price': product.price,
      'quantity': 1,
      'imageUrl': product.imagePath,
      'size': 'Unknown', 
    };
    cartItems.add(jsonEncode(productJson));
    await prefs.setStringList('cart_items', cartItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  leading: IconButton(
    icon: Icon(Icons.menu),  
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SideMenu()), );
    },
  ),
  title: Text('Home', style: GoogleFonts.rubik(fontSize: 20, fontWeight: FontWeight.bold)),
  elevation: 0,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
  actions: [
    IconButton(
      icon: Icon(Icons.shopping_bag),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyCartScreen(),  
          ),
        );
      },
    ),
  ],
),


      body: BlocProvider(
        create: (context) => FavoriteBloc(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Store location', style: GoogleFonts.rubik(fontSize: 14, fontWeight: FontWeight.w400)),
                  PopupMenuButton<String>(
                    onSelected: (String result) {
                      if (result == 'Option 1') {
                        
                      } else if (result == 'Option 2') {
                        
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Option 1',
                        child: Text('Option 1'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Option 2',
                        child: Text('Option 2'),
                      ),
                    ],
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
              Text('egypt, Ismailia', style: GoogleFonts.lilitaOne(fontSize: 19, fontWeight: FontWeight.w500)),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'search for shoes',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),
               SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryIcon(backgroundColor: Colors.white, imagePath: 'assets/nike/nike logo.png', label: 'Nike'),
                    CategoryIcon(backgroundColor: Colors.white, imagePath: 'assets/nike/puma.png', label: 'Puma'),
                    CategoryIcon(backgroundColor: Colors.white, imagePath: 'assets/nike/adidaslogo.png', label: 'Adidas'),
                    CategoryIcon(backgroundColor: Colors.white, imagePath: 'assets/nike/under armour logo.png', label: 'Under Armour'),
                    CategoryIcon(backgroundColor: Colors.white, imagePath: 'assets/nike/converse logo.png', label: 'Converse'),
                  ],
                ),
              ),
              SizedBox(height: 10),
              
              SectionHeader(title: 'Popular Shoes'),
              SizedBox(height: 8),
              HorizontalProductList(
                products: [
                  Product(imagePath: 'assets/nike/nike_jordan.png', name: 'Nike Jordan', price: 493.00),
                  Product(imagePath: 'assets/nike/nike_air_max.png', name: 'Nike Air Max', price: 897.99),
                ],
                onFavoriteToggle: _handleFavoriteToggle, 
              ),
              SizedBox(height: 16),

              
              SectionHeader(title: 'New Arrivals'),
              SizedBox(height: 8),
              HorizontalProductList(
                products: [
                  Product(imagePath: 'assets/nike/nike_air_jordan.png', name: 'Nike Air Jordan', price: 849.69),
                  Product(imagePath: 'assets/nike/Nike Air Max.png', name: 'Nike Air Max', price: 245.99),
                  Product(imagePath: 'assets/nike/nike_jordan.png', name: 'Nike Jordan', price: 365.99),
                  Product(imagePath: 'assets/nike/nike_air_max.png', name: 'Nike Air Max', price: 721.99),
                ],
                onFavoriteToggle: _handleFavoriteToggle, 
              ),
            ],              
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(favoriteProducts: _favoriteProducts),
    );
  }
}
class CustomBottomNavigationBar extends StatefulWidget {
  final List<Product> favoriteProducts;

  CustomBottomNavigationBar({required this.favoriteProducts});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoriteScreen(favoriteProducts: widget.favoriteProducts),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.favorite, color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
                onPressed: () => _onItemTapped(1),
              ),
              SizedBox(width: 50), 
              IconButton(
                icon: Icon(Icons.notifications, color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: Icon(Icons.person, color: _selectedIndex == 3 ? Colors.blue : Colors.grey),
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
        Positioned(
          top: -30,
          left: MediaQuery.of(context).size.width * 0.5 - 30,
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.shopping_bag),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final String imagePath;
  final String label;
  final Color backgroundColor; 

  const CategoryIcon({required this.imagePath, required this.label,required this.backgroundColor });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
             backgroundColor: backgroundColor,
            backgroundImage: AssetImage(imagePath),
            radius: 24,
            
          ),
          SizedBox(height: 4),
          Text(label, style: GoogleFonts.rubik(fontSize: 14)),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('See all', style: GoogleFonts.rubik(fontSize: 14, color: Colors.blue)),
      ],
    );
  }
}

class HorizontalProductList extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onFavoriteToggle;

  const HorizontalProductList({required this.products, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.7, 
      ),
      itemCount: products.length,
      shrinkWrap: true, 
      physics: NeverScrollableScrollPhysics(), 
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onFavoriteToggle: onFavoriteToggle, 
        );
      },
    );
  }
}


class Product {
  final String imagePath;
  final String name;
  final double price;

  Product({required this.imagePath, required this.name, required this.price});
}

class ProductCard extends StatefulWidget {
  final Product product;
  final Function(Product) onFavoriteToggle;

  const ProductCard({required this.product, required this.onFavoriteToggle});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorite = false; 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              imagePath: widget.product.imagePath,
              name: widget.product.name,
              price: widget.product.price,
              description: 'Air Jordan is an American brand of basketball shoes athletic, casual, and style clothing produced by Nike....', 
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(widget.product.imagePath, width: double.infinity, height: 100, fit: BoxFit.cover),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product.name, style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 4),
                    Text('\$${widget.product.price}', style: GoogleFonts.rubik(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      child: Icon(Icons.add, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(8.0),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite; 
                        });
                        widget.onFavoriteToggle(widget.product); 
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
