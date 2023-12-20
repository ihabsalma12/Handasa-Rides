import 'package:demo/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {

  bool _passHidden = true;
  final changePassFormKey = GlobalKey<FormState>();
  final TextEditingController existingEmailContr = TextEditingController();
  final TextEditingController newPassContr = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);


    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(key: changePassFormKey,
            child: Center(
              child: SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text("Change your password", style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontStyle: FontStyle.italic,
                      fontSize: 21,
                    )),
                    const SizedBox(height:20,),
                    TextFormField(
                        controller: existingEmailContr,
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
                      controller: newPassContr,
                      obscureText: _passHidden,
                      decoration: InputDecoration(labelText: "New Password",
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
                        return null;
                      },
                    ),
                    const SizedBox(height:30),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColorDark,
                      ),
                        onPressed: (){
                          // // TODO output snackbar for "Welcome" or for errors signing up.
                          // if(changePassFormKey.currentState!.validate()){
                          //   try{await authService.sendPasswordResetEmail(
                          //       fullName: fnameContr.text,
                          //       email: signupEmailContr.text, password: signupPassContr.text);}
                          //   catch (error){
                          //     final snackBar = SnackBar(content: Text('SALMA! Signup error happened: ${error.toString()}'),);
                          //     if(context.mounted)ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          //     return;
                          //   }
                          //
                          //   debugPrint("All is good! Signed up.");
                          //   if (!mounted) {
                          //     return;
                          //   } else{
                          //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          //         builder: (c) => const UserRidesPage()),
                          //             (route) => false);
                          //     const snackBar = SnackBar(content: Text('Welcome, user'),);
                          //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          //   }


                            // formKey.currentState!.reset();
                          },
                      child: const Text("Change my password"),),




                  ],
                ),
              ),
            ),
          ),
        )


    );

  }


}
