import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ricoletta/views/home_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ricoletta/coleta.dart' as Coleta;

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 500,
              decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 20,
                    children: [
                      Image.asset(
                        'assets/images/cidts.png',
                        height: 100,
                      ),
                      Text(
                        'RICO',
                        style: TextStyle(
                            fontSize: 42,
                            color: Color(0xFF007B52),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    child: Form(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              labelText: 'Entre com seu email',
                              focusColor: Colors.white30,
                              filled: true,
                              fillColor: Colors.white),
                        ),
                        Container(
                          height: 24,
                        ),
                        TextFormField(
                          obscureText: true,
                          style: TextStyle(backgroundColor: Colors.white30),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              labelText: 'Entre com a sua senha',
                              focusColor: Colors.white30,
                              filled: true,

                              fillColor: Colors.white),
                        ),
                        Container(
                          height: 24,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: Color(0xFF007B52),
                                minimumSize: Size.fromHeight(50)),
                            onPressed: () {

                              Coleta.getProfile(1).then((data) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomeView(Coleta.Profile(data))));
                              }).catchError((onError) {
                                const snackBar = SnackBar(
                                  content: Text('Erro ao fazer login.'),
                                );

                                  // Find the ScaffoldMessenger in the widget tree
                                  // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                              });

                            },
                            child: const Text(
                              'Entrar',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        Container(
                          height: 5,
                        ),
                        Wrap(
                          spacing: -10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text('Não possui uma conta? '),
                            TextButton(
                              // style: TextButton.styleFrom(foregroundColor:  Colors.yellow),
                              onPressed: _lauchCadastro,
                              child: const Text(
                                'Cadastre-se!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF007B52)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ))),
    );
  }
}

void _lauchCadastro() async {
  final Uri url = Uri.parse('https://flutter.dev');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {}
}
