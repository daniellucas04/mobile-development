void main() {
  DateTime data = DateTime.now();
  DateTime inicio = DateTime(data.year, data.month, 1);

  print('D | S | T | Q | Q | S | S');

  int diaMes = 1;
  String semana = '';

  for (var i = 1; i <= DateTime.now().day; i++) {
    for (var diaSemana = 0; diaSemana < 6; diaSemana++) {
      if (diaSemana >= inicio.weekday) {
        semana += '$diaMes | ';
        diaMes++;
      } else {
        semana += '  | ';
      }
    }
    ;
    semana += '\n';
  }

  print(semana);
}
