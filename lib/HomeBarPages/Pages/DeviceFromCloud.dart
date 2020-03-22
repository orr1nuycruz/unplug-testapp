import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:test_app1/model/cloudDevicesModel.dart';
import 'NextPage/cloudDetails.dart';

class DevicesFromCloud extends StatefulWidget {
  @override
  _DevicesFromCloudState createState() => _DevicesFromCloudState();
}

class _DevicesFromCloudState extends State<DevicesFromCloud> {
  List<List<dynamic>> data = [];
  List<DevicefromCloud> newList = [];

  void LoadAsset() async {
    final myData = await rootBundle.loadString("assets/unplugsampledata.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    data = csvTable;
    setState(() {
      for (int i = 0; i < csvTable.length; i++) {
        newList.add(new DevicefromCloud(
            csvTable[i][2].toString(),
            csvTable[i][3].toString(),
            csvTable[i][4].toString(),
            csvTable[i][5].toString(),
            csvTable[i][6].toString(),
            csvTable[i][7].toString(),
            csvTable[i][8].toString(),
            csvTable[i][9].toString(),
            csvTable[i][10].toString(),
            csvTable[i][11].toString()));
        print(newList[i].applianceType + " " + newList[i].power + "W");
      }
    });
  }

  void clearList() {
    setState(() {
      newList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                LoadAsset();
              },
              icon: Icon(Icons.refresh),
              label: Text('Refresh'))
        ],
        title: Text("Find Devices"),
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text(
                "Devices Available",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              new Expanded(
                child: ListView.builder(
                  itemCount: newList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120.0,
                        child: Card(
                          color: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                              left: 40.0,
                            ),
                            child: new ListTile(
                              title: Text(
                                newList[index].applianceType,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              subtitle: Text(newList[index].power + " W",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              onTap: () {
                                debugPrint(
                                    "${newList.elementAt(index).applianceType}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CloudDeviceDetails(
                                      device: newList[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
