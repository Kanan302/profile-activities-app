import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>>? data;
  List<String>? reasons;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _loadDataFromJson() async {
    try {
      String jsonData = await rootBundle.loadString('assets/data/data.json');
      Map<String, dynamic> parsedData = json.decode(jsonData);
      setState(() {
        data = List<Map<String, dynamic>>.from(parsedData['users']);
        reasons = List<String>.from(parsedData['reasons']);
      });
    } catch (e) {
      print("Error loading data: ${e.toString()}"); // Print error message
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDataFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: data == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ProfileInfo.show(context, reasons, data!, index); // Pass data and index to ProfileInfo.show
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Image.asset(data![index]['profile_img']),
                            title: Row(
                              children: [
                                Text(
                                  "${data![index]['name']}, ${data![index]['age']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                if (data![index]['badge'] != null &&
                                    data![index]['badge'] != '')
                                  SvgPicture.asset(data![index]['badge'])
                              ],
                            ),
                            subtitle: Text(
                              data![index]['status'] ?? '',
                              style: const TextStyle(color: Color(0xFF919191)),
                            ),
                            trailing: SvgPicture.asset(
                                'assets/images/svg/comment.svg'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}