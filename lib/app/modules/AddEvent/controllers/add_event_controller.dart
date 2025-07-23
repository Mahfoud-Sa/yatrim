import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yatrim/app/modules/AddEvent/model/event_type_model.dart';
import 'package:yatrim/app/modules/AddEvent/service/add_event_service.dart';

class AddEventController extends GetxController {
  final PersonalEventService _eventService = PersonalEventService();
  final PersonalEventService _personalEventService = PersonalEventService();
  final box = GetStorage();
  var eventTypes = [].obs;
  var department = [].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedEventType = ''.obs;

  // Event properties
  var eventName = ''.obs;
  var eventDate = DateTime.now().obs;
  var eventTime = TimeOfDay.now().obs;
  var endDate = DateTime.now().obs;
  var notificationTime = ''.obs;
  var repeatType = ''.obs;
  var eventType = ''.obs;
  var details = ''.obs;

  // Validation errors
  var eventNameError = ''.obs;
  var eventDateError = ''.obs;
  var endDateError = ''.obs;
  var eventTypeError = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // إضافة مناسبة جديدة
  Future<void> addEvent() async {
    isLoading.value = true;

    final DateTime combinedDateTime = DateTime(
      eventDate.value.year,
      eventDate.value.month,
      eventDate.value.day,
      eventTime.value.hour,
      eventTime.value.minute,
    );

    final String isoDateTime = combinedDateTime.toIso8601String();

    final String endDateFormatted =
        "${endDate.value.year.toString().padLeft(4, '0')}-${endDate.value.month.toString().padLeft(2, '0')}-${endDate.value.day.toString().padLeft(2, '0')}";

    PersonalEvent newEvent = PersonalEvent(
      name: eventName.value,
      description: details.value,
      dateTime: isoDateTime,
      dateEnd: endDateFormatted,
      typeEvent: eventType.value.isEmpty ? '1' : eventType.value,
      typeLoop: getRepeatType(repeatType.value),
    );

    print(newEvent.toJson());

    final response = await _personalEventService.createPersonalEvent(
        newEvent, box.read("token"));
    isLoading.value = false;

    if (response.statusCode == 201) {
      Get.snackbar("نجاح", "تمت إضافة المناسبة بنجاح");
      resetEvent();
    } else {
      Get.snackbar("خطأ", "حدث خطأ أثناء إضافة المناسبة: ${response.body}");
      print(response.body);
    }
  }

  // تحويل نص التكرار إلى رقم حسب API
  int getRepeatType(String type) {
    switch (type) {
      case 'يومي':
        return 2;
      case 'أسبوعي':
        return 3;
      case 'شهري':
        return 4;
      case 'سنوي':
        return 5;
      default:
        return 1; // بدون تكرار
    }
  }

  // إعادة ضبط البيانات بعد الإضافة
  void resetEvent() {
    eventName.value = '';
    eventDate.value = DateTime.now();
    eventTime.value = TimeOfDay.now();
    endDate.value = DateTime.now();
    notificationTime.value = '';
    repeatType.value = '';
    eventType.value = '';
    details.value = '';
    clearErrors();
  }

  // التحقق من صحة البيانات
  bool validateFields() {
    clearErrors(); // مسح الأخطاء قبل التحقق

    if (eventName.value.trim().isEmpty) {
      eventNameError.value = 'اسم الحدث مطلوب';
    }

    if (eventDate.value.isBefore(DateTime.now())) {
      eventDateError.value = 'تاريخ الحدث يجب أن يكون في المستقبل';
    }

    if (endDate.value.isBefore(eventDate.value)) {
      endDateError.value = 'تاريخ الانتهاء يجب أن يكون بعد تاريخ البدء';
    }

    if (eventType.value.trim().isEmpty) {
      eventTypeError.value = 'نوع الحدث مطلوب';
    }

    return eventNameError.value.isEmpty &&
        eventDateError.value.isEmpty &&
        endDateError.value.isEmpty &&
        eventTypeError.value.isEmpty;
  }

  // مسح الأخطاء
  void clearErrors() {
    eventNameError.value = '';
    eventDateError.value = '';
    endDateError.value = '';
    eventTypeError.value = '';
  }
}
