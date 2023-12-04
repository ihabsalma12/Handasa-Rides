import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {

  bool _passHidden = true;
  final formKey = GlobalKey<FormState>();
  final TextEditingController existingEmailContr = TextEditingController();
  final TextEditingController newPassContr = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final riderUser = Provider.of<AuthService>(context).user;



    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(key: formKey,
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
                    const SizedBox(height:40,),
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
                      onPressed: () async {
                        if(formKey.currentState!.validate()) {

                          // formKey.currentState!.reset();
                        }
                      }, child: const Text("Change my password"),),




                  ],
                ),
              ),
            ),
          ),
        )


    );

  }


}
