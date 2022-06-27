import 'dart:ui';

import 'package:fast_paint/skecth.dart';
import 'package:fast_paint/sketcher.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
        home: Home(),
        color: Colors.white,
        theme: ThemeData(
          visualDensity: VisualDensity.standard,
          focusTheme: FocusThemeData(
            glowFactor: is10footScreen() ? 2.0 : 0.0,
          ),
        ));
  }
}

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final updateNum = useState(0);

    final sketch = useMemoized(() => Sketch());
    final state = useMemoized(() =>
        SketchState(sketch, onUpdate: (int num) => updateNum.value = num));

    print(updateNum.value);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
            child: Container(
          width: width,
          height: height,
          child: GestureDetector(
            onPanStart: (details) {
              state.startNewElement(SketchDrawing(color: Colors.white)
                ..addPoint(details.localPosition));
              state.update();
            },
            onPanUpdate: (details) {
              if (state.currentElement != null &&
                  state.currentElement.runtimeType == SketchDrawing) {
                (state.currentElement as SketchDrawing)
                    .addPoint(details.localPosition);
              }
              state.update();
            },
            onPanEnd: (details) {
              state.commitElement();
              state.update();
            },
            child: RepaintBoundary(
              child: CustomPaint(
                painter: Sketcher(sketch: state.sketch),
              ),
            ),
          ),
        )),
        Positioned(
            child: Container(
          color: Colors.blue.dark,
          width: width,
          // height: 200,
          child: TopCommandBar(),
        ))
      ],
    );
  }
}

class TopCommandBar extends StatelessWidget {
  const TopCommandBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommandBar(
      mainAxisAlignment: MainAxisAlignment.end,
      overflowBehavior: CommandBarOverflowBehavior.dynamicOverflow,
      compactBreakpointWidth: 768,
      primaryItems: [
        CommandBarButton(
          icon: const Icon(FluentIcons.add),
          label: const Text('Add'),
          onPressed: () {},
        ),
        CommandBarButton(
          icon: const Icon(FluentIcons.edit),
          label: const Text('Edit'),
          onPressed: () {},
        ),
        CommandBarButton(
          icon: const Icon(FluentIcons.delete),
          label: const Text('Edit'),
          onPressed: () {},
        ),
      ],
      secondaryItems: [
        CommandBarButton(
          icon: const Icon(FluentIcons.archive),
          label: const Text('Archive'),
          onPressed: () {},
        ),
        CommandBarButton(
          icon: const Icon(FluentIcons.move),
          label: const Text('Move'),
          onPressed: () {},
        ),
      ],
    );
  }
}
