// home_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:yatrim/app/modules/MyEvents/model/my_event_model.dart';
import 'package:yatrim/app/modules/MyEvents/service/my_event_service.dart';

class HomeController extends GetxController {
  // --- Prayer & Location State ---
  Rx<DateTime> currentDate = DateTime.now().obs;
  var remainingTime = "03:30:45".obs;
  var prayerTime = "5:27 ص".obs;
  var fajrTime = "5:27 ص".obs;
  var location = "تريم".obs;

  // Toggles between Hijri and Gregorian calendar
  var isHijri = true.obs;
  Rx<HijriCalendar> hijriDate = HijriCalendar.now().obs;

  // --- Event State ---
  final _service = PersonalEventService();
  final box = GetStorage();
  var personalEvents = <PersonalEvent>[].obs;
  Rx<String> selectedDate = ''.obs;

  // Placeholder (legacy) events, if needed elsewhere
  var events = [
    {"name": "مقابلة عمل", "date": "1445 رمضان 1", "color": Colors.purple},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize selectedDate to today
    selectedDate.value = DateTime.now().toIso8601String().split('T').first;

    // Fetch personal events from API
    final token = box.read('token');
    if (token != null) {
      fetchEvents("token $token");
    }
  }

  /// Fetches personal events from the API and stores them
  Future<void> fetchEvents(String token) async {
    final events = await _service.getPersonalEvents(token);
    personalEvents.assignAll(events);
  }

  // --- Date Selection & Filtering ---
  /// Called when a calendar cell is tapped
  void onDateSelected(DateTime date) {
    selectedDate.value = date.toIso8601String().split('T').first;
  }

  /// Returns all personal events matching [date] (YYYY-MM-DD)
  List<PersonalEvent> eventsFor(String date) =>
      personalEvents.where((e) => e.dateOnly == date).toList();

  /// Returns true if there's at least one event on [date]
  bool hasEvent(String date) => eventsFor(date).isNotEmpty;

  // --- Calendar Utilities ---
  /// Toggle between Hijri and Gregorian calendars
  void toggleCalendarType() => isHijri.value = !isHijri.value;

  /// Number of days in the current month
  int get daysInMonth => isHijri.value
      ? hijriDate.value.lengthOfMonth
      : DateUtils.getDaysInMonth(
          currentDate.value.year,
          currentDate.value.month,
        );

  /// First weekday of current Gregorian month (0 = Saturday)
  int get firstWeekdayOfMonth =>
      (DateTime(currentDate.value.year, currentDate.value.month, 1).weekday -
          6) %
      7;

  /// The first day of the month as a DateTime
  DateTime get firstDayOfMonth => isHijri.value
      ? HijriCalendar().hijriToGregorian(
          hijriDate.value.hYear,
          hijriDate.value.hMonth,
          1,
        )
      : DateTime(
          currentDate.value.year,
          currentDate.value.month,
          1,
        );

  /// Generates the list of dates to display in the calendar grid
  List<DateTime> get calendarDates {
    // Weeks start on Saturday (weekday==6), so calculate offset
    int offset = (firstDayOfMonth.weekday - 6) % 7;
    DateTime start = firstDayOfMonth.subtract(Duration(days: offset));
    int totalDays = offset + daysInMonth;
    return List.generate(
      totalDays,
      (i) => start.add(Duration(days: i)),
    );
  }

  /// Move month by [monthOffset] (positive or negative)
  void updateMonth(int monthOffset) {
    if (isHijri.value) {
      // Advance Hijri month, then update Gregorian
      final newHijriDate = HijriCalendar.fromDate(
        HijriCalendar().hijriToGregorian(
          hijriDate.value.hYear,
          hijriDate.value.hMonth + monthOffset,
          1,
        ),
      );
      hijriDate.value = newHijriDate;
      currentDate.value = newHijriDate.hijriToGregorian(
        newHijriDate.hYear,
        newHijriDate.hMonth,
        newHijriDate.hDay,
      );
    } else {
      // Advance Gregorian month
      currentDate.value = DateTime(
        currentDate.value.year,
        currentDate.value.month + monthOffset,
        1,
      );
      hijriDate.value = HijriCalendar.fromDate(currentDate.value);
    }
  }
}
