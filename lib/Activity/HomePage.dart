import 'package:flutter/material.dart';
import 'package:practice_flutter/utills/MyRoutes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact List')),
      drawer: Drawer(
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,
        width: 250.0,
        elevation: 10.0,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.lightBlueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Image.asset('assets/images/profile.png',
                      height: 50, width: 50),
                  const SizedBox(height: 8),
                  const Text("Sumit Panchal",
                      style: TextStyle(fontSize: 25, color: Colors.black)),
                  const Text("panchalsumit187@gmail.com",
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ],
              ),
            ),
            ListTile(
              leading:
                  Image.asset('assets/images/home.png', width: 30, height: 30),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading:
                  Image.asset('assets/images/call.png', width: 30, height: 30),
              title: const Text("Call"),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset('assets/images/contact.png',
                  width: 30, height: 30),
              title: const Text("Contact"),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset('assets/images/logout.png',
                  width: 30, height: 30),
              title: const Text("Log out"),
              onTap: () {
                print("Clicked on logout");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddContact page when FAB is pressed
          Navigator.pushNamed(context, MyRoutes.contactRoute);
        },
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
