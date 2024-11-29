import 'package:flutter/material.dart';

class Counter {
  final int id;
  int value;
  Color color;
  String label;

  Counter({
    required this.id,
    required this.value,
    required this.color,
    required this.label,
  });
}

class GlobalState extends ChangeNotifier {
  final List<Counter> _counters = [];

  List<Counter> get counters => _counters;

  void addCounter() {
    final newCounter = Counter(
      id: _counters.length + 1,
      value: 0,
      color: Colors.primaries[_counters.length % Colors.primaries.length],
      label: 'Counter ${_counters.length + 1}',
    );
    _counters.add(newCounter);
    notifyListeners();
  }

  void incrementCounter(int index) {
    _counters[index].value++;
    notifyListeners();
  }

  void decrementCounter(int index) {
    if (_counters[index].value > 0) {
      _counters[index].value--;
      notifyListeners();
    }
  }

  void updateCounterLabel(int index, String newLabel) {
    _counters[index].label = newLabel;
    notifyListeners();
  }

  void updateCounterColor(int index, Color newColor) {
    _counters[index].color = newColor;
    notifyListeners();
  }

  void reorderCounters(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = _counters.removeAt(oldIndex);
    _counters.insert(newIndex, item);
    notifyListeners();
  }

  void removeCounter(int index) {
  _counters.removeAt(index);
  notifyListeners();
}

}
