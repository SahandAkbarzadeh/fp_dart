import 'package:test/test.dart';
import 'package:fp_dart/fp_dart.dart';

main() {

  test('test iterable.all', () {
    var a = [1,2,3,4,5];
    expect(a.all((element) => element > 0), true);
    expect(a.all((element) => element < 6), true);
    expect(a.all((element) => element <= 6), true);

    expect(a.all((element) => element == 6), false);
    expect(a.all((element) => element == 1), false);
  });

}