// models/funcionario.dart
class Funcionario {
  final String codFunc;
  final String nomeFunc;
  final int cpf;

  Funcionario({
    required this.codFunc,
    required this.nomeFunc,
    required this.cpf,
  });

  // Método para criar um Funcionario a partir de um JSON
  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return Funcionario(
      codFunc: json['CODFUNC'],
      nomeFunc: json['NOMEFUNC'],
      cpf: json['CPF'],
    );
  }

  // Método para converter um Funcionario em JSON
  Map<String, dynamic> toJson() {
    return {
      'CODFUNC': codFunc,
      'NOMEFUNC': nomeFunc,
      'CPF': cpf,
    };
  }
}
