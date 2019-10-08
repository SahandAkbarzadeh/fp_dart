import 'iterable.dart' as f;

extension FunctionalList<T> on Iterable<T> {
  bool all(f.ElementTester<T> test) => f.all(this, test);

  Iterable<R> flatten<R>() => f.flatten<R, T>(this);

  Iterable<T> adjust(int index, f.ElementTransformer<T> transformer) =>
      f.adjust(this, index, transformer);

  Iterable<T> append(T element) => f.append(this, element);

  Iterable<Iterable<T>> aperture(int size) => f.aperture(this, size);

  Iterable<T> combine(Iterable<T> other) => f.combine(this, other);

  Iterable<T> drop(int n) => f.drop(this, n);

  Iterable<T> dropLast(int n) => f.dropLast(this, n);

  Iterable<T> dropLastWhile(f.ElementTester<T> tester) =>
      f.dropLastWhile(this, tester);

  Iterable<T> dropWhile(f.ElementTester<T> tester) => f.dropWhile(this, tester);

  Iterable<T> dropRepeats() => f.dropRepeats(this);

  Iterable<T> dropRepeatsWith(f.TwoElementsComparer<T, dynamic> comparer) =>
      f.dropRepeatsWith(this, comparer);

  bool endsWith(T element) => f.endsWith(this, element);
}

extension FunctionalListConcat<R, T extends R> on Iterable<T> {
  Iterable<R> concat<B extends R>(Iterable<B> other) =>
      f.concat<T, B, R>(this, other);
}

extension FunctionalListBool on Iterable<bool> {
  bool all() => f.all(this, f.allTrue);

  bool allTrue() => this.all();

  bool allFalse() => f.all(this, f.allFalse);
}

extension FunctionalListNested<T> on Iterable<Iterable<T>> {
  Iterable<T> unnest() => f.unnest(this);
  Iterable<T> flatMap(f.ElementTransformer<Iterable<T>> transformer) =>
      f.flatMap(this, transformer);
}
