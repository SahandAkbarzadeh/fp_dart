import 'package:test/test.dart';
import 'package:fp_dart/fp_dart.dart';
const orderedNumber1to5 = [1, 2, 3, 4, 5];
const allTrue = [true, true, true, true, true];
const someTrue = [true, true, false, true, true];
const someTrue2 = [false, true, false, true, true];
const allFalse = [false, false, false];
main() {
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
}
