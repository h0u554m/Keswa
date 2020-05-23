Stream<int> numbre() async* {
  var count = 5;
  for (var i = 0; i < count; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}

void main() {
  numbre().listen((data) => print(data));
}
