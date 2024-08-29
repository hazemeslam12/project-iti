import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/homescreen/home.dart';

class DetailsScreen extends StatefulWidget {
  final String imagePath;
  final String name;
  final double price;
  final String description;

  DetailsScreen({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.description,
     
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late String selectedImagePath;
  late String mainImagePath;
  String? selectedSize; 


  @override
  void initState() {
    super.initState();
    mainImagePath = widget.imagePath;
    selectedImagePath = widget.imagePath; 
  }

  void _swapImages(String newImagePath) {
    setState(() {
      String temp = mainImagePath;
      mainImagePath = newImagePath;
      selectedImagePath = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(widget.name, style: GoogleFonts.rubik(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
             
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                mainImagePath,
                width: 200 ,
                height: 200, 
              ),
            ),
            SizedBox(height: 16),
            Text(
              'BEST SELLER',
              style: GoogleFonts.rubik(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              widget.name,
              style: GoogleFonts.rubik(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${widget.price}',
              style: GoogleFonts.rubik(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 16),
            Text(
              widget.description,
              style: GoogleFonts.rubik(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Gallery',
              style: GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                GalleryImage(
                  imagePath: 'assets/nike/nike_jordan.png',
                  onTap: () => _swapImages('assets/nike/nike_jordan.png'),
                ),
                GalleryImage(
                  imagePath: 'assets/nike/nike_air_max.png',
                  onTap: () => _swapImages('assets/nike/nike_air_max.png'),
                ),
                GalleryImage(
                  imagePath: 'assets/nike/nike_air_jordan.png',
                  onTap: () => _swapImages('assets/nike/nike_air_jordan.png'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Size',
              style: GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizeOption(
                  size: '38',
                  isSelected: selectedSize == '38',
                  onTap: () {
                    setState(() {
                      selectedSize = '38';
                    });
                  },
                ),
                SizeOption(
                  size: '39',
                  isSelected: selectedSize == '39',
                  onTap: () {
                    setState(() {
                      selectedSize = '39';
                    });
                  },
                ),
                SizeOption(
                  size: '40',
                  isSelected: selectedSize == '40',
                  onTap: () {
                    setState(() {
                      selectedSize = '40';
                    });
                  },
                ),
                SizeOption(
                  size: '41',
                  isSelected: selectedSize == '41',
                  onTap: () {
                    setState(() {
                      selectedSize = '41';
                    });
                  },
                ),
                SizeOption(
                  size: '42',
                  isSelected: selectedSize == '42',
                  onTap: () {
                    setState(() {
                      selectedSize = '42';
                    });
                  },
                ),
                SizeOption(
                  size: '43',
                  isSelected: selectedSize == '43',
                  onTap: () {
                    setState(() {
                      selectedSize = '43';
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
               
              },
              child: Text('Add To Cart', style: GoogleFonts.rubik(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const GalleryImage({required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.asset(imagePath, width: 60, height: 60),
      ),
    );
  }
}

class SizeOption extends StatelessWidget {
  final String size;
  final bool isSelected;
  final VoidCallback onTap;

  const SizeOption({
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, 
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: isSelected ? Colors.blue : Colors.grey[200], 
            child: Text(
              size,
              style: GoogleFonts.rubik(fontSize: 16, color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
