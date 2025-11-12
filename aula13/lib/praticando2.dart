main() {
  print('iniciando');
  try {
    imprime(11);
  } catch (e) {
    print('Ocorreu um erro: $e');
  }
  print('terminou antes');
}

void imprime(int x) {
  if (x > 10) {
    throw ('Número muito grande!');
  }
  print(x);
}
