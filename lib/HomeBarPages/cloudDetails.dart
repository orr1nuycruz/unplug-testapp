import 'package:flutter/material.dart';
import 'package:test_app1/model/cloudDevicesModel.dart';

class CloudDeviceDetails extends StatelessWidget {
  final DevicefromCloud device;

  const CloudDeviceDetails({Key key, this.device}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("The Cloud"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: Center(
          child: new Column(
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.cloud, color: Colors.green),
                iconSize: 60,
                onPressed: () {
                  Navigator.of(context).pushNamed("/");
                },
              ),
              new Text(
                device.applianceType,
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
                      title: Text("Status"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        "${device.state.toString()}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text("Energy Consumption"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text("${device.power.toString()} W"),
                    ),
                    ListTile(
                      title: Text("Energy Savings"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text("${device.energySavings.toString()} W"),
                    ),
                    ListTile(
                      title: Text("CO2e saved"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text("${device.treesSaved.toString()} CO2e"),
                    ),
                    ListTile(
                      title: Text(
                        "Total Savings",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        r"$ " + device.dollarSavings.toString(),
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
