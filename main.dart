import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // permite que fazemos as requisições
import 'dart:async'; // permite que fazemos as requisições mas não fiquemos as esperamos
import 'dart:convert'; // library para transformar os dados em json

// URL de requisição
const request =
    "https://api.hgbrasil.com/finance?format=json&key=7daf723a "; //API
void main() async {
  print(await getData()); // pega os dados da função getData

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // tira o debug no canto da tela

      home: Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
    ),
  );
}

Future<Map> getData() async {
  // requisição assíncrona
  //resposta da API
  http.Response response = await http
      .get(Uri.parse(request)); // manda o get para o servidor com a URL
  return json.decode(response.body);
}

class Home extends StatefulWidget {



  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  
//
//controladores que irão obter os textos e descobrir quando eles são alterados 
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  //
  // funções que ão chamadas quando o valor dos campos são alterados
  void _realChanged(String text){
    print(text);
  }

  void _dolarChanged(String text){
    print(text);
  }

  void _euroChanged(String text){
    print(text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '\$ Conversor \$',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true, // centraliza o texto na appbar
        backgroundColor: Colors.amber,
        // botão para apagar as informações nos campos de textos
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando dados",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carrega dados dados",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  var dollar =
                      snapshot.data!["results"]["currencies"]["USD"]["buy"];

                  var euro =
                      snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                  //tela que rola
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      //
                      //
                      // validação
                      child: Form(
                        child: Column(
                          children: [
                            Center(
                              child: Icon(
                                Icons.monetization_on,
                                color: Colors.amber,
                                size: 100,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //
                            // TEXTFORMFIELD R$
                            textField("Reais", "R\$", realController, _realChanged),
                            Divider(),
                            //
                            // TEXTFORMFIELD USD
                            textField("Dólares", "\$", dolarController, _dolarChanged),
                            Divider(),
                            //
                            // TEXTFORMFIELD EUR
                            textField("Euros", "€", euroController, _euroChanged),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            }
          }),
    );
  }
}
//
// Funnção que retorna a textField
Widget textField(String label, String prefix, TextEditingController c, Function changed) {
  return TextField(
    controller: c,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.amber,
          fontSize: 25,
        ),
        prefixText: prefix),
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 20,
      color: Colors.amber,
    ),
    onChanged: (texto){
      changed(texto);
    },
  );
}
