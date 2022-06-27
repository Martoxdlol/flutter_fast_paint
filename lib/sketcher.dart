import 'package:fast_paint/skecth.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Sketcher extends CustomPainter {
  final Sketch sketch;
  Sketcher({required this.sketch});

  @override
  void paint(Canvas canvas, Size size) {
    for (final layer in sketch.layers) {
      layer.draw(canvas);
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }
}



 // var p = Paint();
    // p.imageFilter = ImageFilter.blur();
    // var paint1 = Paint()
    //   ..color = Color(0xff63aa65)
    //   ..strokeWidth = 10
    //   ..imageFilter = ImageFilter.blur();
    // final _points = List<Offset>.from(points);

    // var next = _points[1];

    // if (next == null) return;

    // int r = 127;
    // int g = 255;
    // int b = 100;
    // int bb = 1;

    // final path = Path();

    // path.moveTo(points[0].dx, points[1].dy);
    // _points.removeAt(0);

    // for (final point in _points) {
    //   r = r + 1 % 255;
    //   g = (g + 254) % 255;

    //   if (b == 0) bb = 1;
    //   if (b == 255) bb = -1;
    //   b = bb + b;

    //   path.lineTo(point.dx, point.dy);

    //   paint1.color = Color.fromARGB(255, r, g, b);
    //   next = point;
    // }

    // paint1.style = PaintingStyle.stroke;

    // canvas.drawPath(path, paint1);

    // var paint1 = Paint()
    //   ..color = Color(0xff63aa65)
    //   ..strokeWidth = 10;
    // //list of points
    // var points = [
    //   Offset(50, 50),
    //   Offset(80, 70),
    //   Offset(380, 175),
    //   Offset(200, 175),
    //   Offset(150, 105),
    //   Offset(300, 75),
    //   Offset(320, 200),
    //   Offset(89, 125)
    // ];

    // final paint = Paint();
    // paint.color = Colors.red;

    // canvas.scale(num.toDouble() / 10 + 1);
    // canvas.drawRRect(RRect.fromLTRBXY(10, 10, 200, 200, 23, 56), paint);
    // print("a");
    // for (int i = 0; i < 1000000; i++) {
    //   for (int i = 0; i < 1000; i++) {
    //     325467 / 2374;
    //   }
    // }
    // print("b");

    // //draw points on canvas
    // canvas.drawRect(Rect.fromLTRB(300, 400, 500, 500), paint);
    // canvas.drawPoints(PointMode.points, points, paint1);
    // canvas.drawCircle(Offset(100 + num.toDouble(), 100), 10, paint);
    // // paint.color = Colors.green;
    // canvas.drawCircle(Offset(100, 120), 10, paint1);