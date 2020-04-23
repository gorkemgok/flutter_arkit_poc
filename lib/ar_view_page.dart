import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arkitpoc/check_support_page.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vec;

class ARViewPage extends StatefulWidget {
  ARViewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ARViewPageState createState() => _ARViewPageState();
}

class _ARViewPageState extends State<ARViewPage> {

  ARKitController arkitController;

  List<ARKitNode> nodes = [];

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('AR Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Check Support'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => CheckSupportPage())),
            ),
          ],
        ),
      ),
      body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nodes.first.scale.value = vec.Vector3(1, 0.5, 1);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    final node = ARKitNode(
        geometry: ARKitCone(height: 0.1, topRadius: 0, bottomRadius: 0.1),
        position: vec.Vector3(0, 0, -0.5)
    );
    this.nodes.add(node);

    final node2 = ARKitReferenceNode(
      url: 'flutter_assets/assets/models/ar_project_test.abc',
      position: vec.Vector3(0, 0, 0),
      scale: vec.Vector3(0.002, 0.002, 0.002),
    );
    this.nodes.add(node2);

    //this.arkitController.add(node);
    this.arkitController.add(node2);
  }
}