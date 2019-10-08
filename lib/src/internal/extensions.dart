extension NumberExtension on num {
  forEach(void Function(int i) step) {
    for (var i = 0; i < this; i++) {
      step(i);
    }
  }
}
