import '../internal/extensions.dart';

typedef ElementTester<T> = bool Function(T element);
typedef TwoElementsComparer<L, R> = bool Function(L left, R right);
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
      result.addAll(flatten(item as Iterable).map((x) => x as R));
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
  var _items = elements.toList();
  while (idx < limit) {
    _result.add(_items.getRange(idx, idx + size));
    idx++;
  }
  return _result;
}

bool any<T>(Iterable<T> elements, ElementTester<T> tester) =>
    elements.any(tester);

Iterable<R> concat<A extends R, B extends R, R>(
        Iterable<A> left, Iterable<B> right) =>
    <R>[...left, ...right];

/// concat with a same type
Iterable<T> combine<T>(Iterable<T> left, Iterable<T> right) =>
    [...left, ...right];

Iterable<T> drop<T>(Iterable<T> elements, int n) => elements.skip(n);

Iterable<T> dropLast<T>(Iterable<T> elements, int n) {
  assert(n >= 0);
  var takeCount = elements.length - n;
  return elements.take(takeCount < 0 ? 0 : takeCount);
}

Iterable<T> dropLastWhile<T>(Iterable<T> elements, ElementTester<T> tester) =>
    elements
        .toList(growable: false)
        .reversed
        .skipWhile(tester)
        .toList(growable: false)
        .reversed;

Iterable<T> dropWhile<T>(Iterable<T> elements, ElementTester<T> tester) =>
    elements.skipWhile(tester);

Iterable<T> dropRepeats<T>(Iterable<T> elements) =>
    dropRepeatsWith(elements, (l, r) => l == r);

Iterable<T> dropRepeatsWith<T>(
    Iterable<T> elements, TwoElementsComparer<T, dynamic> comparer) {
  // we don't use null here because null is valid value
  dynamic _lastItem = Object();
  var _result = <T>[];
  for (var element in elements) {
    if (!comparer(element, _lastItem)) {
      _result.add(element);
      _lastItem = element;
    }
  }
  return _result;
}

bool endsWith<T>(Iterable<T> elements, T element) {
  try {
    return elements.last == element;
  } on StateError {
    return false;
  }
}

T? find<T>(Iterable<T> elements, ElementTester<T> tester) =>
    elements.firstWhere(tester, orElse: () => null);

T? findLast<T>(Iterable<T> elements, ElementTester<T> tester) => elements
    .toList(growable: false)
    .reversed
    .firstWhere(tester, orElse: () => null);

int? findIndex<T>(Iterable<T> elements, ElementTester<T> tester) {
  var idx = 0;
  for (var element in elements) {
    if (tester(element)) return idx;
    idx++;
  }
  return null;
}
