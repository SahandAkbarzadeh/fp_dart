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

extension FunctionalListList<T> on Iterable<Iterable<T>> {
  Iterable<T> unnest() {
    List<T> _flattedList = [];
    for (var sublist in this) _flattedList.addAll(sublist);
    return _flattedList;
  }
}

extension FunctionalListDynamic on Iterable<dynamic> {
  Iterable<dynamic> flatten() {
    List<dynamic> result = [];
    for (var item in this) {
      if (item is Iterable) {
        result.addAll(item.flatten());
      } else {
        result.add(item);
      }
    }
    return result;
  }
}
