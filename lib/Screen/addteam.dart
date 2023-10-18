import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_formation/Screen/seencreatedata.dart';

class AddTeam extends StatefulWidget {
  const AddTeam({super.key});

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  List<bool> cardTappedStates = [];
  
  String? selectedDomain;
  String? gendervalue;
  bool? AvailableValue;
  List<Map<String, dynamic>> jsonData = [];
  List<Map<String, dynamic>> filteredData = [];
  List<Map<String, dynamic>> addfilterData = [];

  List<String> uniqueDomains = [];
  List<String> uniquegender = [];
  List<bool> awaitables = [];

  Map<String, List<String>> filters = {
    'domain': [],
  };

  void initState() {
    super.initState();
    _loadData();
    if (uniqueDomains.isNotEmpty) {
      selectedDomain = uniqueDomains[0]; // Set the initial value
    }
    if (awaitables.isNotEmpty) {
      AvailableValue = awaitables[0]; // Set the initial value
    }
    if (uniquegender.isNotEmpty) {
      gendervalue = uniquegender[0];
    }
  }

  Future<void> _loadData() async {
    try {
      String fileContent = await rootBundle.loadString('dataset.txt');
      // log("file: ${fileContent}");
      List<dynamic> parsedJson = json.decode(fileContent);
      jsonData = List<Map<String, dynamic>>.from(parsedJson);

      // log("json data: ${jsonEncode(jsonData)}");
      uniqueDomains = _getUniqueDomains(jsonData);
      log("${uniqueDomains}");
      awaitables = _getAvailable(jsonData);
      log("Available : ${awaitables}");
      uniquegender = _getGender(jsonData);
      log("Gender: ${uniquegender}");
    } catch (e) {
      print("Error loading or parsing data: $e");
    }
    setState(() {});
  }

  void filterData(String domaines, String values, bool query) {
    log("${domaines} + ${values} + ${query}");
    filteredData = jsonData.where((item) {
      final domains = item['domain']?.toString().toLowerCase() ?? "";
      final genders = item['gender']?.toString().toLowerCase() ?? "";
      final availabled = item['available'];

      // final gender = item['gender']?.toString().toLowerCase() ?? "";

      return (domains.isEmpty || domains.contains(domaines.toLowerCase())) &&
          (genders.isEmpty || genders.contains(values.toLowerCase())) &&
          (availabled.toString().isEmpty ||
              availabled.toString().contains(query.toString()));
    }).toList();
    // log("lengtg: ${filteredData}");
    setState(() {
      cardTappedStates = List.generate(filteredData.length, (index) => false);
    });
  }

  List<String> _getUniqueDomains(List<Map<String, dynamic>> data) {
    Set<String> domains = Set<String>();
    for (var item in data) {
      if (item['domain'] != null) {
        domains.add(item['domain']);
      }
    }
    return domains.toList();
  }

  List<String> _getGender(List<Map<String, dynamic>> data) {
    Set<String> genders = Set<String>();
    for (var item in data) {
      if (item['gender'] != null) {
        genders.add(item['gender']);
      }
    }
    return genders.toList();
  }
  // Future<void> _getfilterdata(List<Map<String,dynamic>> data){

  // }
  List<bool> _getAvailable(List<Map<String, dynamic>> data) {
    Set<bool> Availables = Set<bool>();
    for (var item in data) {
      if (item['available'] != null) {
        Availables.add(item['available']);
      }
    }
    return Availables.toList();
  }

  // List domains=["Sales", "Finance", "Marketing", "IT", "Management"," UI Designing", "Business Development"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecting Users"),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          addfilterData.clear();
          // log("card : ${cardTappedStates}");
          for (int i = 0; i < cardTappedStates.length; i++) {
            if (cardTappedStates[i] == true) {
              addfilterData.add(filteredData[i]);
            }
          }
          log("add data : ${addfilterData}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SeenData(
                        jsonData: addfilterData,
                        Domine: selectedDomain!,
                      )));
        },
        child: Image.asset('Images/team.png'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Center(
              child: Text(
            ' Selecting Users ',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              child: DropdownButton(
                hint: Text(' Select the Domain'),
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                style: TextStyle(color: Colors.black, fontSize: 22),
                underline: SizedBox(),
                value: selectedDomain, // Set the selected value
                onChanged: (value) {
                  setState(() {
                    selectedDomain = value;

                    // Update the selected domain
                  });
                },
                items: uniqueDomains.map((valueIteam) {
                  return DropdownMenuItem(
                    value: valueIteam,
                    child: Text(" ${valueIteam}"),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              child: DropdownButton(
                hint: Text(' Select the Gender'),
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                style: TextStyle(color: Colors.black, fontSize: 22),
                underline: SizedBox(),
                value: gendervalue, // Set the selected value
                onChanged: (value) {
                  setState(() {
                    gendervalue = value;

                    // Update the selected domain
                  });
                },
                items: uniquegender.map((valueIteam) {
                  return DropdownMenuItem(
                    value: valueIteam,
                    child: Text(" ${valueIteam}"),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              child: DropdownButton(
                hint: Text(' Select the available'),
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                style: TextStyle(color: Colors.black, fontSize: 22),
                underline: SizedBox(),
                value: AvailableValue, // Set the selected value
                onChanged: (value) {
                  setState(() {
                    AvailableValue = value;
                    // filters['domain']?.add(value!);

                    // Update the selected domain
                  });
                },
                items: awaitables.map((valueIteam) {
                  return DropdownMenuItem(
                    value: valueIteam,
                    child: Text(" ${valueIteam}"),
                  );
                }).toList(),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                log("${selectedDomain} + ${gendervalue} + ${AvailableValue}");
                filterData(
                    selectedDomain!,
                    gendervalue == null ? " " : gendervalue!,
                    AvailableValue == null ? false : AvailableValue!);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: Text(
                'Show User',
                style: TextStyle(fontSize: 15, color: Colors.black),
              )),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: filteredData.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final item = filteredData[index];
                        return InkWell(
                          onTap: () {},
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
                                      fontSize: 25, color: Colors.black),
                                ),
                                subtitle: Text(
                                  item['email'],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black45),
                                ),
                                trailing: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          cardTappedStates[index] =
                                              !cardTappedStates[index];
                                        });
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: cardTappedStates[index] == true
                                              ? Colors.greenAccent
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                       item['domain']=="Business Development"?"BD":item['domain'],
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black45),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      })
                  : Center(child: CircularProgressIndicator()),
            ),
          )
        ]),
      ),
    );
  }
}
