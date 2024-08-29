import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, dynamic>> todayNotifications = [
    {
      "image": "assets/nike/nike1.png",
      "title": "We Have New Products With Offers",
      "price": "\$364.95",
      "discountedPrice": "\$260.00",
      "timeAgo": "6 min ago",
      "isNew": true,
    },
    {
      "image": "assets/nike/Nike Air Max.png",
      "title": "We Have New Products With Offers",
      "price": "\$364.95",
      "discountedPrice": "\$260.00",
      "timeAgo": "26 min ago",
      "isNew": true,
    },
  ];

  final List<Map<String, dynamic>> yesterdayNotifications = [
    {
      "image": "assets/nike/nike2.png",
      "title": "We Have New Products With Offers",
      "price": "\$364.95",
      "discountedPrice": "\$260.00",
      "timeAgo": "4 day ago",
      "isNew": false,
    },
    {
      "image": "assets/nike/nike_air_jordan.png",
      "title": "We Have New Products With Offers",
      "price": "\$364.95",
      "discountedPrice": "\$260.00",
      "timeAgo": "4 day ago",
      "isNew": false,
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
        title: Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
      
            },
            child: Text(
              'Clear All',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            buildNotificationSection("Today", todayNotifications),
            SizedBox(height: 20),
            buildNotificationSection("Yesterday", yesterdayNotifications),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationSection(String sectionTitle, List<Map<String, dynamic>> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: notifications.map((notification) {
            return buildNotificationCard(notification);
          }).toList(),
        ),
      ],
    );
  }

  Widget buildNotificationCard(Map<String, dynamic> notification) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.asset(notification["image"], width: 50),
        title: Text(notification["title"]),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification["price"],
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Text(
              notification["discountedPrice"],
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(notification["timeAgo"]),
            if (notification["isNew"])
              Icon(
                Icons.circle,
                color: Colors.blue,
                size: 10,
              ),
          ],
        ),
      ),
    );
  }
}
