import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class OnboardingPages extends StatefulWidget {
  @override
  _OnboardingPagesState createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {}); 
            },
            children: [
              OnboardingPage(
                imagePath: 'assets/shose1.png',
                backgroundImagePath: 'assets/NIKE.png',
                dotsImagePath: 'assets/dots.png',
                title: 'Start Journey With Nike',
                subtitle: 'Smart, Gorgeous & Fashionable Collection',
                buttonText: 'Get Started',
              ),
              OnboardingPage(
                imagePath: 'assets/shose2.png',
                backgroundImagePath: 'assets/NIKE.png',
                dotsImagePath: 'assets/dots.png',
                title: 'Follow Latest Style Shoes',
                subtitle: 'There Are Many Beautiful And Attractive Plants To Your Room',
                buttonText: 'Next',
              ),
              OnboardingPage(
                imagePath: 'assets/shose3.png',
                backgroundImagePath: 'assets/NIKE.png',
                dotsImagePath: 'assets/dots.png',
                title: 'Discover New Trends',
                subtitle: 'Unique styles that make a statement.',
                buttonText: 'Finish',
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 16,
                      expansionFactor: 3,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_pageController.hasClients && _pageController.page! < 2) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else if (_pageController.hasClients && _pageController.page == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    },
                    child: Text(
                      _pageController.hasClients && _pageController.page == 2 ? 'Finish' : 'Next',
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String backgroundImagePath;
  final String dotsImagePath;
  final String title;
  final String subtitle;
  final String buttonText;

  const OnboardingPage({
    required this.imagePath,
    required this.backgroundImagePath,
    required this.dotsImagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: screenHeight / 6,
          left: 0,
          right: 0,
          child: Image.asset(
            dotsImagePath,
            fit: BoxFit.contain,
            width: screenWidth * 0.8,
            height: screenHeight * 0.4,
          ),
        ),
        Positioned(
          top: screenHeight / 4,
          left: 0,
          right: 0,
          child: Image.asset(
            backgroundImagePath,
            fit: BoxFit.contain,
            width: screenWidth * 0.8,
            height: screenHeight * 0.4,
          ),
        ),
        Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            width: screenWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.rubik(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 32 / 24,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        height: 32 / 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
