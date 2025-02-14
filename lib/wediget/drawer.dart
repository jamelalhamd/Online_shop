import 'package:flutter/material.dart';

class Reusabledrawer extends StatelessWidget {
  final String accountName;
  final String accountEmail;
  final String profileImage;
  final List<DrawerItem> drawerItems;
  final VoidCallback onLogout;

  const Reusabledrawer({
    Key? key,
    required this.accountName,
    required this.accountEmail,
    required this.profileImage,
    required this.drawerItems,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(profileImage),
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: drawerItems.map((item) {
                return _buildDrawerItem(
                  icon: item.icon,
                  text: item.text,
                  onTap: item.onTap,
                );
              }).toList(),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text("Logout",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onTap: onLogout,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(text, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  DrawerItem({
    required this.icon,
    required this.text,
    required this.onTap,
    required String title,
  });
}
