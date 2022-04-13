import 'package:curso_firebase/Firebase/fetch_data.dart';
import 'package:curso_firebase/Models/courier_model.dart';
import 'package:curso_firebase/Providers/auth_provider.dart';
import 'package:curso_firebase/UI/Items/courier_item.dart';
import 'package:curso_firebase/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

import '../../Firebase/querys.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<CourierModel> courierList = [];

  loadCouriers() async{
    courierList = await FetchData().getCourierList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCouriers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Lista de repartidores"
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                    onPressed: () async{

                      String id = randomAlphaNumeric(24);
                      CourierModel courier = CourierModel(
                          id: id,
                          name: "Alex Rodriguez",
                          email: "alexr@gmail.com",
                          urlProfile: ""
                      );

                      bool error =  await QuerysService().SaveGeneralInfo(
                          reference: REFERENCE_COURIERS,
                          id: id,
                          collectionValues: courier.toJson()
                      );

                      if(error){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Hubo un error, intenta de nuevo"),
                              duration: Duration(seconds: 3),
                            ));
                        print(error);
                      } else{
                        loadCouriers();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Repartidor agregado exitosamente"),
                              duration: Duration(seconds: 3),
                            ));
                      }
                    },
                    child: const Text(
                      "Agregar repartidor"
                    )
                )
              ],
            ),
            const SizedBox(height: 20.0),
            Flexible(child: _list())
          ],
        ),
      ),
    );
  }

  Widget _list(){
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: courierList.length, // 0
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) => ItemCourier(courierModel: courierList[index]),
      ),
    );
  }
}
