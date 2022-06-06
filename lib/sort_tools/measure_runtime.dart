extension MeasureRuntime<P, R> on R Function() {
  ValueWithRuntime<R> callAndMeasureRuntime() {
    final stopwatch = Stopwatch();
    stopwatch.start();
    final value = this.call();
    return ValueWithRuntime(value: value, runtime: stopwatch.elapsed);
  }
}

class ValueWithRuntime<T> {
  final T value;
  final Duration runtime;
  ValueWithRuntime({required this.value, required this.runtime});
}
