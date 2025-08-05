class Aluno {
  String nome;
  String matricula;
  List<double> notas;

  Aluno(this.nome, this.matricula) : this.notas = [];

  void lancaNota(double nota) {
    this.notas.add(nota);
  }
}

void main() {
  Aluno aluno = Aluno('Fulano de tal', '123456');
  aluno.lancaNota(6.3);
  aluno.lancaNota(5.2);
  aluno.lancaNota(9.4);

  print(aluno.notas);
}
