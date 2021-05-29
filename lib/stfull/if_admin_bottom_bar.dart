import 'package:flutter/material.dart';
import 'package:v1/db/auth.dart';
import 'package:v1/screens/home-screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class IfAdminBottomBar extends StatelessWidget {
  var currentIndex=0;
  IfAdminBottomBar(this.currentIndex);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbAuth.userInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          userRole = snapshot.data[0];
          if (userRole != 'admin') 
          {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Orders',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.logout),
                  label: 'Log Out',
                  backgroundColor: Colors.black,
                ),
              ],
              currentIndex: 0,
              selectedItemColor: Colors.white,
              onTap: (index) {
                switch (index) {
                  case 0:
                    
                    break;
                  case 1:
                    Navigator.pushNamed(context, "/orders");
                    break;
                  case 2:
                    Navigator.pushNamed(context, "/profile");
                    break;
                  case 3:
                    context.read<Auth>().signOut();
                    Navigator.pushNamed(context, "/login");
                    break;
                }
              },
            );
          } else {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Add item',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'All Orders',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.logout),
                  label: 'Log Out',
                  backgroundColor: Colors.black,
                ),
              ],
              currentIndex: 0,
              selectedItemColor: Colors.white,
              onTap: (index) {
                switch (index) {
                  case 0:
                    break;
                  case 1:
                    Navigator.pushNamed(context, "/addItem");
                    break;
                  case 2:
                    Navigator.pushNamed(context, "/orders");
                    break;
                  case 3:
                    Navigator.pushNamed(context, "/profile");
                    break;
                  case 4:
                    context.read<Auth>().signOut();
                    Navigator.pushNamed(context, "/login");
                    break;
                }
              },
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
