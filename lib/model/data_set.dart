class DataSet {
  final int highestValue;
  final List<int> data;

  String asString() {
    return data.map((i) => i.toString()).join(",");
  }

  DataSet(this.data, this.highestValue);
}
