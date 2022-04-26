import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // permite que fazemos as requisições 
import 'dart:async'; // permite que fazemos as requisições mas não fiquemos as esperamos
import 'dart:convert'; // library para transformar os dados em json


// URL de requisição
const request = "https://api.hgbrasil.com/finance?format=json&key=7daf723a "; //API
void main() async {

  print(await getData()); // pega os dados da função getData 

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // tira o debug no canto da tela
    
    home: Home(),
  ));
}

Future<Map> getData() async{
  // requisição assíncrona
  //resposta da API
  http.Response  response = await http.get(Uri.parse(request)); // manda o get para o servidor com a URL
  return json.decode(response.body);
} 

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conversor',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true, // centraliza o texto na appbar
        backgroundColor: Colors.amber,
        // botão para apagar as informações nos campos de textos
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          // validação
          child: Form(
            child: Column(
              children: [
                Center(
                  child: Icon(
                    Icons.attach_money_rounded,
                    color: Colors.amber,
                    size: 100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //
                //
                // TEXTFORMFIELD
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reais',
                    labelStyle: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //
                //
                // TEXTFORMFIELD
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Dólares',
                    labelStyle: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //
                //
                // TEXTFORMFIELD
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Euro',
                    labelStyle: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
