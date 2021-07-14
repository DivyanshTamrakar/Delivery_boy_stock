import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/Login_otp_Screen.dart';
import '../utils/HttpResponse.dart';
import '../utils/colors.dart';
import '../widgets/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<LoginScreen> {
  TextEditingController _controller = new TextEditingController();

  // check() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print("user token ========  ${prefs.getString("token")}");
  //   var userToken = prefs.getString("token");
  //   if (userToken != null) {
  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (BuildContext context) => BottomBarExample()));
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // check();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: InkWell(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset('assets/mobile.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center),
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.grey.withOpacity(0.1),
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 4.5),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 2.2,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[],
                      )),
                 ],
              ),
              Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Delivery",
                              style: TextStyle(
                                  fontSize: 45, color: Colors.orange,fontWeight: FontWeight.bold)
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/30 ,
                          ),
                          Text("Agent",
                              style: TextStyle(
                                  fontSize: 45,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold))
                        ]),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/profile_placeholder.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: width,
                    child: Text(
                      "To continue,enter your phone Number",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 1,
                    endIndent: 50,
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: new InputDecoration(
                            counterText: "",
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(30.0),
                              ),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.zero,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "Enter Phone Number",
                            prefixIcon: Icon(Icons.call,
                                color: Color.fromRGBO(223, 143, 96, 1.0)),
                            fillColor: primary_text_color),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 1,
                    indent: width * 0.1,
                    endIndent: width * 0.1,
                  ),
                  SizedBox(height: 10),
                  Material(
                    color: Colors.transparent,
                    // elevation: 5,
                    borderRadius: BorderRadius.circular(20.0),
                    child: InkWell(
                      onTap: () async {
                        print(_controller.text);
                        if (_controller.text.length == 10)
                          try {
                            Map data = {
                              "contact": _controller.text.toString()
                            };
                            var resp = await HttpResponse.postResponse(
                                service: '/users/send-otp', data: data);
                            print("\n\n$resp\n\n");
                            print(data);
                            var response = jsonDecode(resp);
                            print("\n\n${response.toString()}\n\n");
                            if (response['status'] == '403') {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return oneButtonDialog(
                                        context: context,
                                        title: "Contact Not Registered",
                                        content: response['error'],
                                        actionTitle: "OK");
                                  });
                            } else {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('contact', _controller.text);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          OTPScreenAfterLogin(
                                              contact: _controller.text)));
                            }
                          } catch (e) {
                            print("Error : $e");
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return oneButtonDialog(
                                      context: context,
                                      title: "Error",
                                      content: "$e",
                                      actionTitle: "OK");
                                });
                          }
                        else
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return oneButtonDialog(
                                    context: context,
                                    title: "Invalid Number",
                                    content:
                                        "Please enter a valid 10 digit mobile number",
                                    actionTitle: "OK");
                              });

                      },
                      child: Container(
                        // width: width * 0.8,
                        margin: EdgeInsets.symmetric(horizontal: 80.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(67, 88, 185, 1.0),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Sign In',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: button_text_color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.check_circle_outline_sharp,
                              color: button_icon_color,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
