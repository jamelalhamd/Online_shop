import 'package:flutter/material.dart';

class ReusableNotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback? onclick;

  ReusableNotificationCard(
      {Key? key,
      required this.title,
      required this.message,
      this.icon = Icons.notifications,
      this.backgroundColor = Colors.blueAccent,
      this.onclick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: backgroundColor,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon, color: backgroundColor),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: onclick,
          ),
        ),
      ),
    );
  }
}
