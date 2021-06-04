import 'package:exif/exif.dart';

double parseLatLon(IfdTag tag){
  final values = tag.values!;
  final degreesRatio = values[0] as Ratio;
  final minutesRatio = values[1] as Ratio;
  final secondsRatio = values[2] as Ratio;

  return degreesRatio.numerator.toDouble()/degreesRatio.denominator.toDouble()
      + (minutesRatio.numerator.toDouble()/minutesRatio.denominator.toDouble())/60.0
      + (secondsRatio.numerator.toDouble()/secondsRatio.denominator.toDouble())/3600.0;
}