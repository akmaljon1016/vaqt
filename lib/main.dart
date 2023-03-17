import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaqt/Vaqt.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  DateTime now = DateTime.now();
  Dio dio = Dio();
  late Future<Vaqt> vaqt;

  @override
  void initState() {
    vaqt = getVaqt();
    super.initState();
  }

  Future<Vaqt> getVaqt() async {
    var response = await dio.get(
        "https://api.aladhan.com/v1/timingsByAddress/${dateFormat.format(now)}?address=Fergana");
    return Vaqt.fromJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: vaqt,
          builder: (BuildContext context, AsyncSnapshot<Vaqt> snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Bomdod:",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data!.data!.timings!.fajr.toString(),
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 60,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Peshin:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(snapshot.data!.data!.timings!.dhuhr.toString(),
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 60,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Asr:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(snapshot.data!.data!.timings!.asr.toString(),
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 60,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "shom:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(snapshot.data!.data!.timings!.maghrib.toString(),
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 60,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Xufton:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(snapshot.data!.data!.timings!.isha.toString(),
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
