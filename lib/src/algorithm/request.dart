abstract class DifferenceRequest {
  int get oldSize;

  int get newSize;

  bool areEqual(final int oldPosition, final int newPosition);
}

class ListsDifferenceRequest<T extends Object> implements DifferenceRequest {
  final List<T> old;
  final List<T> updated;
  final EqualityCheck<T> equalityCheck;

  ListsDifferenceRequest(
    this.old,
    this.updated, {
    final EqualityCheck<T>? equalityCheck,
  }) : equalityCheck = equalityCheck ?? _defaultEquals;

  @override
  int get oldSize => old.length;

  @override
  int get newSize => updated.length;

  @override
  bool areEqual(final int oldPosition, final int newPosition) {
    return equalityCheck(old[oldPosition], updated[newPosition]);
  }
}

bool _defaultEquals(Object left, Object right) => left == right;

typedef EqualityCheck<T> = bool Function(T, T);

typedef PayloadDefinition<T> = Object Function(T, T);
