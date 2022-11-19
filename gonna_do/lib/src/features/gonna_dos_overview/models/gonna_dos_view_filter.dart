import 'package:gonna_dos_repository/gonna_dos_repository.dart';

enum GonnaDosViewFilter { all, activeOnly, completedOnly }

extension GonnaDosViewFilterX on GonnaDosViewFilter {
  bool apply(GonnaDo gonnaDo) {
    switch (this) {
      case GonnaDosViewFilter.all:
        return true;
      case GonnaDosViewFilter.activeOnly:
        return !gonnaDo.isCompleted;
      case GonnaDosViewFilter.completedOnly:
        return gonnaDo.isCompleted;
    }
  }

  Iterable<GonnaDo> applyAll(Iterable<GonnaDo> gonnaDos) {
    return gonnaDos.where(apply);
  }
}
