import 'package:flutter/material.dart';
import 'package:test_app1/HomeBarPages/deviceDetails.dart';
import 'package:test_app1/model/devices.dart';

class HomeDevices extends StatefulWidget {
  @override
  _HomeDevicesState createState() => _HomeDevicesState();
}

class _HomeDevicesState extends State<HomeDevices> {
  final List<DeviceList> getDevices = DeviceList.getDeviceList();

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
              new Text(
                "Device List",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              new Expanded(
                child: ListView.builder(
                  itemCount: getDevices.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      color: Colors.white30,
                      shape: new RoundedRectangleBorder(
                        side: new BorderSide(
                            color: Colors.greenAccent, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: new ListTile(
                        leading: (getDevices[index].status == true)
                            ? Icon(Icons.done_outline,
                                color: Colors.green, size: 30)
                            : Icon(Icons.block, color: Colors.red, size: 30),
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
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}