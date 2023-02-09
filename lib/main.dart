import 'package:flutter/material.dart';
import 'package:pr_4_3/screens/people.dart';
import 'helper/people_api.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home(),
    ),
  );
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

TextStyle style = TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis);

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          backgroundColor: Colors.grey,
      appBar: AppBar(
          backgroundColor: Colors.white54 ,
          title:
      Text("Rendom People API",style: TextStyle
        (fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black,),
      ),
          centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              // height: _height * 0.8,
              // width: _width,
              height: 550,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white54),
              child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error is :${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      People? data = snapshot.data ;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "  Name : ${data!.title}.${data!.first} ${data.last}\n",
                                          style: style),
                                      Text(
                                          "  DOB : ${data!.date!.split("T")[0]}",
                                          style: style),
                                      Text("\n  Age :  ${data!.age}\n",
                                          style: style),
                                    ],
                                  )),
                              Expanded(
                                  child: Image.network(
                                    "${data!.photo}",
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(width: 10),
                            ],
                          ),
                          Text("  Gender :  ${data!.gender}", style: style),
                          Text("\n  Email ID :  ${data!.email}", style: style),
                          SelectableText("\n  Phone Number:  ${data!.phone}",
                              style: style),
                          Text("\n  City:  ${data!.city}", style: style),
                          Text("\n  State:  ${data!.state}", style: style),
                          Text("\n  Country:  ${data!.country}", style: style),
                        ],
                      );
                    }
                    return CircularProgressIndicator(
                      color: Colors.red,
                    );
                  },
                  future: PeopleAPIHelper.peopleAPIHelper
                      .fectdata(API: "https://randomuser.me/api/")),
            ),
          ),
          SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white54),
                  onPressed: () {
                    setState(() {
                      PeopleAPIHelper.peopleAPIHelper
                          .fectdata(API: "https://randomuser.me/api/");
                    });
                  },
                  child: Text("Next",style: TextStyle(fontSize: 25,color: Colors.black,),))),
        ],
      ),
    );
  }
}