import 'iterable.dart' as f;

extension FunctionalList<T> on Iterable<T> {
  bool all(f.ElementTester<T> test) => f.all(this, test);

  Iterable<R> flatten<R>() => f.flatten<R, T>(this);

  Iterable<T> adjust(int index, f.ElementTransformer<T> transformer) =>
      f.adjust(this, index, transformer);

  Iterable<T> append(T element) => f.append(this, element);

  Iterable<Iterable<T>> aperture(int size) => f.aperture(this, size);
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
