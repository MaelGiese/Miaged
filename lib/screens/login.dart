import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final mdpController = TextEditingController();
  Future<FirebaseUser> user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Miaged', style: Theme.of(context).textTheme.headline1),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextFormField(
                controller: mdpController,
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                child: Text('Se connecter'),
                onPressed: () {
                  user = handleSignInEmail(emailController.text, mdpController.text)
                      .then((FirebaseUser user) => Navigator.pushReplacementNamed(context, '/acheter')).catchError((e) => print(e));
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> handleSignInEmail(String email, String mdp) async {
    AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: mdp);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user;
  }
}

