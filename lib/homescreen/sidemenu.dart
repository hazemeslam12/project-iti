import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/homescreen/best_sellers.dart';
import 'package:proj_app/homescreen/favorite.dart';
import 'package:proj_app/homescreen/home.dart';
import 'package:proj_app/homescreen/my_cart_screen.dart';
import 'package:proj_app/homescreen/notification.dart';
import 'package:proj_app/homescreen/profile.dart';
import 'package:proj_app/openingpages/login.dart';
import 'package:proj_app/user_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: SideMenu(),
      body: Center(
        child: Text('Main Content Area', style: GoogleFonts.rubik(fontSize: 24)),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1D2635),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF1D2635),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/profile image.jpg'),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Hey, 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Flexible(
                      child: Consumer<UserModel>(
                        builder: (context, userModel, child) {
                          return Text(
                            userModel.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  'Profile',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  },

              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text(
                  'Home Page',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );},
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.white),
                title: Text(
                  'My Cart',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyCartScreen()),
    );},
              ),
              ListTile(
                leading: Icon(Icons.favorite, color: Colors.white),
                title: Text(
                  'Favorite',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoriteScreen(favoriteProducts: [],)),
    );},
              ),
              ListTile(
                leading: Icon(Icons.list_alt, color: Colors.white),
                title: Text(
                  'Best Sellers',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BestSellersPage ()),
    );},
              ),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.white),
                title: Text(
                  'Notifications',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationPage ()),
    );},
              ),
              Divider(color: Colors.white),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                title: Text(
                  'Sign Out',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage ()),
    );},
              ),
            ],
          ),
        ),
      ),
    );
  }
}