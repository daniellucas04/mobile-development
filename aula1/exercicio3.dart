void main() {
  DateTime now = DateTime.now();

  DateTime inicioMes = DateTime(now.year, now.month, 1);
  DateTime fimMes = DateTime(now.year, now.month + 1, 0);

  int ultimoDiaDoMes = fimMes.day;
  int primeiroDiaDaSemana = inicioMes.weekday % 7;

  String calendario = '| D | S | T | Q | Q | S | S |\n';

  for (int i = 0; i < primeiroDiaDaSemana; i++) {
    calendario += '    ';
  }

  int diaAtual = 1;
  for (int i = primeiroDiaDaSemana; i <= DateTime.now().day + 1; i++) {
    calendario += ' ${diaAtual.toString().padLeft(2)} ';
    diaAtual++;

    if ((i + 1) % 7 == 0) {
      calendario += '\n';
    }
  }

  if ((ultimoDiaDoMes + primeiroDiaDaSemana) % 7 != 0) {
    calendario += '';
  }

  print(calendario);
}
