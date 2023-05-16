part of 'all.dart';

class TrackPainter extends CustomPainter {
  const TrackPainter(this.color);

  final HSVColor color;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Size chessSize = Size(size.height / 2, size.height / 2);
    Paint chessPaintB = Paint()..color = const Color(0xffcccccc);
    Paint chessPaintW = Paint()..color = Colors.white;
    List.generate((size.height / chessSize.height).round(), (int y) {
      List.generate((size.width / chessSize.width).round(), (int x) {
        canvas.drawRect(
          Offset(chessSize.width * x, chessSize.width * y) & chessSize,
          (x + y) % 2 != 0 ? chessPaintW : chessPaintB,
        );
      });
    });

    final List<Color> colors = [
      color.toColor().withOpacity(0.0),
      color.toColor().withOpacity(1.0),
    ];
    Gradient gradient = LinearGradient(colors: colors);
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
