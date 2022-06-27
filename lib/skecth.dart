import 'dart:ffi';

import 'package:flutter/material.dart';

class Sketch {
  final List<SketchLayer> layers = [SketchLayer()];
}

class SketchState {
  final Sketch sketch;
  int updateNum = 0;
  int _currentLayerIndex = 0;

  final void Function(int num)? onUpdate;

  SketchState(this.sketch, {this.onUpdate});
  SketchElement? currentElement;

  SketchLayer get currentLayer {
    return sketch.layers[_currentLayerIndex];
  }

  void update() {
    onUpdate!(updateNum);
    updateNum++;
  }

  void startNewElement(SketchElement element) {
    currentElement = element;
    currentLayer.addElement(const Offset(0, 0), element);
  }

  void commitElement() {
    currentElement = null;
  }

  void discardElement() {
    currentElement = null;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType is SketchState) {
      return (other as SketchState).updateNum == updateNum;
    }
    return false;
  }

  @override
  int get hashCode => updateNum;
}

class SketchElementAtPosition {
  final Offset position;
  final SketchElement element;
  SketchElementAtPosition(this.position, this.element);

  @override
  String toString() {
    return "${position.dx}, ${position.dy}: ${element.toString()}";
  }
}

class SketchLayer {
  final positionedElements = <SketchElementAtPosition>[];
  void addElement(Offset position, SketchElement element) {
    positionedElements.add(SketchElementAtPosition(position, element));
  }

  void draw(Canvas canvas) {
    for (final positionedElement in positionedElements) {
      print(positionedElement);
      positionedElement.element.draw(positionedElement.position, canvas);
    }
  }
}

abstract class SketchElement {
  void draw(Offset position, Canvas canvas);
}

class SketchDrawing extends SketchElement {
  Paint paint = Paint();

  final List<Offset> points = [];

  SketchDrawing({Color? color, bool? fill, double? width}) {
    paint.color = color ?? Colors.black;
    paint.style = fill == true ? PaintingStyle.fill : PaintingStyle.stroke;
    paint.strokeWidth = width ?? 4;
  }

  @override
  void draw(Offset position, Canvas canvas) {
    if (points.isEmpty) return;
    if (points.length == 1) {
      canvas.drawCircle(position + points[0], 1, paint);
    } else {
      var prev = points[0];
      for (int i = 1; i < points.length; i++) {
        final pos1 = position + prev;
        final pos2 = position + points[i];
        canvas.drawLine(pos1, pos2, paint);
        prev = points[i];
      }
    }
  }

  @override
  toString() {
    return "Drawing with ${this.points.length} points";
  }

  addPoint(Offset position) {
    points.add(position);
  }
}
    
// throw UnimplementedError();