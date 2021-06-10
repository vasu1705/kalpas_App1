import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kalpas_carrers/User_Classes.dart';
import 'main.dart';


class Signup extends StatelessWidget {
  const Signup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
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
                          style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.w400),
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
                                  "Sign Up",
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
                                textbox(
                                  icon1: Icons.verified_user,
                                  hinttext: "Re-enter Password",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                MaterialButton(
                                  onPressed: () {

                                    void Register() async {
                                      var url = Uri.parse("https://nodejs-register-login-app.herokuapp.com");
                                      print(jsonEncode(user_signup.tojson()));
                                      var response = await http.post(url, body: {"email":"${user_signup.email}","password":"${user_signup.password}","passwordConf":"${user_signup.passwordConf}","username":"test"});

                                      if (response.body.isEmpty) {
                                        print("No Response Received");
                                      } else {
                                        var data = json.decode(response.body);
                                        if (data["Success"] == "You are regestered,You can login now.") {
                                          Navigator.pop(context);
                                        } else {
                                          print(data["Success"]);
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data["Success"]}"),));
                                        }
                                      }
                                    }
                                    Register();
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
                                  "------------------ Or Sign Up with ------------------",
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
                                    SizedBox(width: 20,),
                                    Image.network(
                                      "https://cdn.iconscout.com/icon/free/png-256/facebook-logo-2019-1597680-1350125.png",
                                      width: 40,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                MaterialButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Have an Account Sign in",
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
