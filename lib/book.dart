import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:train_app/train.dart';

class Ticket extends StatefulWidget {
  Train t1;

  Ticket(this.t1);

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void validate(){
    if(formkey.currentState!.validate()){
      print("Successful");
    }
    else
      print("Unsuccessful");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          title: Center(child: Text('DETAILS'))
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(16),
                height: 240,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('ENTER PERSON DETAILS',style: TextStyle(fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter your username",
                                labelText: " Username",
                                prefixIcon: Icon(Icons.person_add_alt_1),

                              ),
                              keyboardType: TextInputType.name,
                              validator: (val){
                                if(val!.length<5){
                                  return "Enter at least 5 characters";
                                }else{
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "+91 Enter number here",
                                labelText: " Phone Number",
                                prefixIcon: Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (val){
                                if(val!.length != 10){
                                  return "Invalid Phone number";
                                }else{
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('TRAIN DETAILS',style: TextStyle(fontSize: 30),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Train Name : ${widget.t1.name}",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Text(
                    "Coach Type : ${widget.t1.classType}",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Train Number :${widget.t1.pnr}",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  Text(
                    "Price of one ticket : ₹1500",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                child: Text(
                  "CONFIRM TICKET",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Ticket Confirmed"),
                  ));
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
