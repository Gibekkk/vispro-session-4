import 'package:flutter/material.dart';
import 'counter.dart'; // Mengimpor definisi Counter

class GlobalState extends ChangeNotifier {
  // Daftar counters
  final List<Counter> _counters = [];

  // Getter untuk daftar counter
  List<Counter> get counters => List.unmodifiable(_counters);

  // Menambahkan counter baru
  void addCounter() {
    _counters.add(Counter(id: DateTime.now().toString())); // ID unik menggunakan timestamp
    notifyListeners(); // Memperbarui UI
  }

  // Menghapus counter berdasarkan index
  void removeCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters.removeAt(index);
      notifyListeners(); // Memperbarui UI
    }
  }

  // Increment nilai counter
  void incrementCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters[index].value++;
      notifyListeners(); // Memperbarui UI
    }
  }

  // Decrement nilai counter
  void decrementCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      if (_counters[index].value > 0) {
        _counters[index].value--;
        notifyListeners(); // Memperbarui UI
      }
    }
  }

  // Mengubah warna counter
  void updateCounterColor(int index, Color color) {
    if (index >= 0 && index < _counters.length) {
      _counters[index].color = color;
      notifyListeners(); // Memperbarui UI
    }
  }

  // Mengubah label counter
  void updateCounterLabel(int index, String label) {
    if (index >= 0 && index < _counters.length) {
      _counters[index].label = label;
      notifyListeners(); // Memperbarui UI
    }
  }
}
