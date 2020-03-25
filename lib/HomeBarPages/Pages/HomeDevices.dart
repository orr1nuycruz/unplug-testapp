import 'package:flutter/material.dart';
import 'package:test_app1/model/devices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'NextPage/deviceDetails.dart';

class HomeDevices extends StatefulWidget {
  @override
  _HomeDevicesState createState() => _HomeDevicesState();
}

class _HomeDevicesState extends State<HomeDevices> {
  final List<DeviceList> getDevices = DeviceList.getDeviceList();
  final db = Firestore.instance;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn =
        await firestore.collection("Devices Available").getDocuments();
    return qn.documents;
  }

  void updateDeviceState(AsyncSnapshot<dynamic> doc) async {
    await db
        .collection('Devices Available')
        .document(doc.data['documentID'])
        .updateData({'status': 'off'});
    Navigator.pop(context);
  }

  getDetails(DocumentSnapshot item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DeviceDetails(getDevice: item)));
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    TimeOfDay getStartTime;
    TimeOfDay getEndTime;
    TimeOfDay todaysTime;

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
                child: FutureBuilder(
                    future: getPosts(),
                    builder: (BuildContext _, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return new Text("Loading...");
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext _, int index) {
                              Icon icon;
                              if (snapshot.data[index].data['status'] == 'on') {
                                icon = new Icon(Icons.power_settings_new,
                                    color: Colors.green, size: 50);
                              } else if (snapshot.data[index].data['status'] ==
                                  'off') {
                                icon = new Icon(Icons.block,
                                    color: Colors.red, size: 50);
                              } else if (snapshot.data[index].data['status'] ==
                                  'standby') {
                                icon = new Icon(Icons.power_settings_new,
                                    color: Colors.yellowAccent, size: 50);
                              }
                              return Card(
                                elevation: 5,
                                color: Colors.white30,
                                shape: new RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Colors.greenAccent, width: 2.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: new ListTile(
                                  leading: icon,
                                  title: Text(
                                    snapshot.data[index].data['deviceName'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    snapshot.data[index].data['power'] +
                                        " W (" +
                                        snapshot.data[index].data['status'] +
                                        ")",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  onTap: () => getDetails(snapshot.data[index]),
                                ),
                              );
                            });
                      }
                    }),
              ),

              // new Expanded(
              //   child: ListView.builder(
              //     itemCount: getDevices.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Card(
              //         elevation: 5,
              //         color: Colors.white30,
              //         shape: new RoundedRectangleBorder(
              //           side: new BorderSide(
              //               color: Colors.greenAccent, width: 2.0),
              //           borderRadius: BorderRadius.circular(20.0),
              //         ),
              //         child: new ListTile(
              //           leading: (getDevices[index].status == true)
              //               ? Icon(Icons.done_outline,
              //                   color: Colors.green, size: 30)
              //               : Icon(Icons.block, color: Colors.red, size: 30),
              //           title: Text(
              //             getDevices[index].name,
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 25),
              //           ),
              //           subtitle: Text(getDevices[index].deviceType),
              //           onTap: () {
              //             debugPrint("${getDevices.elementAt(index).name}");
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => DeviceDetails(
              //                   device: getDevices[index],
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
