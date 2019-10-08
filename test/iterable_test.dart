import 'package:fp_dart/src/iterable/iterable.dart' as f;
import 'package:test/test.dart';
import 'package:fp_dart/fp_dart.dart';
import 'utils.dart';

const orderedNumber1to5 = [1, 2, 3, 4, 5];
const allTrue = [true, true, true, true, true];
const someTrue = [true, true, false, true, true];
const someTrue2 = [false, true, false, true, true];
const allFalse = [false, false, false];

const List<List<num>> listWithSubListDepth1 = [
  [1, 2, 3, 4],
  [5, 6]
];

const List<List<dynamic>> listWithSubListDepth2 = [
  [1, 2, 3, 4],
  [
    5,
    [3, 4, 5]
  ]
];

const List<List<dynamic>> listWithSubListDepth2WithDynamic = [
  [1, 2, 3, 4],
  [
    5,
    [3, 4, 5, false]
  ]
];

const dynamicListWithSubListDepth2 = [
  [1, 2, 3, 4],
  [5, 6],
  4,
  5,
  [
    1,
    [2]
  ],
];

const dynamicListWithSubListDepth2WithDifferentTypes = [
  [1, 2, 3, 4],
  [5, 6],
  false,
  5,
  [
    "test",
    [2]
  ],
];

main() {
  group('iterable.all', () {
    test('test iterable<T>.all', () {
      expect(orderedNumber1to5.all((element) => element > 0), true);
      expect(orderedNumber1to5.all((element) => element < 6), true);
      expect(orderedNumber1to5.all((element) => element <= 6), true);

      expect(orderedNumber1to5.all((element) => element == 6), false);
      expect(orderedNumber1to5.all((element) => element == 1), false);
    });

    test('test iterable<bool>.all', () {
      expect(allTrue.all(), true);
    });

    test('test iterable<bool>.allTrue/allFalse', () {
      expect(allTrue.allTrue(), true);
      expect(allFalse.allTrue(), false);
      expect(someTrue.allTrue(), false);
      expect(someTrue2.allTrue(), false);

      expect(allTrue.allFalse(), false);
      expect(allFalse.allFalse(), true);
      expect(someTrue.allFalse(), false);
      expect(someTrue2.allFalse(), false);
    });
  });

  test('test iterable<Iterable<T>>.unnest', () {
    final flattedList = listWithSubListDepth1.unnest();
    expect(flattedList, [1, 2, 3, 4, 5, 6]);
  });

  test('test chain unnest', () {
    var testChainUnNest =
        [listWithSubListDepth1, listWithSubListDepth1].unnest().unnest();
    expect(testChainUnNest, [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6]);
  });

  test('test iterable<dynamic>.flatten', () {
    var flattedList1 = listWithSubListDepth1.flatten();
    expect(flattedList1, [1, 2, 3, 4, 5, 6]);
    var flattedList2 = dynamicListWithSubListDepth2.flatten();
    expect(flattedList2, [1, 2, 3, 4, 5, 6, 4, 5, 1, 2]);
    var flattedList3 = dynamicListWithSubListDepth2WithDifferentTypes.flatten();
    expect(flattedList3, [1, 2, 3, 4, 5, 6, false, 5, "test", 2]);
  });

  test('test iterable<iterable>.flatten<T>', () {
    Iterable<num> flattedList1 = listWithSubListDepth2.flatten<num>();
    expect(flattedList1, [1, 2, 3, 4, 5, 3, 4, 5]);
  });

  test('test iterable<T>.adjust', () {
    var adjustedList = orderedNumber1to5.adjust(0, (i) => i + 1);
    expect(adjustedList, [2, 2, 3, 4, 5]);
    adjustedList =
        orderedNumber1to5.adjust(orderedNumber1to5.length - 1, (i) => i + 1);
    expect(adjustedList, [1, 2, 3, 4, 6]);
    expectAssert(() => f.adjust(orderedNumber1to5, -1, (i) => i));
    expectAssert(
        () => f.adjust(orderedNumber1to5, orderedNumber1to5.length, (i) => i));
  });

  test('test iterable<T>.append', () {
    expect([1, 2, 3].append(2), [1, 2, 3, 2]);
    expect(<dynamic>[1, 2, 3].append([1]), [
      1,
      2,
      3,
      [1]
    ]);
  });

  test('test iterable<T>.flatMap', () {
    expect(
        [
          [1, 2, 3],
          [4, 5, 6]
        ].flatMap((items) => [...items]),
        [1, 2, 3, 4, 5, 6]);
  });

  test('test iterable<T>.aperture', () {
    expect([1, 2, 3, 4, 5].aperture(2), [
      [1, 2],
      [2, 3],
      [3, 4],
      [4, 5]
    ]);
    expect([1, 2, 3, 4, 5].aperture(3), [
      [1, 2, 3],
      [2, 3, 4],
      [3, 4, 5]
    ]);
    expect([1, 2, 3, 4, 5].aperture(7), []);
    expect([].aperture(1), []);
    expect([].aperture(2), []);
  });

  test('test iterable<T>.any', () {
    expect(f.any([1, 2, 3], (e) => e >= 1), true);
    expect(f.any([1, 2, 3], (e) => e >= 2), true);
    expect(f.any([1, 2, 3], (e) => e >= 3), true);
    expect(f.any([1, 2, 3], (e) => e >= 4), false);
  });

  test('test iterable<T>.concat', () {
    expect([1, 2, 3].concat([4, 5, 6]), [1, 2, 3, 4, 5, 6]);
    expect([1, 2, 3].concat([]), [1, 2, 3]);
  });

  test('test iterable<T>.combine', () {
    expect([1, 2, 3].combine([4, 5, 6]), [1, 2, 3, 4, 5, 6]);
    expect([1, 2, 3].combine([]), [1, 2, 3]);
    expect([1, 2, 3].combine([]) is Iterable<num>, true);
  });

  test('test iterable<T>.drop', () {
    expect([1, 2, 3].drop(1), [2, 3]);
    expect([1, 2].drop(1), [2]);
    expect([1, 2].drop(2), []);
    expect([1, 2].drop(3), []);
    expectException(() => [1, 2].drop(-1));
  });

  test('test iterable<T>.dropLast', () {
    expect([1, 2, 3].dropLast(1), [1, 2]);
    expect([1, 2].dropLast(1), [1]);
    expect([1, 2].dropLast(2), []);
    expect([1, 2].dropLast(3), []);
    expectAssert(() => [1, 2].dropLast(-1));
  });

  test('test iterable<T>.dropLastWhile', () {
    expect([1, 2, 3, 4, 3, 2, 1].dropLastWhile((x) => x <= 3), [1, 2, 3, 4]);
    expect([1, 2, 3, 4, 3, 2, 1].dropLastWhile((x) => true), []);
    expect([1, 2, 3].dropLastWhile((x) => false), [1, 2, 3]);
  });

  test('test iterable<T>.dropWhile', () {
    expect([1, 2, 3, 4, 3, 2, 1].dropWhile((x) => x <= 3), [4,3,2,1]);
    expect([1, 2, 3, 4, 3, 2, 1].dropWhile((x) => true), []);
    expect([1, 2, 3].dropWhile((x) => false), [1, 2, 3]);
  });

  test('test iterable<T>.dropRepeats', () {
    expect([1, 2, 3, 3, 4, 5, 5, 6].dropRepeats(), [1, 2, 3, 4, 5, 6]);
    expect([1, 1, 1, 2, 3, 4, 4, 2, 2].dropRepeats(), [1, 2, 3, 4, 2]);
  });

  test('test iterable<T>.dropRepeatsWith', () {
    expect([1, 2, 3, 3, 4, 5, 5, 6].dropRepeatsWith((l, r) => l == r),
        [1, 2, 3, 4, 5, 6]);
    expect(
        [1, -1, -1, 2, 3, 4, 4, 2, 2].dropRepeatsWith((l, r) => l.abs() == r),
        [1, 2, 3, 4, 2]);
  });
}
