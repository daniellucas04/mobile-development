class Dados {
  final String screen;
  final String memory;

  const Dados({required this.screen, required this.memory});

  Map<String, Object?> toMap() {
    return {'screen': screen, 'memory': memory};
  }

  @override
  String toString() {
    return 'Dados{screen: $screen, memory: $memory}';
  }
}
