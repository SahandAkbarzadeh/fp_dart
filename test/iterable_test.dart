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

  test('test adjust', () {
    var adjustedList = orderedNumber1to5.adjust(0, (i) => i + 1);
    expect(adjustedList, [2, 2, 3, 4, 5]);
    adjustedList =
        orderedNumber1to5.adjust(orderedNumber1to5.length - 1, (i) => i + 1);
    expect(adjustedList, [1, 2, 3, 4, 6]);
    expectAssert(() => f.adjust(orderedNumber1to5, -1, (i) => i));
    expectAssert(
        () => f.adjust(orderedNumber1to5, orderedNumber1to5.length, (i) => i));
  });
}
