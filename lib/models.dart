
class Produtor {
  final String cpfOuCnpj;
  final String email;
  final String nome;

  Produtor(this.cpfOuCnpj, this.email, this.nome);

}

class Produto {
  final int id;
  final dynamic produtor;
  final int origem;

  Produto(this.id, this.produtor, this.origem);

}

class Animal {
  final int id;

  final String sexo;
  final Map<String, dynamic> produtor;
  final DateTime nascimento;
  final DateTime? abatimento;
  final Object? genitor;
  final Object? genitora;
  final String raca;

  Animal(this.id, this.sexo, this.produtor, this.nascimento, this.abatimento,
      this.genitor, this.genitora, this.raca);

  factory Animal.fromJSON(Map<String, dynamic> json) {
    return Animal(
        json['id'] as int,
        json['sexo'] as String,
        json['produtor'] as dynamic,
        DateTime.parse(json['nascimento']),
        null,
        json['genitor'],
        json['genitora'],
        json['raca'] as String);
  }

  String _classification(int days) {
    if(days <= 6 * 30) {
      return sexo == 'M' ? 'Cordeiro' : 'Cordeira';
    } else if(days <= 12 * 30) {
      return sexo == 'M' ? 'Borrego' : 'Borrega';
    } else {
      return sexo == 'M' ? 'Carneiro' : 'Carneira';
    }
  }

  @override
  String toString() {
    final today = DateTime.now();
    final age = today.difference(nascimento);

    final str = '#$id ${_classification(age.inDays)}';
    return str;
    //return 'Animal{id: $id, sexo: $sexo, produtor: $produtor, nascimento: $nascimento, abatimento: $abatimento, genitor: $genitor, genitora: $genitora, raca: $raca}';
  }
}
