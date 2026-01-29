import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(color: Theme.of(context).colorScheme.primary, child: Text("data"),);
  }
}