class HeartRateCalculator {
  late List<int> _list = [];

  addValue(int value) {
    _list.add(value);
  }

  int calculate() {
    int count = 0;
    for (int i = 0; i < _list.length; i++) {
      count+= _list[i];
    }
    return count ~/ _list.length;
  }

  void cleanList() {
    _list = [];
  }
}