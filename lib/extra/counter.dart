import 'package:flutter/cupertino.dart';

class CounterState {
  int _value = 0;

  void inc() => _value++;
  void des() => _value--;
  int get value => _value;

  bool diff(CounterState old) {
    return old._value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  CounterProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  final CounterState state = CounterState();

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.diff(state);
  }
}
