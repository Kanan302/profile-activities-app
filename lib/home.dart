import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>>? _data;

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
      body: SafeArea(
        child: _data == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  itemCount: _data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
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
                          leading: Image.asset(_data![index]['leading']),
                          title: Text(
                            _data![index]['title'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            _data![index]['subtitle'] ?? '',
                            style: const TextStyle(color: Color(0xFF919191)),
                          ),
                          trailing:
                              const Icon(Icons.messenger_outline_outlined),
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
