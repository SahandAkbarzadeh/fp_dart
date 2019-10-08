typedef ElementTester<T> = bool Function(T element);
typedef ElementTransformer<T> = T Function(T element);

bool all<T>(Iterable<T> elements, ElementTester<T> test) {
  for (var element in elements) {
    if (!test(element)) return false;
  }
  return true;
}

ElementTester<bool> allTrue = (item) => item;
ElementTester<bool> allFalse = (item) => !item;

Iterable<T> unnest<T>(Iterable<Iterable<T>> elements) {
  List<T> _flattedList = [];
  for (var sublist in elements) _flattedList.addAll(sublist);
  return _flattedList;
}

Iterable<R> flatten<R, T>(Iterable<T> elements) {
  List<R> result = [];
  for (var item in elements) {
    if (item is Iterable) {
      result.addAll(flatten(item).map((x) => x as R));
    } else {
      result.add(item as R);
    }
  }
  return result;
}

Iterable<T> adjust<T>(
    Iterable<T> elements, int index, ElementTransformer<T> transformer) {
  assert(index < elements.length);
  assert(index >= 0);
  var i = 0;
  return elements.map((element) {
    i++;
    if (i - 1 == index) {
      return transformer(element);
    }
    return element;
  });
}
