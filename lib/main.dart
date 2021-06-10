import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kalpas_carrers/User_Classes.dart';
import 'package:kalpas_carrers/display_news.dart';
import 'package:kalpas_carrers/signUp.dart';

void main() {
  runApp(
    Home()
  );
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kalpas Inovation",
      routes: {
        '/': (context) => Signin(),
        '/Details': (context) => DisplayNews(),
        '/SignUp': (context) => Signup(),
      },
    );
  }
}

class Signin extends StatelessWidget {
  const Signin({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Stack(
              children: [
                Image.asset("Images/grad2.jpg"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 80, horizontal: 10),
                        child: Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Sign in",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[600]),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                textbox(
                                  icon1: Icons.supervised_user_circle,
                                  hinttext: "Email",
                                ),
                                textbox(
                                  icon1: Icons.verified_user,
                                  hinttext: "Password",
                                ),
                                Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blueAccent),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    print(user_signin.email);
                                    print(user_signin.password);
                                    void authenticate() async {
                                      var url = Uri.parse("https://nodejs-register-login-app.herokuapp.com/login");
                                      print(jsonEncode(user_signin.tojson()));
                                      var response = await http.post(url, body: {"email":"${user_signin.email}","password":"${user_signin.password}"});
                                      var data = json.decode(response.body);
                                      if (data["Success"] == "Success!") {
                                        Navigator.pushNamed(context, '/Details');
                                      } else {
                                        print(data["Success"]);
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data["Success"]}"),));
                                      }
                                    }
                                    authenticate();
                                  },
                                  elevation: 10,
                                  color: Colors.lightBlue,
                                  minWidth: 150,
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "------------------ Or Sign in with ------------------",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
                                      width: 40,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Image.network(
                                      "https://cdn.iconscout.com/icon/free/png-256/facebook-logo-2019-1597680-1350125.png",
                                      width: 40,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/SignUp');
                                  },
                                  child: Text(
                                    "Don't Have an Account Sign Up",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blueAccent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class textbox extends StatelessWidget {
  const textbox({Key key, this.icon1, this.hinttext}) : super(key: key);
  final icon1;
  final hinttext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.blueGrey,
          color: Color.fromRGBO(224, 224, 224, 1),
          borderRadius: new BorderRadius.circular(20.0),
        ),
        child: TextField(
          onChanged: (text){
            if(hinttext=="Email"){
              user_signin.email=text;
              user_signup.email=text;
            }
            else if(hinttext=="Password") {
              user_signin.password=text;
              user_signup.password=text;
            }
            else if(hinttext=="Re-enter Password"){
              user_signup.passwordConf=text;
            }
          },
          cursorColor: Colors.purple,
          decoration: InputDecoration(
              focusColor: Colors.white,
              prefixIcon: Icon(
                icon1,
                size: 25,
                color: Colors.blue,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: hinttext,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintStyle: TextStyle(
                  color: Colors.brown[600], fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}


