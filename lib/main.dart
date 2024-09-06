import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checklist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  String? _nome;
  String? _email;

  final _field1Controller = TextEditingController();
  final _field2Controller = TextEditingController();

  bool isChecked = false;

  @override
  void dispose() {
    _field1Controller.dispose();
    _field2Controller.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); //Salva os valores dos campos

      // Exibe os valores
      print('Digite seu nome: $_nome');
      print('Digite seu e-mail: $_email');
      print('Field 1: ${_field1Controller.text}');
      print('Field 2: ${_field2Controller.text}');

      //Essas informações serão validadas e mostradas depois de gerar o código
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Formulário enviado com sucesso!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Nome',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Digite seu nome', //nome do tipo do campo
                        labelStyle: TextStyle(
                          fontSize:
                              12.0, //reduz o tamanho da fonte dentro da caixa
                        ),
                        border:
                            OutlineInputBorder(), // adiciona a borda ao redor da caixa de texto
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu nome';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _nome = value;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'E-mail',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Digite seu e-mail', //nome do tipo do campo
                        labelStyle: TextStyle(fontSize: 12.0),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um e-mail';
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Por favor, insira um e-mail válido';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    const SizedBox(
                        height: 30), //espaço maior entre a lista e os botões
                    TextFormField(
                      controller: _field1Controller,
                      decoration: const InputDecoration(labelText: 'Field 1'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _field2Controller,
                      decoration: const InputDecoration(labelText: 'Field 2'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    const DropdownForm(),
                    const SizedBox(height: 30),
                    const Text('Selecionar: '),
                    Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        }) //Adiciona o DropdownForm aqui
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownForm extends StatefulWidget {
  const DropdownForm({super.key});

  @override
  _DropdownFormState createState() => _DropdownFormState();
}

class _DropdownFormState extends State<DropdownForm> {
  final List<String?> _selectedItems = [null];
  final List<String> _items = ['maçã', 'pera', 'morango'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey),
      //   borderRadius: BorderRadius.circular(8.0),
      // ), // borda em torno do titulo e da lista
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Frutas',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5.0),
          ListView.builder(
            shrinkWrap:
                true, //para garatir que o ListView não ocupe espaço infinito
            //itemCount: _items.length,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  hint: Text('Selecione uma fruta ${index + 1}'),
                  value: _selectedItems[index],
                  //border: OutlineInputBorder(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItems[index] = newValue;
                    });
                  },
                  // items: <DropdownMenuItem<String>>[
                  //   DropdownMenuItem<String>(
                  //     value: null,
                  //     child: Text('Nenhum'),
                  //   ),
                  items: _items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  //        ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
