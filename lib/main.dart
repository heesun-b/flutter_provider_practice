import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increament() {
    state++;
  }

  void decrease() {
    state--;
  }
}

final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(child: HeaderPage()),
            Expanded(child: BottomPage()),
            // 함수 넘길 떄 함수 이름만 넘기는 게 가능한 이유 : 다트는 함수를 변수에 담을 수 있어서
          ],
        ),
      ),
    );
  }
}

class HeaderPage extends ConsumerWidget {
  // 전달 받는 변수 = 매개변수 , 생성자로 받는 이유 : 초기화할 때 쓰려고

  HeaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int value = ref.watch(counterProvider);

    return Container(
      color: Colors.red,
      child: Align(
          child: Consumer(
          builder: (context, ref, child) {
        final int num = ref.watch(counterProvider);
        return Text(
          "$value",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 100,
              decoration: TextDecoration.none),
        );
      })),
    );
  }
}

class BottomPage extends ConsumerWidget {
  BottomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider.notifier);
    return Container(
      color: Colors.blue,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                counter.increament();
              },
              child: Text(
                "증가",
                style: TextStyle(fontSize: 70),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                counter.decrease();
              },
              child: Text(
                "감소",
                style: TextStyle(fontSize: 70),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
