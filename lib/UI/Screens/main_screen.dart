import 'package:curso_firebase/Providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Esta es la pagina principal'
            ),
            ElevatedButton(
                onPressed: (){
                  Provider.of<AuthProvider>(context, listen: false).logout(context);
                },
                child: Text(
                  "Cerrar sesión"
                )
            )
          ],
        ),
      ),
    );
  }
}
