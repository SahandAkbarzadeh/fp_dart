import 'package:test/test.dart';

typedef CallBack = void Function();

expectAssert(CallBack action) {
  try {
    action();
  } on AssertionError {
    return;
  }
  expect(1, 0);
}

expectException(CallBack action) {
  try {
    action();
  } catch(e) {
    return;
  }
  expect(1, 0);
}