import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationUtils{

  pushPage(BuildContext context, Widget page){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => page
        )
    );
  }

  pushReplacementPage(BuildContext context, Widget page){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => page
        )
    );
  }

  pushAndRemovePage(BuildContext context, Widget page){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => page
        ),
            (route) => false
    );
  }
}