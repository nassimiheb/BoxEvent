import 'package:hackin/src/SearchBarState.dart';

typedef bool ActivePredicate(SearchBarState state);

class AutoActive {
  const AutoActive._(this.shouldActivate);
  final ActivePredicate shouldActivate;

  static get on => AutoActive._((_) => true);
  static get off => AutoActive._((_) => false);
  static get ifQuery => AutoActive._((state) => state.queryNotEmpty);
}
