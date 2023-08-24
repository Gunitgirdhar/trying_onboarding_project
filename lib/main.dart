import 'package:flutter/material.dart';
import 'package:trying_onboarding_project/AppdataBase.dart';
import 'package:trying_onboarding_project/DAshboard.dart';
import 'package:trying_onboarding_project/NoteModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
  AppDataBase db=AppDataBase.db;
  String Common="";
  var formKey=GlobalKey<FormState>();
  var controller1=TextEditingController();
  var controller2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Form(
          key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Login Screen",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            TextFormField(
              validator: (value){
                if(value==""){
                  return "Please enter your email";
                }
                else if(!value!.contains("@")){
                  return "Please enter correct Email";
                }
                return null;
              },
              controller: controller1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                hintText: "Please enter your Email",
                prefixIcon: Icon(Icons.email_rounded),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                hintText: "Please enter your Password",
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
              controller: controller2,
              validator: (value){
                if(value==""){
                  return "Please enter your Password";
                }
                return null;
              },
            ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               ElevatedButton(onPressed: ()async{
                 formKey.currentState!.validate();
                 var email=controller1.text.toString();
                 var pass=controller1.text.toString();

                 if( await db.CheckUser(NoteModel(user_email: email))==false){
                   Common="You dont have an ccount";
                 }
                 else if( await db.CheckPassword(NoteModel(user_email: email,user_password: pass))==false){
                   Common="Password is incorrect";
                 }
                else if(await db.CheckUser(NoteModel(user_email: email)) && await db.CheckPassword(NoteModel(user_email: email,user_password: pass))==true){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardPage(),));
                 }

                }, child: Text("Login")),

               ElevatedButton(onPressed: (){
                 formKey.currentState!.reset();
               }, child: Text("Reset")),

             ],
           ),
            Text("Forgot Password",style: TextStyle(color: Colors.blue,fontSize: 15),),
            Text("${Common}"),

          ],
        ),
      ),
    );
  }
//setState kha lagana hn
