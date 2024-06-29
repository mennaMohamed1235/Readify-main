import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';
import 'package:fruit_e_commerce/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:fruit_e_commerce/features/authors/presentation/pages/authors_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: context.getWidth(divide: 0.63),
        clipBehavior: Clip.none,
        elevation: 0,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            GestureDetector(
              onLongPress: () {
                // just for demo test
                Fluttertoast.showToast(msg: "Admin Mood", backgroundColor: AppColors.primaryColor, toastLength: Toast.LENGTH_LONG);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboardPage()));
              },
              child: SizedBox(
                height: context.getHight(divide: 0.3),
                child: DrawerHeader(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "READIFY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.getDefaultSize() * 3,
                        ),
                      ),
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthorsPage()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.people,
                  size: context.getDefaultSize() * 2,
                ),
                title: Text("Book Authors", style: TextStyle(fontSize: context.getDefaultSize() * 1.8)),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: context.getDefaultSize() * 2,
              ),
              title: Text("Profile", style: TextStyle(fontSize: context.getDefaultSize() * 1.8)),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: context.getDefaultSize() * 2,
              ),
              title: Text("Settings", style: TextStyle(fontSize: context.getDefaultSize() * 1.8)),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: context.getDefaultSize() * 2,
              ),
              title: Text("Log Out", style: TextStyle(fontSize: context.getDefaultSize() * 1.8)),
            )
          ],
        ));
  }
}
