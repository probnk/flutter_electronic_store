import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:electronic_store_app/HomePage.dart';
import 'package:electronic_store_app/dashborad.dart';
import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {

  final _controller = AwesomeDrawerBarController();

  @override
  Widget build(BuildContext context) {
    return AwesomeDrawerBar(
      controller: _controller,
      menuScreen: dashboard(),
      mainScreen: HomePage(),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      backgroundColor: Colors.grey.shade300,
      slideWidth: MediaQuery.of(context).size.width*.65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }
}
