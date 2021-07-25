import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:train_app/train.dart';

import 'book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Train Booking'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<String> from = ["Mumbai", "Delhi", "Chennai", "Kolkata"];
  static final List<String> to = ["Mumbai", "Delhi", "Chennai", "Kolkata"];
  String choice1 = from[0];
  String choice2 = to[2];
  int flag = 0;

  List<Train> trainList = [
    Train(name: 'Rajdhani Express', classType: 'Sitting', pnr: '120020', key: 1), //Mum to Delhi
    Train(name: 'Chennai Express', classType: 'AC', pnr: '130120', key: 2), //Mum to Chennai
    Train(name: 'Ramaswamy Express', classType: 'AC', pnr: '156980', key: 2), //Chennai to Mum
    Train(name: 'Howrah Express', classType: 'AC', pnr: '230020', key: 3), //Mum to Kolkata
    Train(name: 'Lokmanya Tilak Express', classType: 'Sleeping', pnr: '225020', key: 3), //Kolkata to Mum
    Train(name: 'Chinnaswamy Express', classType: 'AC /Sleeping', pnr: '123028', key: 4), //D to C
    Train(name: 'Gazabrath Express', classType: 'N/AC /Sitting', pnr: '125113', key: 4), //C to D
    Train(name: 'Capital Express', classType: 'Sitting', pnr: '120673', key: 5), //D to K
    Train(name: 'Malabar Express', classType: 'Sleeping', pnr: '120456', key: 6), //C to K
    Train(name: 'East Coast Express', classType: 'AC / Sleeping', pnr: '123456', key: 6), //K to C
  ];


  List<Train> trainAvail = [];


  int check() {
    if (choice1 == choice2) flag = 0;
    if (choice1 == from[0] && choice2 == to[1] ||
        choice1 == from[1] && choice2 == to[0]) //M-D
      flag = 1;
    else if (choice1 == from[0] && choice2 == to[2] ||
        choice1 == from[2] && choice2 == to[0]) //M-C
      flag = 2;
    else if (choice1 == from[0] && choice2 == to[3] ||
        choice1 == from[3] && choice2 == to[0]) //M-K
      flag = 3;
    else if (choice1 == from[1] && choice2 == to[2] ||
        choice1 == from[2] && choice2 == to[1]) //D-C
      flag = 4;
    else if (choice1 == from[1] && choice2 == to[3] ||
        choice1 == from[3] && choice2 == to[1]) //D-K
      flag = 5;
    else if (choice1 == from[3] && choice2 == to[2] ||
        choice1 == from[2] && choice2 == to[3]) //C-K
      flag = 6;
    return flag;
  }
  String tempName = '';


  Train trainDetails(String trainName){
    for(int i = 0 ; i<trainAvail.length ; i++){
      if(trainAvail[i].name == trainName){
        return Train(name: trainAvail[i].name, classType: trainAvail[i].classType, pnr: trainAvail[i].pnr, key: trainAvail[i].key);
      }
    }
    return Train(name: '', classType: '',pnr: '',key: 0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'STARTING POINT',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('       '),
                  Text(
                    'ENDING POINT',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: DropdownButton<String>(
                          value: choice1,
                          items: from
                              .map((item) => DropdownMenuItem<String>(
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    value: item,
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            this.choice1 = value!;
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: DropdownButton<String>(
                          value: choice2,
                          items: from
                              .map((item) => DropdownMenuItem<String>(
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    value: item,
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            this.choice2 = value!;
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton.icon(
                  label: Text('Check Availability'),
                  elevation: 10,
                  onPressed: () {
                    setState(() {
                      int x = check();

                      trainAvail.clear();
                      for(int i = 0 ; i<trainList.length ; i++){
                        if (x == trainList[i].key){
                          trainAvail.add(trainList[i]);

                        }
                    }
                    });
                  },
                  icon: Icon(Icons.train_outlined),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height : 230,
                          width: 290,
                          color: Colors.grey,
                          child: ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => Divider(thickness: 18,height: 30,color: Colors.blueGrey,),
                            itemCount: trainAvail.length,
                            itemBuilder: (context,int index){
                              if(choice1 != choice2) {
                                return Card(
                                  color:  Colors.transparent,
                                  child: ListTile(
                                    onTap:(){
                                     tempName = trainAvail[index].name;
                                    },
                                    leading: Text(trainAvail[index].pnr,style: TextStyle(fontSize: 20,color: Colors.red),),
                                    title: Text(trainAvail[index].name,style: TextStyle(fontSize: 25),),
                                    subtitle: Text(trainAvail[index].classType,style: TextStyle(fontSize: 20,color: Colors.white),),
                                  ),
                                );
                              }
                              else{
                                  return Text('No Trains Available');
                                }
                              // else{
                              //   return Text("");
                              // }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return Ticket(trainDetails(tempName));
                    }));
              },
                child: Text("BOOK TICKET",style: TextStyle(color: Colors.black,fontSize: 20),),
            )

          ],
        ),
      ),
    );
  }
}
