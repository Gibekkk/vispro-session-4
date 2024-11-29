import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:global_state/global_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global State Counter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CounterListPage(),
    );
  }
}

class CounterListPage extends StatelessWidget {
  const CounterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Global State Counter List'),
      ),
      body: ListView.builder(
        itemCount: globalState.counters.length,
        itemBuilder: (context, index) {
          final counter = globalState.counters[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: counter.color,
                child: Text(
                  counter.value.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(counter.label),
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
                    onPressed: () => globalState.removeCounter(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: globalState.addCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
 