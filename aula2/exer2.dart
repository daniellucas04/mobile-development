class Aluno {
  String nome;
  String matricula;
  List<double> notas;

  Aluno(this.nome, this.matricula) : this.notas = [];
}

void main() {
  Aluno aluno = Aluno('Fulano de tal', '123456');
  print(aluno);
}
