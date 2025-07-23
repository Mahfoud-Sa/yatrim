import 'package:get/get.dart';

class PrayerTimesController extends GetxController {
  var mosqueName = "مسجد المحضار".obs;
  var currentDate = "الاثنين 29 فبراير 2024".obs;
  var hijriDate = "19 رمضان 1445".obs;

  var prayerTimes = [
    {"name": "الفجر", "time": "5:26 ص"},
    {"name": "الشروق", "time": "6:42 ص"},
    {"name": "الظهر", "time": "12:33 م"},
    {"name": "العصر", "time": "3:55 م"},
    {"name": "المغرب", "time": "6:25 م"},
    {"name": "العشاء", "time": "8:00 م"},
    {"name": "التراويح", "time": "8:15 م"},
    {"name": "قيام الليل", "time": "1:30 ص"},
  ].obs;

  var calculationMethod = "أم القرى".obs;
  var location = "الجمهورية اليمنية, تريم".obs;
}
