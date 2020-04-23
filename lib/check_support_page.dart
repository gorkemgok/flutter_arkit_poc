import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arkitpoc/ar_view_page.dart';
import 'package:flutter/material.dart';

class CheckSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Check ARKit Support Sample'),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      ARKitConfiguration.values.map((e) => showSupport(e)).toList(),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => ARViewPage())),
      tooltip: 'Increment',
      child: Icon(Icons.swap_horiz),
    ),
  );

  Widget showSupport(ARKitConfiguration configuration) {
    return Row(children: [
      Text(configuration.toString()),
      FutureBuilder<bool>(
          future: ARKitPlugin.checkConfiguration(configuration),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text(' loading');
            }
            return Text(snapshot.data ? ' supported' : ' not supported');
          })
    ]);
  }
}