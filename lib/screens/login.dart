// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _passHidden = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailContr = TextEditingController();
  TextEditingController passContr = TextEditingController();


  // Future <void> login() async{
  //   // final auth = FirebaseAuth.instance;
  //   // auth.signInWithEmailAndPassword(email: emailContr.text, password: emailContr.text);
  // }
  login(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Login Page"),
      //   //backgroundColor: Theme.of(context).colorScheme.onPrimary,
      //   centerTitle: true,
      // ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(key: formKey,
          child: Center(
            child: SingleChildScrollView(

              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Text("Login", style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                  )),
                  const SizedBox(height:40,),
                  TextFormField(
                      controller: emailContr,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        //hintText: "<your_ID_here>@eng.asu.edu.eg",
                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,)),
                        prefixIcon: Icon(Icons.email_rounded),
                      ),
                      validator: (valid){
                        if(valid == null || valid.isEmpty) {return ('Email required.');}
                        return null;
                      }
                  ),
                  const SizedBox(height:10),
                  TextFormField(
                    controller: passContr,
                    obscureText: _passHidden,
                    decoration: InputDecoration(labelText: "Password",
                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,),
                        ),
                        prefixIcon: const Icon(Icons.lock_rounded),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            _passHidden = !_passHidden;
                          });
                        }, icon: Icon(_passHidden
                            ?Icons.visibility
                            :Icons.visibility_off),)


                    ),
                    validator: (valid){
                      if(valid == null || valid.isEmpty) {return ('Password required.');}
                      else if(valid.length < 8){return ('Password length must be > 8.');}
                      else return null;
                    },
                  ),
                  const SizedBox(height:10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: (){
                        debugPrint("Go to change password page...");
                        Navigator.pushNamed(context, "/ChangePass");
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontStyle: FontStyle.italic),),
                    ),
                  ),


                  const SizedBox(height:20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: (){
                      if(formKey.currentState!.validate() ){
                        debugPrint("All is good! Logged in.");
                        Navigator.pushReplacementNamed(context, "/UserRides");
                        // formKey.currentState!.reset();
                        login();
                      }
                    }, child: const Text("Login"),),




                  const SizedBox(height:20),
                  GestureDetector(
                      onTap: (){
                        debugPrint("Go to sign up page...");
                        Navigator.pushNamed(context, "/SignUp");
                      },
                      child: Text(
                        "No account? Sign up here.",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,),),
                  ),





    ],
    ),
    ),
    ),
    ),
      )


    );

  }
}
