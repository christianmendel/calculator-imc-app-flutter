import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: const Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String infoTexto = "Informe seus dados!";

  final _formKey = GlobalKey<FormState>();

  void refresh() {
    weightController.clear();
    heightController.clear();

    setState(() {
      infoTexto = "Informe seus dados!";
    });
  }

  void calculate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        double weight = double.parse(weightController.text);
        double height = double.parse(heightController.text) / 100;
        double imc = weight / (height * height);
        String imcText = imc.toStringAsPrecision(4);
        if (imc < 18.6) {
          infoTexto = "Abaixo do peso (${imcText})";
        } else if (imc >= 18.6 && imc < 24.9) {
          infoTexto = "Peso ideal (${imcText})";
        } else if (imc >= 24.9 && imc < 29.9) {
          infoTexto = "Levemente acima do peso (${imcText})";
        } else if (imc >= 29.9 && imc < 34.9) {
          infoTexto = "Obesidade grau I (${imcText})";
        } else if (imc >= 34.9 && imc < 39.9) {
          infoTexto = "Obesidade grau II (${imcText})";
        } else if (imc >= 40) {
          infoTexto = "Obesidade grau III (${imcText})";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: refresh,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.blue,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: weightController,
                decoration: const InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.blue),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Preencha o campo";
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: heightController,
                decoration: const InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.blue),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Preencha o campo";
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: calculate,
                    child: const Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                  ),
                ),
              ),
              Text(
                infoTexto,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
