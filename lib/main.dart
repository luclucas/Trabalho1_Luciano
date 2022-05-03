//Autor: Luciano Lucas de Oliveira Gois

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String informacoes = "Informe os dados";
  TextEditingController nomeCtrl =  TextEditingController();
  TextEditingController salarioCtrl = TextEditingController();
  TextEditingController dependCtrl = TextEditingController();

  double inss = 0.0;
  double salB = 0.0;
  double irpf = 0.0;
  double salL = 0.0;


   void calcular(){
     setState(() {

    double salario = double.parse(salarioCtrl.text);
    double dependentes = int.parse(dependCtrl.text) * 189.59;
    salB = salario;
    inss = calcularINSS(salario);
    irpf = calcularIR(salario, dependentes, inss);
    salL = (salB - irpf - inss);
    informacoes = "Nome = " + nomeCtrl.text + "\nSalario bruto = " + salB.toStringAsFixed(2) +
     "\nINSS = " + inss.toStringAsFixed(2) + "\nIRPF = " + irpf.toStringAsFixed(2) +
        "\nSalario Liquido = " + salL.toStringAsFixed(2);
     });
  }

  void limpar(){
     setState(() {
     informacoes = 'Informe os dados';
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculo de Impostos'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(onPressed: (){
            limpar();
          }, icon: Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nomeCtrl,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: salarioCtrl,
              decoration: InputDecoration(labelText: "Salário"),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: dependCtrl,
              decoration: InputDecoration(labelText: "Qtd de dependentes"),
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: (){
                    calcular();
                  },
                  child: Text("Calcular"),
                  style: ElevatedButton.styleFrom(
                  primary: Colors.indigoAccent,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                  )),
                )),
            Padding(
              padding: EdgeInsets.only(top: 15),
            child: Text(
              informacoes,
              style: TextStyle(fontSize: 15),
            )),
          ],
        ),
      ),
    );


  }
}

double calcularIR(double salario, double dependentes, double inss){
  double aux = salario - dependentes - inss;
  if(aux <= 1903.98){
    return 0.0;
  } else if(aux <= 2826.65){
    return aux * 0.075;
  } else if(aux <= 3751.05){
    return aux * 0.15;
  }else if(aux <= 4664.68){
    return aux * 0.225;
  }else{
    return aux * 0.275;
  }
}

double calcularINSS(double valor){
  if(valor <= 1212){
    return valor * 0.075;
  } else if(valor <= 2427.35){
    return valor * 0.09;
  } else if(valor <= 3641.03){
    return valor * 0.12;
  } else if(valor <= 7087.22) {
    return valor * 0.14;
  } else{
    return 992.22;
  }
}