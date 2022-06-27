import 'package:fluent_ui/fluent_ui.dart';

class LinearFunction {
  final double m;
  final double b;
  LinearFunction(this.m, this.b);

  Offset intersectWith(LinearFunction other) {
    // a * x + b = a2 * x + b2
    // a * x + b - b2 = a2 * x
    // (a - a2) * x = -b + b2
    // (-b + b2) / (a - a2) = x
    double x = (-b + other.b) / (m - other.m);
    double y = calc(x);
    return Offset(x, y);
  }

  static LinearFunction fromPoints(Offset p1, Offset p2) {
    double m = (p1.dy - p2.dy) / (p1.dx - p2.dx);
    double b = p1.dy - m * p1.dx;
    return LinearFunction(m, b);
  }

  calc(double x) {
    return m * x + b;
  }

  @override
  toString() {
    return '$m*x + $b';
  }
}
