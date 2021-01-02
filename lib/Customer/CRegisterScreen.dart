import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocskart/Customer/CloginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocskart/Customer/CNavigationScreen.dart';


class CRegisterScreen extends StatefulWidget {
  static final String id = "CRegisterScreen";
  @override
  _CRegisterScreenState createState() => _CRegisterScreenState();
}

class _CRegisterScreenState extends State<CRegisterScreen> {

  String email = "",
      password = "";
  var _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> register() async {
    FirebaseUser user = (await auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password)) as FirebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff000725),
        body: Form(
          key: _formKey,
          child:ListView(
            children: [
              Container(
                width: double.infinity,
                height: 180,

                child: Padding(
                  padding: EdgeInsets.all(20),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 50,),
                      Text("Sign Up",
                        style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                      Text("Welcome to our store",
                        style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
                decoration: BoxDecoration(borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(150)),
                  color: Color(0xffff2fc3),
                ),
              ),



              Theme(data: ThemeData(
                  hintColor: Colors.blue
              ), child: Padding(padding: EdgeInsets.only(top: 50,right: 20,left: 20),
                child: TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter user name";
                    }
                    return null;
                  },


                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "User Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),

                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),


                  ),
                ),
              ),
              ),

              Theme(data: ThemeData(
                  hintColor: Colors.blue
              ), child: Padding(padding: EdgeInsets.only(top: 10,right: 20,left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter Email";
                    }else{
                      email=value;
                    }
                    return null;
                  },




                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),

                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),


                  ),
                ),
              ),
              ),

              Theme(data: ThemeData(
                  hintColor: Colors.blue
              ), child: Padding(padding: EdgeInsets.only(top: 10,right: 20,left: 20),
                child: TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter password";
                    } else if(value.length<8){
                      return "your password shouldn't be less than 8 character";
                    }else{
                      password=value;
                    }
                    return null;
                  },



                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),

                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),


                  ),
                ),
              ),
              ),



              SizedBox(height: 20,),
              Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child:RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        register();
                        Navigator.push(context,MaterialPageRoute(
                            builder: (BuildContext context)=>CNavigationScreen()
                        ));
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Color(0xffff2fc3),
                    child: Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    padding: EdgeInsets.all(10),
                  )
              ),
              SizedBox(height: 20,),

              Container(
                width: double.infinity,
                height: 1,
                color: Colors.blue,
              ),

              Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: RaisedButton(
                  onPressed: (){},
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.google,color: Color(0xffff2fc3),),
                      SizedBox(width: 10,),
                      Text("Sign in with google",style: TextStyle(
                          fontSize: 20,color: Color(0xff000725)
                      ),)

                    ],
                  ),
                ),
              ),


              Padding(padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                child: RaisedButton(
                  onPressed: (){},
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.phone,color: Color(0xffff2fc3),),
                      SizedBox(width: 10,),
                      Text("Sign in with Phone",style: TextStyle(
                          fontSize: 20,color: Color(0xff000725)
                      ),)

                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Center(
                  child: Column(
                    children: [
                      Text("You already have an account ?",style: TextStyle(
                          color: Colors.white
                      ),),
                      SizedBox(height: 5,),
                      FlatButton(onPressed:  (){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context)=> CloginScreen())
                        );
                      },

                          child: Column(
                            children: [
                              Text("Log In",style: TextStyle(color: Colors.blue),),
                              Container(
                                width: 45,
                                height: 1,
                                color: Colors.blue,
                              )
                            ],
                          )

                      )

                    ],
                  )


              )
            ],
          ),
        )

    );
  }
}




