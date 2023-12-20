import 'package:demo/helpers/DatabaseUserID.dart';
import 'package:demo/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_rides.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {



  bool _signupPassVisible = true;
  final signupFormKey = GlobalKey<FormState>();
  final TextEditingController fnameContr = TextEditingController();
  final TextEditingController signupEmailContr = TextEditingController();
  final TextEditingController signupPassContr = TextEditingController();
  final TextEditingController confirmPassContr = TextEditingController();




  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final mySQfLite = DatabaseUserID();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: signupFormKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sign Up", style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 42,
                  )),
                  const SizedBox(height:20,),
                  Text("Start ridesharing with fellow students today!", style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  )),
                  const SizedBox(height:40,),
                  TextFormField(
                    controller: fnameContr,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,)),
                      prefixIcon: Icon(Icons.person_rounded),
                    ),
                    validator: (valid){
                      if(valid == null || valid.isEmpty) {return ('Full name required.');}
                      return null;
                    }
                    ),
                  const SizedBox(height:10,),
                  TextFormField(
                        controller: signupEmailContr,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                            hintText: "<your_ID>@eng.asu.edu.eg",
                            //floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 1,)),
                          prefixIcon: Icon(Icons.email_rounded),
                        ),
                        validator: (valid){
                          if(valid == null || valid.isEmpty) {return ('Email required.');}
                          else if(!valid.contains('@eng.asu.edu.eg', 7)) {return ('Email must be xxxxxxx@eng.asu.edu.eg');}
                          return null;
                        }
                    ),
                  const SizedBox(height: 10),
                  TextFormField(
                        controller: signupPassContr,
                        obscureText: _signupPassVisible,
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
                                _signupPassVisible = !_signupPassVisible;
                              });
                            }, icon: Icon(_signupPassVisible? Icons.visibility:Icons.visibility_off),)


                        ),
                        validator: (valid){
                          if(valid == null || valid.isEmpty) {return ('Password required.');}
                          else if(valid.length < 8){return ('Password length must be > 8.');}
                          else return null;
                        },
                        ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: confirmPassContr,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Confirm Password",
                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,),
                        ),
                        prefixIcon: Icon(Icons.lock_rounded),



                    ),
                    validator: (valid){
                      if(valid == null || valid.isEmpty) {return ('Confirm password required.');}
                      else if(valid != signupPassContr.text){return ('Does not match \'Password\'.');}
                      return null;
                    },
                  ),



                  const SizedBox(height:20,),
                  ElevatedButton(
                      // style: ElevatedButton.styleFrom(
                      //   backgroundColor: Theme.of(context).primaryColorDark,
                      // ),
                      onPressed: ()async{
                        if(signupFormKey.currentState!.validate()){
                          try{
                            await authService.createUserWithEmailAndPassword(
                            fullName: fnameContr.text,
                              email: signupEmailContr.text, password: signupPassContr.text);
                            // await mySQfLite.ifExistDB();
                            setState(() {

                              debugPrint("current user listener updated, now updating local profile data...");
                              mySQfLite.insertUser(authService.getUserUID(), authService.getUserEmail(), authService.getDisplayName());

                            });
                            // await mySQfLite.ifExistDB();
                          }
                          catch (error){
                            if(context.mounted)ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Signup error happened: ${error.toString()}'),));
                            return;
                          }

                          debugPrint("All is good! Signed up.");
                          if (context.mounted){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (c) => const UserRidesPage()),
                                    (route) => false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Welcome, ${authService.getDisplayName()}!'),));

                          }


                          // formKey.currentState!.reset();
                        }

                        },
                      child: const Text("Sign up"),
                  ),


                ],
              ),
            ),
          ),
        ),
      )


    );

  }

  // Future <bool> createUserWithEmailAndPassword() async {
  //   try {
  //     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: signupEmailContr.text,
  //       password: signupPassContr.text,
  //     );
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     //TODO this works! but debug statements do not show...
  //     //TODO fix the exceptions
  //
  //     debugPrint("SALMA! Signup error happened:$e");
  //     // if (e.code == 'weak-password') {
  //     //   debugPrint('The password provided is too weak.');
  //     // } else
  //     // if (e.code == 'email-already-in-use') {
  //     //   print('The account already exists for that email.');
  //     // }
  //    }
  //     // catch (e) {
  //   //   print(e.toString());
  //   // }
  //   return false;
  // }

}
