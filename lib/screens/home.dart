import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>>? _data;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _loadDataFromJson() async {
    try {
      String jsonData = await rootBundle.loadString('assets/data.json');
      setState(() {
        _data = List<Map<String, dynamic>>.from(json.decode(jsonData));
      });
    } catch (e) {
      Exception("Error loading data: ${e.toString()}");
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
        child: _data == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  itemCount: _data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ProfilePopup.show(context);
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
                            leading: Image.asset(_data![index]['profile_img']),
                            title: Row(
                              children: [
                                Text(
                                  "${_data![index]['name']}, ${_data![index]['age']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                if (_data![index]['badge'] != null &&
                                    _data![index]['badge'] != '')
                                  SvgPicture.asset(_data![index]['badge'])
                              ],
                            ),
                            subtitle: Text(
                              _data![index]['status'] ?? '',
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
