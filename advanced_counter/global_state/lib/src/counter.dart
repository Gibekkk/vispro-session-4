import 'package:flutter/material.dart';
class Counter {
  int value; // Nilai counter
  String label; // Label untuk counter
  String id; // ID unik untuk identifikasi
  // Default warna counter
  Color color;

  Counter({
    this.value = 0,
    this.label = "Counter",
    required this.id, // Setiap counter harus memiliki ID unik
    this.color = const Color(0xFF2196F3), // Default: biru
  });
}
