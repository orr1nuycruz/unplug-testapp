import 'package:flutter/material.dart';
import 'package:test_app1/model/devices.dart';

class DeviceDetails extends StatelessWidget {
  final DeviceList device;

  const DeviceDetails({Key key, this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Device Details"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: Center(
          child: new Column(
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.adb, color: Colors.green),
                iconSize: 60,
                onPressed: () {
                  Navigator.of(context).pushNamed("/");
                },
              ),
              new Text(
                device.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              new Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        "Statistics",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    ),
                    ListTile(
                      title: Text("Energy Consumption"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text("${device.kwhConsumption.toString()} kWh"),
                    ),
                    ListTile(
                      title: Text("kWh Saved"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text("${device.kwhSaved.toString()} kWh"),
                    ),
                    ListTile(
                      title: Text("CO2e saved"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text("${device.c02eSaved.toString()} CO2e"),
                    ),
                    ListTile(
                      title: Text(
                        "Total Savings",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        r"$ " + device.savings.toString(),
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
