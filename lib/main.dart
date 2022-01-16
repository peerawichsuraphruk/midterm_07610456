
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _length = TextEditingController();
  final _girth = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'PIG WEIGHT\nCALCULATOR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pink.shade500,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Image.asset(
                'assets/images/pig.png',
                width: 400.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.30),
                                blurRadius: 6.0,
                              )
                            ]
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'LENGTH \n (cm)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            TextField(
                              // Weight
                              textAlign: TextAlign.center,
                              controller: _length,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter length',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.30),
                              blurRadius: 6.0,
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'GIRTH \n (cm)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            TextField(
                              textAlign: TextAlign.center,
                              controller: _girth,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter girth',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('CALCULATE'),
                onPressed: () {
                  var input1 = _length.text;
                  var input2 = _girth.text;
                  var length = double.tryParse(input1);
                  var girth = double.tryParse(input2);

                  if (length == null || girth == null) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('ERROR'),
                            content: const Text('Invalid input'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK',
                                      style: TextStyle(color: Colors.pink)))
                            ],
                          );
                        });
                  }

                  var weight =
                      (girth! / 100) * (girth / 100) * (length! / 100) * 69.3;
                  var price = weight * 112.50;

                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              const Text('RESULT'),
                              Image.asset('assets/images/ic_pig.png',
                                  width: 36.0),
                            ],
                          ),
                          content: Text(// Weight & Price
                              'Weight: ${minus(weight)} - ${plus(weight)} kg\n'
                              'Price: ${minus(price)} - ${plus(price)} Bath'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK',
                                    style: TextStyle(color: Colors.pink)))
                          ],
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int minus(double num) {
  double n = 3 / 100;
  double cal = num - (num * n);
  return cal.round();
}

int plus(double num) {
  double n = 3 / 100;
  double cal = num + (num * n);
  return cal.round();
}
