import 'Pages/confirmation.dart';
import 'Pages/map.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final colorP = Colors.teal;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mayday',
      theme: ThemeData(
        primarySwatch: colorP,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Mayday'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final colorP = Colors.teal;
  final numeroChamp = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.public),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MapPage()));
            },
          )
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 90),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset("assets/logo.png"),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "mayday",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                    textScaleFactor: 2,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text("Health Assessment and Emergency Signal Solution ",
                      style: TextStyle(color: Colors.black54, fontSize: 10)),
                )
              ],
            ),
          ),
        ),
        Container(
          
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1,
              ),
              boxShadow: [BoxShadow(color: Colors.blueGrey,blurRadius: 5.0, offset: Offset(2, 2))],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Please enter your contact information to\n confirm your identity.",
                      maxLines: 2,
                      style: TextStyle(color: Colors.black54, fontSize: 13.5),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 22,
                    margin: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: MediaQuery.of(context).size.width / 12),
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //     color: Colors.grey,
                    //     width: 1,
                    //   ),
                    //   borderRadius: BorderRadius.circular(12),
                    // ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: numeroChamp,
                      decoration: InputDecoration(
                        hintText: "Your contact number",
                        //border: InputBorder.none
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width * (5 / 6),
                    decoration: BoxDecoration(
                        color: colorP,
                        border: Border.all(color: colorP, width: 1),
                        borderRadius: BorderRadius.circular(6)),
                    child: FlatButton(
                      color: colorP,
                      onPressed: () {
                        traitement(numeroChamp.text);
                      },
                      child: Text("Confirm",
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            )),
      ]),
      resizeToAvoidBottomInset: true,
    );
  }

  void traitement(String numeroGet) {
    bool validate = false;

    if (numeroGet.length == 10) {
      RegExp regExp = new RegExp(r"^(03)[2349]{1}[0-9]{7}$");
      if (regExp.hasMatch(numeroGet)) validate = true;
    } else if (numeroGet.length == 13) {
      RegExp regExp = new RegExp(r"^(.+2613)[2349]{1}[0-9]{7}$");
      if (regExp.hasMatch(numeroGet)) validate = true;
    }

    numeroGet = formNumero(numeroGet);
    if (validate) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ConfirmationPage(numero: numeroGet);
      }));
    } else
      _alertErrorInput();
  }

  Future<void> _alertErrorInput() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Number',
              style: TextStyle(color: Color(0xFFe74c3c))),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String formNumero(String num) {
    String numFinal = "";

    if (num.length == 13) {
      List<String> numList = num.split('');
      int i = 0;

      for (String l in numList) {
        numFinal += l;
        if (i == 3)
          numFinal += " ";
        else if (i == 5)
          numFinal += " ";
        else if (i == 7)
          numFinal += " ";
        else if (i == 10) numFinal += " ";
        i++;
      }
    } else if (num.length == 10) {
      List<String> numList = num.split('');
      int i = 0;

      for (String l in numList) {
        if (i == 3)
          numFinal += " ";
        else if (i == 5)
          numFinal += " ";
        else if (i == 8) numFinal += " ";
        i++;
        numFinal += l;
      }
    }

    return numFinal;
  }
}
