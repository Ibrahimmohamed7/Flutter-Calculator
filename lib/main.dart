//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyCalculator());
}
class MyCalculator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator Project",
      home: Calculator(),
    );
  }
  
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Calculator();
  }
}

class _Calculator extends State<Calculator>{
  double num1 = 0;
  double num2 = 0;
  String text = '0';
  String result = '';
  String finalResult = '';
  String operation = '';
  String preOperation = '';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                        text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.right ,
                    )
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("AC", Color(0xffa5a5a5),1),
                button("+/-", Color.fromRGBO(165, 165, 165, 1),1),
                button("%", Color.fromRGBO(165, 165, 165, 1),1),
                button("/", Color(0xffff9800),1)
              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("7", Color(0xff323232),1),
                button("8", Color(0xff323232),1),
                button("9", Color(0xff323232),1),
                button("X", Color(0xffff9800),1)
              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("4", Color(0xff323232),1),
                button("5", Color(0xff323232),1),
                button("6", Color(0xff323232),1),
                button("-", Color(0xffff9800),1)
              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("1", Color(0xff323232),1),
                button("2", Color(0xff323232),1),
                button("3", Color(0xff323232),1),
                button("+", Color(0xffff9800),1)
              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("0", Color(0xff323232),0),
                button(".", Color(0xff323232),1),
                button("=", Color(0xffff9800),1)
              ],

            )
          ],
        ),
      ),
    );
  }

  Widget button (String btnText,Color color,int number){
    Container container ;
    if(number == 0){
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: (){
           calculate(btnText);
          },
          child: Text(
            btnText,
            style: TextStyle(
                fontSize: 30,
                color: Colors.black
            ),
          ),
          color: color,
          padding: EdgeInsets.only(left: 81,top: 20,right: 81,bottom: 20) ,
          shape: StadiumBorder()
        ),
      );
    }else{
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: (){
           calculate(btnText);
          },
          child: Text(
            btnText,
            style: TextStyle(
                fontSize: 30,
                color: Colors.black
            ),
          ),
          color: color,
          padding: EdgeInsets.all(20) ,
          shape: CircleBorder(),
        ),
      );
    }
    return container;
  }

  void calculate(btnText){
      if(btnText=='AC'){
        num1 = 0;
        num2 = 0;
        text = '0';
        result = '';
        finalResult = '0';
        operation = '';
        preOperation = '';
      }else if(operation=='=' && btnText=='='){
        switch(preOperation){
          case'+':
            finalResult = add();
            break;
          case'-':
            finalResult = sub();
            break;
          case'X':
            finalResult = mult();
            break;
          case'/':
            finalResult = div();
            break;
        }

        result = '' ;

      } else if(btnText=='+'||btnText=='-'||btnText=='X'||btnText=='/'||btnText=='='){
        if(num1==0){
          num1 = double.parse(finalResult);
        }else {
          num2 = double.parse(finalResult);
        }

        switch(operation){
          case'+':
            finalResult = add();
            break;
          case'-':
            finalResult = sub();
            break;
          case'X':
            finalResult = mult();
            break;
          case'/':
            finalResult = div();
            break;
        }
        preOperation = operation;
         operation = btnText;
         result = '';
      }else if(btnText == '%'){
        result = (double.parse(finalResult)/100).toString();
        num1 = double.parse(result);
        finalResult = removeDecimal(result);
      }else if(btnText == '.'){
        if(!result.contains('.')){
           result = result + '.' ;
        }
        finalResult = result ;
      }else if(btnText == '+/-'){
        if(result.startsWith('-')){
          result = result.substring(1);
        }else{
          result = '-'+ result ;
        }
        finalResult = result;
      }
      else{
        if(operation == '='){
          num1 = 0 ;
        }
        result = result + btnText ;
        finalResult = result ;

      }

      setState(() {
        text = finalResult ;
      });
  }

  String add() {
  result = (num1+num2).toString();
  num1 = double.parse(result);
  return removeDecimal(result);
  }
  String sub() {
    result = (num1-num2).toString();
    num1 = double.parse(result);
    return removeDecimal(result);
  }
  String mult() {
    result = (num1*num2).toString();
    num1 = double.parse(result);
    return removeDecimal(result);
  }
  String div() {
    result = (num1/num2).toString();
    num1 = double.parse(result);
    return removeDecimal(result);
  }
  String removeDecimal(String result){
    List<String>  splitResult;
    if(result.contains('.')){
      splitResult = result.split('.');
      if(int.parse(splitResult[1])>0)
        return result;

    }
    return splitResult[0] ;
}

}


