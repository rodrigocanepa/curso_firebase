import 'package:curso_firebase/Models/courier_model.dart';
import 'package:flutter/material.dart';

class ItemCourier extends StatefulWidget {
  final CourierModel courierModel;
  const ItemCourier({Key? key, required this.courierModel}) : super(key: key);

  @override
  _ItemCourierState createState() => _ItemCourierState();
}

class _ItemCourierState extends State<ItemCourier> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        widget.courierModel.name
      ),
    );
  }
}
