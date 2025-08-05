class Aluno {
  String nome;
  String matricula;
  List<double> notas;

  Aluno(this.nome, this.matricula) : this.notas = [];

  void lancaNota(double nota) {
    this.notas.add(nota);
  }
}
