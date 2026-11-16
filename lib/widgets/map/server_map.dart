
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Region {
  final String name;
  final double cx;
  final double cy;
  final double fw;
  final double fh;

  const Region(this.name, this.cx, this.cy, this.fw, this.fh);
}

class ServerMap extends StatefulWidget {
  const ServerMap({super.key});

  @override
  State<ServerMap> createState() => _ServerMapState();
}

class _ServerMapState extends State<ServerMap> with SingleTickerProviderStateMixin {
  late final AnimationController anim;

  Matrix4 fromMatrix = Matrix4.identity();

  int? selectedIndex;
  int regionIndex = 0;

  Offset pan = Offset.zero;
  static const double panLimit = 0.08;

  Size viewSize = Size.zero;
  Size mapSize = Size.zero;

  static const double imageWidth = 4145;
  static const double imageHeight = 2850;

  static const regions = [
    Region('Europe', 0.505, 0.4567, 0.30, 0.30),
    Region('America', 0.225, 0.525, 0.35, 0.35),
    Region('Asia', 0.70, 0.50, 0.25, 0.25),
  ];

  final servers = [
    {
      'name': 'Berlin, DE',
      'flag': 'germany',
      'ping': '...',
      'x': 0.5137,
      'y': 0.4499,
    },
    {
      'name': 'Warsaw, PL',
      'flag': 'poland',
      'ping': '...',
      'x': 0.5396,
      'y': 0.4446,
    },
    {
      'name': 'Lautebourg, FR',
      'flag': 'france',
      'ping': '...',
      'x': 0.4963,
      'y': 0.4755,
    },
    {
      'name': 'Saint Louis, US',
      'flag': 'usa',
      'ping': '...',
      'x': 0.2312,
      'y': 0.5284,
    },
  ];

  @override
  void initState() {
    super.initState();

    anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  Matrix4 _matrixFor(Region r, Offset panFrac) {
    double zoom = [
      viewSize.width / (mapSize.width * r.fw),
      viewSize.height / (mapSize.height * r.fh),
    ].reduce((a, b) => a < b ? a : b);

    const double minZoom = 1.0;

    if (zoom < minZoom) zoom = minZoom;

    final double screenFactor = viewSize.width < 600 ? 2.25 : 1.0;

    zoom *= screenFactor;

    double tx = viewSize.width / 2 - zoom * mapSize.width * r.cx + panFrac.dx * viewSize.width;
    double ty = viewSize.height / 2 - zoom * mapSize.height * r.cy + panFrac.dy * viewSize.height;

    tx = tx.clamp(viewSize.width - zoom * mapSize.width, 0.0,).toDouble();
    ty = ty.clamp(viewSize.height - zoom * mapSize.height, 0.0,).toDouble();

    return Matrix4.identity()
      ..translate(tx, ty)
      ..scale(zoom);
  }

  Matrix4 _currentMatrix() {
    final target = _matrixFor(regions[regionIndex], pan);

    if (anim.isAnimating) {
      final t = Curves.easeInOutCubic.transform(anim.value);

      return Matrix4Tween(
        begin: fromMatrix,
        end: target,
      ).lerp(t);
    }

    return target;
  }

  void _goTo(int index) {
    if (index == regionIndex) return;

    fromMatrix = _currentMatrix();

    setState(() {
      regionIndex = index;
      pan = Offset.zero;
    });

    anim.forward(from: 0);
  }

  void _onPanUpdate(DragUpdateDetails d) {
    if (anim.isAnimating ||
        viewSize.width == 0 ||
        viewSize.height == 0) {
      return;
    }

    final next = pan +
        Offset(
          d.delta.dx / viewSize.width,
          d.delta.dy / viewSize.height,
        );

    setState(() {
      pan = Offset(
        next.dx.clamp(-panLimit, panLimit).toDouble(),
        next.dy.clamp(-panLimit, panLimit).toDouble(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = [
          constraints.maxWidth / imageWidth,
          constraints.maxHeight / imageHeight,
        ].reduce((a, b) => a > b ? a : b);

        final width = imageWidth * scale;
        final height = imageHeight * scale;

        viewSize = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );

        mapSize = Size(width, height);

        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanUpdate: _onPanUpdate,
              child: ClipRect(
                child: AnimatedBuilder(
                  animation: anim,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.topLeft,
                      transform: _currentMatrix(),
                      child: child,
                    );
                  },
                  child: OverflowBox(
                    alignment: Alignment.topLeft,
                    minWidth: width,
                    maxWidth: width,
                    minHeight: height,
                    maxHeight: height,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: Opacity(
                              opacity: 0.05,
                              child: Image.asset(
                                'lib/assets/icons/maps/map.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          ...servers.asMap().entries.map((entry) {
                            final index = entry.key;
                            final server = entry.value;

                            const markerWidth = 50.0;
                            const circleSize = 10.0;

                            return Positioned(
                              left: width * (server['x'] as double) - markerWidth / 2,
                              top: height * (server['y'] as double) - circleSize / 2,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: SizedBox(
                                  width: markerWidth,
                                  child: _marker(
                                    server['flag'] as String,
                                    server['name'] as String,
                                    server['ping'] as String,
                                    selectedIndex == index,
                                    circleSize,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: constraints.maxWidth < 600 ? 10 : 20,
              left: constraints.maxWidth < 600 ? 10 : null,
              right: constraints.maxWidth < 600 ? 10 : 20,
              child: Container(
                width: constraints.maxWidth < 600 ? double.infinity : null,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: constraints.maxWidth < 600
                      ? MainAxisSize.max
                      : MainAxisSize.min,
                  children: List.generate(regions.length, (i) {
                    final active = i == regionIndex;

                    final button = GestureDetector(
                      onTap: () => _goTo(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 21,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: active
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          regions[i].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: active ? Colors.black : Colors.white,
                            fontWeight: active
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );

                    return constraints.maxWidth < 600
                        ? Expanded(child: button)
                        : button;
                  }),
                ),
              ),
            ),

          
          ],
        );
      },
    );
  }

  Widget _marker(
    String flag,
    String name,
    String ping,
    bool selected,
    double circleSize,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(
                alpha: selected ? 0.9 : 0.4,
              ),
              width: selected ? 1.5 : 0.7,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: ClipOval(
              child: SvgPicture.asset(
                'lib/assets/icons/flags/$flag.svg',
                width: 16,
                height: 16,
                fit: BoxFit.cover,
                placeholderBuilder: (context) {
                  return const SizedBox(
                    width: 16,
                    height: 16,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        const SizedBox(height: 2),

        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 4,
          ),
        ),

        Text(
          ping,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 3,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    anim.dispose();
    super.dispose();
  }
}