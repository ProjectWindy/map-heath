import 'dart:io';
 
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:health_app/core/get_x/get_x.dart';
import 'package:health_app/screens/account/my_account.dart';
import 'package:health_app/screens/home/home/home.dart';
import 'package:health_app/screens/home/trending/trending.dart';
import 'package:health_app/style/style.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final UserDataController userDataController = Get.put(UserDataController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.nearlyWhite,
          title: const Text("B-Idea",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 30),),
          bottom: TabBar(
            dividerColor: Styles.defaultLightGreyColor,
            indicatorColor: Styles.defaultBlueColor,
            labelColor: Styles.defaultBlueColor,
            tabs: const [
              Tab(icon: Icon(Icons.home,size: 30,)),
              Tab(icon: Icon(Icons.local_fire_department,size: 30)),
              Tab(icon: Icon(Icons.account_circle,size: 30)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const HomeScreen(),
            const TrendingScreen(),
            AccountPage(id:"${userDataController.id}"),
          ],
        ),
      ),
    );
  }
}