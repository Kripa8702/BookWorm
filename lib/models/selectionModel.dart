class Selection {
  static const EXCHANGE = Selection._(name: 'EXCHANGE');
  static const SELL = Selection._(name: 'SELL');
  static const RENT = Selection._(name: 'RENT');

  static const LIST = const [EXCHANGE, SELL, RENT];

  final String name;

  int index() => LIST.indexOf(this);

  const Selection._({required this.name});
}