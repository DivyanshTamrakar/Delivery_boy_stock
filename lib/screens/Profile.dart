import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "", contact = "", profile = "";

  getUserData() async {
    // var resp = await HttpResponse.getResponse(
    //   service: '/users/profile',
    // );
    // print("\n\n$resp\n\n");
    //
    // var response = jsonDecode(resp);
    // print("\n\n${response.toString()}\n\n");
    //
    // setState(() {
    //   name = response['data']['name'].toString();
    //   contact = response['data']['contact'].toString();
    //   profile = response['data']['profile'].toString();
    // });
  }

  @override
  void initState() {

    super.initState();
    // getUserData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 0.5 * height,
                width: width,
                color: Color.fromRGBO(67, 88, 185, 1.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: profile == "null"
                            ? Image.asset(
                          "assets/profile_placeholder.png",
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      name == "" ? "Your Name" : name.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: button_text_color,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      contact == "" ? "Mobile No" : contact.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: button_text_color,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 5,
                child: InkWell(
                  onTap: (){
                  },
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Color.fromRGBO(67, 88, 185, 1.0)),
                    title: Text(
                      "Log out",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}