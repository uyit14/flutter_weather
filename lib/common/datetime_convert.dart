import 'package:intl/intl.dart';
class DateTimeConvert{
   static String timeStampToDate(int timeStamp){
     var date = DateTime.fromMicrosecondsSinceEpoch(timeStamp);
    String dhmFormat = DateFormat("EEE, HH:mm").format(date);
    return dhmFormat;
  }
}