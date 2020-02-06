import 'package:flutter/material.dart';
import 'package:test_app1/model/devices.dart';
import './deviceDetails.dart';

void main() {
  runApp(new MaterialApp(home: Homepage(), routes: <String, WidgetBuilder>{
    "/SecondPage": (BuildContext context) => new SecondPage()
  }));
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Devices"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.favorite, color: Colors.greenAccent),
                iconSize: 60,
                onPressed: () {
                  Navigator.of(context).pushNamed("/SecondPage");
                },
              ),
              new Text("Home")
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final List<DeviceList> getDevices = DeviceList.getDeviceList();
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Devices"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.book, color: Colors.green),
                iconSize: 60,
                onPressed: () {
                  Navigator.of(context).pushNamed("/");
                },
              ),
              new Text("Device List",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  )),
              new Expanded(
                  child: ListView.builder(
                itemCount: getDevices.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    color: Colors.white30,
                    shape: new RoundedRectangleBorder(
                      side:
                          new BorderSide(color: Colors.greenAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: new ListTile(
                      leading: (getDevices[index].status == true) 
                      ? 
                      Icon(Icons.done_outline ,
                          color: Colors.green, size: 30)
                      :
                      Icon(Icons.block,
                          color: Colors.red, size: 30),
                      title: Text(
                        getDevices[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      subtitle: Text(getDevices[index].deviceType),
                      onTap: () {
                        debugPrint("${getDevices.elementAt(index).name}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeviceDetails(
                              device: getDevices[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
                  // child: ListView(
                  //   children: <Widget>[
                  //     ListTile(
                  //       leading: Icon(Icons.check, color: Colors.green),
                  //       title: Text(getString()),
                  //       onTap: () {
                  //         Navigator.of(context).pushNamed("/");
                  //       },
                  //     ),
                  //     ListTile(
                  //         leading: Icon(Icons.check, color: Colors.green),
                  //         title: Text("PlayStation 4")),
                  //   ],
                  // ),
                  ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
      ),
    );
  }

  Widget getListView(Navigator goBAck) {
    BuildContext context;
    var listView = ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.check, color: Colors.green),
          title: Text(getString()),
          onLongPress: () {},
        ),
        ListTile(
            leading: Icon(Icons.check, color: Colors.green),
            title: Text("PlayStation 4")),
      ],
    );
    return listView;
  }

  String getString() {
    String thisString = "Your Television";
    return thisString;
  }
}
