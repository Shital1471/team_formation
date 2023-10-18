import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:team_formation/Screen/addteam.dart';
import 'package:team_formation/Screen/detailpage.dart';
import 'package:team_formation/Screen/filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> jsonData = [];
  List<Map<String, dynamic>>  displayedData = [];
  final scrollcontroller = ScrollController();
  List<Map<String, dynamic>> searchData = [];
  int currentPage = 1;
  int itemsPerPage = 10;
  TextEditingController _searchtext = TextEditingController();
  Map<String, List<String>> filters = {
    'domain': [],
    'gender': [],
    'available': [],
  };
  @override
  void initState() {
    super.initState();
    scrollcontroller.addListener(_scrollListener);
    _loadData();
  }

  void _scrollListener() {
    if (scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent) {
     if (itemsPerPage < searchData.length) {
      setState(() {
        itemsPerPage += 10;
      });
    }

      log('call');
    } else {
      log("Scroll Listenr not called");
    }
  }

  Future<void> _loadData() async {
    try {
      String fileContent = await rootBundle.loadString('dataset.txt');
      // log("file: ${fileContent}");
      List<dynamic> parsedJson = json.decode(fileContent);
      jsonData = List<Map<String, dynamic>>.from(parsedJson);
      searchData = jsonData;
      // log("json data: ${jsonEncode(jsonData)}");
    } catch (e) {
      print("Error loading or parsing data: $e");
    }
    setState(() {});
  }

  void filterData() {
      searchData = jsonData.where((item) {
      final domain = item['domain'].toLowerCase();
      final gender = item['gender'].toLowerCase();
      final available = item['available'].toString();

      return filters['domain']!.isEmpty ||
          filters['domain']!.contains(domain) &&
          filters['gender']!.isEmpty ||
          filters['gender']!.contains(gender) &&
          filters['available']!.isEmpty ||
          filters['available']!.contains(available);
    }).toList();
    log('search: ${searchData}');
    setState(() {});
  }

  void fiterData(String query) {
    if (query.isEmpty) {
      searchData = jsonData;
    } else {
      searchData = jsonData.where((item) {
        final name = item['first_name'].toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Team Formation",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddTeam()));
              }),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _searchtext,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 6, 4, 4))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 6, 4, 4))),
                  hintText: 'Search by user in Name....',
                  prefixIcon: Icon(Icons.search)),
              onChanged: (value) {
                fiterData(value);
              },
            ),
            SizedBox(
              height: 10,
            ),
            FilterChips(
            filters: filters,
            onChanged: (value) => filterData(),
          ),
            Expanded(
              child: jsonData.isNotEmpty
                  ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            controller: scrollcontroller,
                            itemCount: itemsPerPage,
                            itemBuilder: (context, index) {
                               if (index >= searchData.length) {
                                    // You can display a loading indicator or message here when all data is loaded.
                                    return null;
                                  }
                              final item = searchData[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DetailScreen(
                                              firstname: item['first_name'],
                                              lastname: item['last_name'],
                                              email: item['email'],
                                              gender: item['gender'],
                                              domain: item['domain'],
                                              Available: item['available'],
                                              img: item['avatar'])));
                                },
                                child: Card(
                                  elevation: 4,
                                  child: ListTile(
                                    leading: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          // border: Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.circular(60),
                                          image: DecorationImage(
                                              image: NetworkImage(item['avatar']),
                                              fit: BoxFit.cover)),
                                    ),
                                    title: Text(
                                      '${item['first_name']} ${item['last_name']}',
                                      style: TextStyle(
                                        letterSpacing: 0,
                                          fontSize: 25, color: Colors.black),
                                    ),
                                    subtitle: Text(
                                      item['email'],
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black45),
                                    ),
                                    trailing: Text(
                                      item['domain']=="Business Development"?"BD":item['domain'],
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black45),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      
                    ],
                  )
                       
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
  
}



