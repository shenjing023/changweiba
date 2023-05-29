import 'package:flutter/material.dart';
import 'k_chart_config.dart';

class BullPainter extends CustomPainter {
  final List datas;
  final double selectedX;
  final double scrollX;
  final double scale;
  final bool showBorder;
  final bool showDate;
  final bool isLongPress;
  final Function? onSelected;
  BullPainter({
    required this.selectedX,
    required this.scrollX,
    this.scale = 1.0,
    this.showBorder = true,
    this.showDate = true,
    this.isLongPress = false,
    this.onSelected,
    required this.datas,
  });

  double maxValue = 3; //最大值
  double minValue = -3; //最小值
  Map? selectedMap;
  final Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    if (datas.isEmpty) {
      return;
    }
    canvas.save();
    canvas.translate(0, 20);
    _paint.color = Colors.grey[300]!;
    Size newSize = size;
    //一页放几个
    int count = size.width ~/ (candleSpace * scale);
    count = count > datas.length ? datas.length : count;
    //滚动了几个
    int scrollIndex = scrollX ~/ (candleSpace * scale) >= 0
        ? scrollX ~/ (candleSpace * scale)
        : 0;
    if (scrollIndex > datas.length - count) {
      scrollIndex = datas.length - count;
    }
    //起始位置
    int beginIndex = datas.length - count - scrollIndex;
    String beginDate = datas[beginIndex]["date"];
    String endDate = datas[beginIndex + count - 1]["date"];

    if (showDate) {
      newSize = Size(size.width, size.height - 40);
      //画日期
      drawDate(canvas, newSize, beginDate, endDate);
    }
    if (showBorder) {
      //画边框
      drawBorder(canvas, newSize);
    }

    drawBullChart(canvas, newSize, count, beginIndex);
    drawLeftText(canvas, newSize);

    // if (isLongPress) {
    //   drawCrossLine(canvas, newSize, count, beginIndex, selectedX ?? 0);
    // }

    canvas.restore();
    drawTopText(canvas, size);
  }

  drawBullChart(Canvas canvas, Size size, int count, int beginIndex) {
    double pwidth = candleSpace * scale;
    _paint.color = Colors.black;
    canvas.drawLine(Offset(0, getY(0.0, size)),
        Offset(size.width, getY(0.0, size)), _paint);
    for (var i = 0; i < count; i++) {
      Map data = datas[beginIndex + i];
      double bull = getY(data["bull"], size);
      if (data["bull"] > 0) {
        _paint.color = upColor;
      } else if (data["bull"] < 0) {
        _paint.color = dnColor;
      } else {
        _paint.color = Colors.white;
      }
      _paint.style = PaintingStyle.fill;

      double linex = pwidth * i + pwidth / 2;
      // double y = getY(data["bull"], size);
      canvas.drawLine(
          Offset(linex, bull), Offset(linex, getY(0, size)), _paint);
    }
  }

  drawBorder(Canvas canvas, Size size) {
    _paint.color = Colors.grey[200]!;
    //画边框
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), _paint);
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), _paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), _paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, size.height), _paint);
  }

  drawLeftText(Canvas canvas, Size size) {
    TextSpan span = TextSpan(
        text: maxValue.toStringAsFixed(2),
        style: TextStyle(color: Colors.grey, fontSize: leftFontSize));
    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, const Offset(2, 2));
    TextSpan span2 = TextSpan(
        text: minValue.toStringAsFixed(2),
        style: TextStyle(color: Colors.grey, fontSize: leftFontSize));
    TextPainter tp2 =
        TextPainter(text: span2, textDirection: TextDirection.ltr);
    tp2.layout();
    tp2.paint(canvas, Offset(2, size.height - 15));
  }

  drawCrossLine(Canvas canvas, Size size, int count, int beginIndex, double x) {
    Paint _paint = Paint()
      ..color = crossLineColor
      ..strokeCap = StrokeCap.square
      ..isAntiAlias = true
      ..strokeWidth = crossLineWidth
      ..style = PaintingStyle.stroke;

    if (x > size.width) {
      x = size.width;
    }
    if (x <= 0) {
      x = 0;
    }

    //double y = getY(data[getIndex(x, size)]["price"],size);
    int index = getIndex(x, size, datas);
    String time = datas[index + beginIndex]["date"];
    onSelected?.call(datas[index + beginIndex]);
    selectedMap = datas[index + beginIndex];
    double pwidth = candleSpace * scale;
    double sx = index * pwidth + pwidth / 2;
    canvas.drawLine(Offset(sx, 0), Offset(sx, size.height), _paint);

    //画选中时间框和时间text
    _paint
      ..color = timePriceMarkColor
      ..style = PaintingStyle.fill;

    TextSpan span = TextSpan(
        text: time,
        style: TextStyle(color: timePriceTextColor, fontSize: bottomFontSize));
    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    double cWidth = tp.width + 10;
    double cHeight = 16;
    Rect rect = Rect.fromCenter(
        center: Offset(sx, size.height + 10), width: cWidth, height: cHeight);
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)), _paint);

    tp.paint(
        canvas,
        Offset(rect.left + (cWidth - tp.width) / 2,
            rect.top + (cHeight - tp.height) / 2));
  }

  drawTopText(Canvas canvas, Size size) {
    String title1 = "BULL";

    double fontSize = topFontSize;
    TextSpan span1 = TextSpan(
        text: title1,
        style: TextStyle(color: kValue1Color, fontSize: fontSize));
    TextSpan span = TextSpan(children: [span1]);
    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, const Offset(2, 2));
  }

  drawDate(Canvas canvas, Size size, String beginDate, String endDate) {
    TextStyle style = TextStyle(color: Colors.grey, fontSize: bottomFontSize);
    TextSpan span = TextSpan(text: beginDate, style: style);
    TextSpan span2 = TextSpan(text: endDate, style: style);
    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    TextPainter tp2 =
        TextPainter(text: span2, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(2, size.height));
    tp2.layout();
    tp2.paint(canvas, Offset(size.width - tp2.width, size.height));
  }

  int getIndex(double x, Size size, List data) {
    double pwidth = candleSpace * scale;
    int index = x ~/ pwidth - 1;
    if (index > lineChartCount - 1) {
      index = lineChartCount - 1;
    }
    if (index < 0) {
      index = 0;
    }

    if (index > data.length - 1) {
      index = data.length - 1;
    }
    return index;
  }

  double getVolY(double value, Size size) {
    return size.height * (1 - (value / maxValue));
  }

  double getY(double value, Size size) {
    double d = maxValue - minValue;
    double currentD = value - minValue;
    double p = 1 - currentD / d;
    return size.height * p;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}
