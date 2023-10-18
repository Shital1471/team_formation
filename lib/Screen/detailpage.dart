import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String? firstname = "";
  String? lastname = "";
  String? email = "";
  String? gender = "";
  String? domain = "";
  bool? Available;
  String? img = "";
  DetailScreen({super.key ,required this.firstname,required this.lastname,required this.email,required this.gender,required this.domain,required this.Available,required this.img});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Details'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(70),
                    image: DecorationImage(image: NetworkImage(widget.img!),fit: BoxFit.cover)
                    ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Name :  ${widget.firstname} ${widget.lastname}',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      'Email : ${widget.email}',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      'Gender : ${widget.gender}',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      'Domain : ${widget.domain}',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      'Available : ${widget.Available}',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
