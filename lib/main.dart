import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 120,
          ),
          SizedBox(height: 22),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 24, left: 22, right: 22),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 22,
                    left: 22,
                    right: 22,
                    bottom: 42,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'codemobiles@gmail.com',
                          labelText: 'email',
                          icon: Icon(Icons.email),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'password',
                          icon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('LOGIN'),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'forgot password?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Text("sso"),
          TextButton(
            onPressed: () {},
            child: Text(
              'register?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
