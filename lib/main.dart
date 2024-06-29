import 'package:flutter/material.dart';
import 'package:ricoletta/views/home_view.dart';
import 'package:ricoletta/views/login_view.dart';
import 'package:ricoletta/coleta.dart' as Coleta;

void main() {

  Coleta.storage.readData().then((data) {
    if(data == null) { // não tem arquivo
      throw Exception('not found');
    }
    return data;
  }).then((onValue) { // recuperou arquivo
    runApp(MaterialApp(home: HomeView(onValue as Coleta.Profile)));
  }).catchError((onError) {
    runApp(MaterialApp(home: LoginView()));
  });

  //
  // Coleta.getProfile(1).then((onValue){
  //   print('Deu certo. $onValue');
  //
  //   final pro = Coleta.Profile(onValue);
  //
  //   print("animais ${pro.animais}");
  //   print("nome ${pro.nome}");
  //   print("email ${pro.email}");
  //   print("av: ${pro.avaliacoes}");
  //   print("sitios ${pro.sitios}");
  //   print("produtos ${pro.produtos}");
  //
  // }).catchError((onError) {
  //   print('Deu errado ${onError}');
  // });

  // runApp(new MaterialApp(home: LoginView()));
}
