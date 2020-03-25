import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DeviceDetails extends StatefulWidget {
  //final DeviceList device;
  final DocumentSnapshot getDevice;
  //DeviceDetails({Key key, this.device}) : super(key: key);
  DeviceDetails({this.getDevice});

  @override
  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  bool openSecondtime = false;
  String state;
  TimeOfDay startTime = new TimeOfDay.now();
  TimeOfDay endTime = new TimeOfDay.now();
  TimeOfDay nowTime = new TimeOfDay.now();

  final db = Firestore.instance;

  createAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure you want to delete this device?"),
          actions: <Widget>[
            MaterialButton(
                child: Text("Okay"),
                onPressed: () {
                  deleteData(widget.getDevice);
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  selectDeviceState(BuildContext context) {
    state = widget.getDevice.data["status"];
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioListTile<String>(
                    title: const Text('on'),
                    value: "on",
                    groupValue: state,
                    onChanged: (String value) {
                      setState(() {
                        state = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('off'),
                    value: "off",
                    groupValue: state,
                    onChanged: (String value) {
                      setState(() {
                        state = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('standby'),
                    value: "standby",
                    groupValue: state,
                    onChanged: (String value) {
                      setState(() {
                        state = value;
                      });
                    },
                  ),
                  new SizedBox(
                    height: 10,
                  ),
                  new Padding(
                    padding: EdgeInsets.all(20),
                    child: new RaisedButton(
                        child: new Text('Change State'),
                        onPressed: () {
                          updateDeviceState(widget.getDevice, state);
                          Navigator.pop(context);
                        }),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  DateTime timeofDayTODateTime(TimeOfDay t) {
    final now = new DateTime.now();
    return new DateTime(now.year, now.month, now.day, t.hour, t.minute);
  }

  Future<Null> selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );

    if (picked != null) {
      setState(() {
        startTime = picked;
        openSecondtime = true;
      });
      selectEndTime(context);
    }
  }

  Future<Null> selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );

    if (picked != null) {
      setState(() {
        endTime = picked;
      });
      if (openSecondtime == true) {
        confirmTimeDialog(context);
      }
    }
  }

  confirmTimeDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Turn off device between these times?\n\n" +
              "Start Time: " +
              formatTimeOfDay(startTime) +
              "\n"
                  "End Time: " +
              formatTimeOfDay(endTime)),
          actions: <Widget>[
            MaterialButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                }),
            MaterialButton(
                child: Text("Okay"),
                onPressed: () {
                  updateTimeRange(widget.getDevice, startTime.toString(),
                      endTime.toString());
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  void showMessage() {
    Fluttertoast.showToast(
        msg: "Added Device to your List",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red[50],
        textColor: Colors.black12,
        fontSize: 22.0);
  }

  void compareTime() {
    String s = widget.getDevice.data['startTime'];
    String e = widget.getDevice.data['endTime'];
    startTime = TimeOfDay(
        hour: int.parse(s.split("TimeOfDay(")[1].split(":")[0]),
        minute: int.parse(s.split(":")[1].split(")")[0]));
    endTime = TimeOfDay(
        hour: int.parse(e.split("TimeOfDay(")[1].split(":")[0]),
        minute: int.parse(e.split(":")[1].split(")")[0]));
    nowTime = new TimeOfDay.now();

    print(startTime);
    print(endTime);
    print(nowTime);

    DateTime getDateS = timeofDayTODateTime(startTime);
    DateTime getDateE = timeofDayTODateTime(endTime);
    DateTime getDateN = timeofDayTODateTime(nowTime);

    print(getDateS);
    print(getDateE);
    print(getDateN);

    if (getDateN.isAfter(getDateS) && getDateN.isBefore(getDateE)) {
      Fluttertoast.showToast(
          msg: "Device Turned Off",
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[50],
          textColor: Colors.black38,
          fontSize: 22.0);
      updateDeviceState(widget.getDevice, 'off');
    } else {
      Fluttertoast.showToast(
          msg: "Device turned back on",
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[50],
          textColor: Colors.black38,
          fontSize: 22.0);
      updateDeviceState(widget.getDevice, 'on');
    }
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Devices Available').document(doc.documentID).delete();
    Navigator.pop(context);
  }

  void updateDeviceState(DocumentSnapshot doc, String state) async {
    await db
        .collection('Devices Available')
        .document(doc.documentID)
        .updateData({'status': state});
    Navigator.pop(context);
  }

  void updateTimeRange(DocumentSnapshot doc, String start, String end) async {
    await db
        .collection('Devices Available')
        .document(doc.documentID)
        .updateData({'startTime': start, 'endTime': end});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    state = widget.getDevice.data["status"];
    Text text;
    if (widget.getDevice.data["status"] == "on") {
      text = new Text(
        state,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
      );
    } else if (widget.getDevice.data["status"] == "standby") {
      text = new Text(
        state,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.yellow[400]),
      );
    } else if (widget.getDevice.data["status"] == "off") {
      text = new Text(
        state,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
      );
    }

    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text("Device Details"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.power_settings_new, color: Colors.white),
            label: Text(
              'Set State',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              selectDeviceState(context);
            },
          ),
        ],
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
                widget.getDevice.data['deviceName'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              new Text(
                "ID: " + widget.getDevice.data['deviceId'].toString(),
                style: TextStyle(
                  fontSize: 15,
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
                      trailing: text,
                    ),
                    ListTile(
                      title: Text("Voltage"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        widget.getDevice.data["voltage"] + " V",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text("Current"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        widget.getDevice.data["current"] + " A",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text("Power"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        widget.getDevice.data["power"] + " W",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text("Energy Savings"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        widget.getDevice.data["energySavings"] + " W",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text("Trees saved"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        widget.getDevice.data["treesSaved"],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Total Savings",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        r"$ " + widget.getDevice.data["totalSavings"],
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.all(5),
                    child: new RaisedButton.icon(
                      icon: new Icon(
                        Icons.delete_outline,
                        color: Colors.black,
                      ),
                      color: Colors.red,
                      label: new Text('Delete'),
                      onPressed: () {
                        createAlertDialog(context);
                      },
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(5),
                    child: new RaisedButton.icon(
                        icon: new Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                        color: Colors.green,
                        label: new Text(
                          'Set Time',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          selectStartTime(context);
                        }),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(5),
                    child: new RaisedButton.icon(
                      icon: new Icon(
                          Icons.power_settings_new,
                          color: Colors.black,
                        ),
                        color: Colors.yellowAccent,
                        label: new Text('Check Device',
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          String s = widget.getDevice.data['startTime'];
                          String e = widget.getDevice.data['endTime'];
                          startTime = TimeOfDay(
                              hour: int.parse(
                                  s.split("TimeOfDay(")[1].split(":")[0]),
                              minute: int.parse(s.split(":")[1].split(")")[0]));
                          endTime = TimeOfDay(
                              hour: int.parse(
                                  e.split("TimeOfDay(")[1].split(":")[0]),
                              minute: int.parse(e.split(":")[1].split(")")[0]));
                          compareTime();
                          Fluttertoast.showToast(
                              msg:
                                  "Set the State of the device depending on the set time\n" +
                                      formatTimeOfDay(startTime) +
                                      " - " +
                                      formatTimeOfDay(endTime),
                              gravity: ToastGravity.CENTER,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.red[50],
                              textColor: Colors.black38,
                              fontSize: 15.0);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
