import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:global_state/global_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GlobalState(),
      child: MaterialApp(
        title: 'Advanced Counter App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const CounterListScreen(),
      ),
    );
  }
}

class CounterListScreen extends StatelessWidget {
  const CounterListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Counter App'),
      ),
      body: globalState.counters.isEmpty
          ? const Center(child: Text('No counters available! Add some!'))
          : ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                globalState.reorderCounters(oldIndex, newIndex); // Reorder counters
              },
              children: [
                for (int i = 0; i < globalState.counters.length; i++)
                  CounterTile(
                    key: ValueKey(globalState.counters[i].id),
                    index: i,
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          globalState.addCounter(); // Tambah counter baru
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Counter',
      ),
    );
  }
}

class CounterTile extends StatelessWidget {
  final int index;

  const CounterTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    final counter = globalState.counters[index];

    return Card(
      key: ValueKey(counter.id),
      color: counter.color,
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: counter.label,
                onFieldSubmitted: (value) =>
                    globalState.updateCounterLabel(index, value),
                decoration: const InputDecoration(
                  labelText: 'Label',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: () async {
                final color = await showDialog<Color>(
                  context: context,
                  builder: (_) =>
                      ColorPickerDialog(currentColor: counter.color),
                );
                if (color != null) {
                  globalState.updateCounterColor(index, color);
                }
              },
            ),
          ],
        ),
        subtitle: Text(
          'Value: ${counter.value}',
          style: const TextStyle(fontSize: 16),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => globalState.decrementCounter(index),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => globalState.incrementCounter(index),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => globalState.removeCounter(index), // Tombol hapus
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerDialog extends StatelessWidget {
  final Color currentColor;

  const ColorPickerDialog({Key? key, required this.currentColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color selectedColor = currentColor;

    return AlertDialog(
      title: const Text('Pick a Color'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: currentColor,
          onColorChanged: (color) {
            selectedColor = color;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(selectedColor),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
