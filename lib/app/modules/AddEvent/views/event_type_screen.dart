// event_type_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/modules/events/model/events_model.dart';
import 'package:yatrim/app/modules/events/service/events_service.dart';

/// Utility to convert hex string to [Color]
Color colorFromHex(String hexColor) {
  final buffer = StringBuffer();
  if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
  buffer.write(hexColor.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

class EventTypeController extends GetxController {
  /// القيمة الافتراضية (مثلاً أول نوع إذا موجود)
  var selectedEventType = RxnInt();

  final EventService _eventService = EventService();

  /// قائمة أنواع المناسبات
  var eventTypes = <EventType>[].obs;

  /// حالة التحميل
  var isLoading = false.obs;

  /// رسالة الخطأ في حال فشل التحميل
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEventTypes();
  }

  /// يجلب جميع أنواع المناسبات من الـ API
  Future<void> fetchEventTypes() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final types = await _eventService.fetchAllEventTypes();
      eventTypes.assignAll(types);
      // إذا لم يحدد المستخدم شيئًا، اعين القيمة الافتراضية
      if (eventTypes.isNotEmpty && selectedEventType.value == null) {
        selectedEventType.value = eventTypes.first.id;
      }
    } catch (e) {
      errorMessage.value = 'فشل في تحميل أنواع المناسبات';
      print('Error fetching event types: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

class EventTypeScreen extends StatelessWidget {
  final EventTypeController controller = Get.put(EventTypeController());

  /// يمكن تمرير قيمة ابتدائية
  final int? initialSelected;
  EventTypeScreen({Key? key, this.initialSelected}) : super(key: key) {
    if (initialSelected != null) {
      controller.selectedEventType.value = initialSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // حماية: إذا القائمة فارغة، ارجع بدون نتيجة
        if (controller.eventTypes.isEmpty) {
          Get.back();
          return false;
        }
        final selectedId = controller.selectedEventType.value!;
        final selectedEvent = controller.eventTypes.firstWhere(
          (e) => e.id == selectedId,
          orElse: () => controller.eventTypes.first,
        );
        Get.back(result: selectedEvent);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("نوع الحدث"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // حماية: إذا القائمة فارغة، ارجع بدون نتيجة
              if (controller.eventTypes.isEmpty) {
                Get.back();
                return;
              }
              final selectedId = controller.selectedEventType.value!;
              final selectedEvent = controller.eventTypes.firstWhere(
                (e) => e.id == selectedId,
                orElse: () => controller.eventTypes.first,
              );
              Get.back(result: selectedEvent.id);
            },
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }
          if (controller.eventTypes.isEmpty) {
            return const Center(child: Text('لا توجد أنواع مناسبات'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              itemCount: controller.eventTypes.length,
              itemBuilder: (context, index) {
                final eventType = controller.eventTypes[index];
                return Obx(() {
                  final isSelected =
                      controller.selectedEventType.value == eventType.id;
                  return GestureDetector(
                    onTap: () =>
                        controller.selectedEventType.value = eventType.id,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: colorFromHex(eventType.color),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                eventType.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected ? Colors.green : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          );
        }),
      ),
    );
  }
}
