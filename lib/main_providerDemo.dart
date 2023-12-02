/*
import 'package:flutter/material.dart';
import 'package:demo/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(
    ChangeNotifierProvider<AuthModel>(
      create: (_) => AuthModel(),
      child: MaterialApp(
        home: Consumer<AuthModel>(
          builder: (_, auth, __) => auth.isSignedIn ? const HomePage() : const LoginPage(),
        ),
        theme: MyTheme(),
        debugShowCheckedModeBanner: false,

      ),
    ),
  );
}


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginPage')),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          ElevatedButton(
            onPressed: () async{
              final model = context.read<AuthModel>();
              await model.signIn(email: 'fionna@example.com', password: 'yesyesyesyes');
              // if(context.mounted) {
              //   Navigator.pop(context);
              // }
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupPage())),
            child: const Text('Go to Signup Page'),
          ),
        ]),
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final model = context.read<AuthModel>();
            await model.signIn(email: 'fionna@example.com', password: 'yesyesyesyes');
            if(context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text('Signup'),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: Center(
        child: FloatingActionButton.extended(
          onPressed: () async {
            final model = context.read<AuthModel>();
            await model.signOut();
          },
          label: const Text('Log out'),
        ),
      ),
    );
  }
}

class AuthModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isSignedIn => _auth.currentUser != null;

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
*/