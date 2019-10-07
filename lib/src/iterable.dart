typedef ElementTester<T> = bool Function(T element);

extension FunctionalList<T> on Iterable<T> {
  bool all(ElementTester<T> test) {
    for (var element in this) {
      if (!test(element)) return false;
    }
    return true;
  }
}

extension FunctionalListBool on Iterable<bool> {
  bool all() {
    for (var element in this) {
      if (!element) return false;
    }
    return true;
  }

  bool allTrue() => this.all();

  bool allFalse() {
    for (var element in this) {
      if (element) return false;
    }
    return true;
  }
}
