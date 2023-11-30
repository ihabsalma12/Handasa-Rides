import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {



  bool _signupPassVisible = true;
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController fnameContr = TextEditingController();
  TextEditingController signupEmailContr = TextEditingController();
  TextEditingController signupPassContr = TextEditingController();
  TextEditingController confirmPassContr = TextEditingController();




  @override
  Widget build(BuildContext context) {
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
                            hintText: "<your_ID_here>@eng.asu.edu.eg",
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
                          return null;
                        },
                        ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: confirmPassContr,
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
                      if(valid == null || valid.isEmpty) {return ('Password required.');}
                      return null;
                    },
                  ),



                  const SizedBox(height:20,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: (){
                        if(signupFormKey.currentState!.validate() ){
                          debugPrint("All is good! Signed up.");
                          Navigator.pushReplacementNamed(context, "/UserRides");
                          // formKey.currentState!.reset();
                        }},
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

}
