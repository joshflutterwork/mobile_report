import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keluarga_bintoro/ui/widgets/widgets.dart';

class AbsensiPage extends StatefulWidget {
  @override
  _AbsensiPageState createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  bool isProcessing = false;
  final String url =
      "http://api.fingerspot.io/api/download/attendance_log/C2692480532A1921/2021-02-23/14/date_time/asc/json/73e62e9f8e4fef9d05907aaf26d0d472/20210223114444";
  Future _fecthData() async {
    var result = await http.get(Uri.parse(url));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: _fecthData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Text(snapshot.data['data'][index]['PIN']),
                        Text(snapshot.data['data'][index]['Name']),
                        Text(snapshot.data['data'][index]['Date Time']),
                        lineCutObject()
                      ],
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            }),
      ),
    );
  }
}
