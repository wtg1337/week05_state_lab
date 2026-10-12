import 'package:flutter/material.dart';

void main() => runApp(const Week05App());

class Week05App extends StatelessWidget {
  const Week05App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<String> _titles = ['5주차 강의 복습', '상태 흐름도 작성'];

  // AC1: 두 항목의 완료 여부를 false로 시작하는 원본 상태 보관
  final List<bool> _done = [false, false];

  // AC3: 완료되지 않은 항목의 수를 원본 상태(_done)에서 계산 (별도 저장 X)
  int get _remaining {
    return _done.where((done) => !done).length;
  }

  // AC2: setState 안에서 해당 항목의 완료 여부를 토글(반전)
  void _toggleDone(int index) {
    setState(() {
      _done[index] = !_done[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('나의 할 일')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('남은 할 일: $_remaining',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          for (var i = 0; i < _titles.length; i++)
            Card(
              child: ListTile(
                title: Text(
                  _titles[i],
                  style: TextStyle(
                    decoration: _done[i]
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                // AC2: 완료 여부에 따라 아이콘/문구 변경 및 클릭 이벤트 연결
                trailing: TextButton.icon(
                  onPressed: () => _toggleDone(i),
                  icon: Icon(
                    _done[i] ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: _done[i] ? Colors.teal : Colors.grey,
                  ),
                  label: Text(_done[i] ? '취소' : '완료'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}