import '../internal/extensions.dart';

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

Iterable<T> append<T>(Iterable<T> elements, T element) {
  return [...elements, element];
}

Iterable<T> flatMap<T>(Iterable<Iterable<T>> elements,
        ElementTransformer<Iterable<T>> transformer) =>
    unnest(elements.map(transformer));

Iterable<Iterable<T>> aperture<T>(Iterable<T> elements, int size) {
  List<Iterable<T>> _result = [];
  var idx = 0;
  var limit = elements.length - (size - 1);
  (limit >= 0 ? limit : 0).forEach((_) => _result.add([]));
  var _items = elements.toList();
  while(idx < limit) {
    _result[idx] = _items.getRange(idx, idx + size);
    idx++;
  }
  return _result;
}