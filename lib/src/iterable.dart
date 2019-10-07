typedef ElementTester<T> = bool Function(T element);

extension FunctionalList<T> on Iterable<T> {
  bool all(ElementTester<T> test) {
    for (var element in this) {
      if (!test(element)) return false;
    }
    return true;
  }
}
