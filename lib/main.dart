import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfcreate/pdf_create.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Pdf creator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Questo campo è richiesto';
    } else if (value.length < 3) {
      return 'Il nome deve essere di almeno 3 caratteri';
    }
    return null; // La validazione ha avuto successo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: myController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Scrivi il tuo nome',
                ),
                validator: _validateInput,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfCreate(myController.text),
                      ),
                    );
                  }
                },
                child: const Text('Invia'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
