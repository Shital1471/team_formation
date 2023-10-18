import 'package:flutter/material.dart';

class SeenData extends StatefulWidget {
  List<Map<String, dynamic>> jsonData = [];
  String Domine;
  SeenData({super.key, required this.jsonData,required this.Domine});

  @override
  State<SeenData> createState() => _SeenDataState();
}

class _SeenDataState extends State<SeenData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
         "${ widget.Domine} group",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black
          ),
        ),
      ),
      body: widget.jsonData.isEmpty?Center(child: Text("No team"),): Container(
              margin: EdgeInsets.all(10),
              child: widget.jsonData.isNotEmpty
                  ? ListView.builder(
                      itemCount: widget.jsonData.length,
                      itemBuilder: (context, index) {
                        final item = widget.jsonData[index];
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
                                trailing:
                                    Text(
                                      item['domain']=="Business Development"?"BD":item['domain'],
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black45),
                                    ),
                                  
                                )),
                          
                        );
                      })
                  : Center(child: CircularProgressIndicator()),
            ),
          
    );
  }
}
