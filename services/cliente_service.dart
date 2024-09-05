// //Usando a biblioteca riverpod no gerenciamento de estado


// //providers/api_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final apiUrlProvider = Provider<String>((ref) {
//   return 'http://seu-dominio'; //URL base da sua API
// });

// // providers/funcionario_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart'as http;
// import 'dart:convert';
// import 'api_provider.dart';  //Importe o provider da URL base
// import '../models/funcionario.dart'; //Importe a classe Funcionario


// final funcionarioProvider = StateNotifierProvider<FuncionarioNotifier, List<funcionario>>((ref) {
//   final apiUrl = ref.watch(apiUrlProvider);
//   return FuncionarioNotifier(apiUrl);
//   });

// class FuncionarioNotifier extends StateNotifier<List<funcionario>> {
//   final String apiUrl;


//   FuncionarioNotifier(this.apiUrl) : super([]);

//   Future<void> criarFuncionario(
//       String codFunc, String nomeFunc, int cpf) async {
//     final response = await http.post(
//       Uri.parse('api_provider.dart'), // URL da API
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'CODFUNC': codFunc,
//         'NOMEFUNC': nomeFunc,
//         'CPF': cpf,
//       }),
//     );

//     if (response.statusCode == 201) {
//       print('Funcionário criado com sucesso!');
//       // Você pode atualizar o estado do provider se necessário
//     } else {
//       print('Falha ao criar funcionário: ${response.reasonPhrase}');
//     }
//   }
// }
