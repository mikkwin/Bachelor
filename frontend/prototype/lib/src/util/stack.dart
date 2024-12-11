class ListStack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  void addAll(List<E> list) => _list.addAll(list);

  E pop() => _list.removeLast();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}