import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';
import 'package:yatrim/app/modules/events/model/events_model.dart';
import 'package:yatrim/app/routes/app_pages.dart';
import '../controllers/events_controller.dart';

class EventsView extends GetView<EventsController> {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(
        LanguageController()); // Assuming LanguageController is available

    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.EDIT_PROFILE);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, color: Colors.grey),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.green),
          onPressed: () {
            Get.toNamed(Routes.SETTINGS);
          },
        ),
        title: Center(
          child: Text(
            languageController.translate('sufi_events'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 160,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF00bb6e),
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset("assets/icons/Filter.svg"),
              Obx(() => buildFilterOption(
                    context,
                    languageController.translate('event_type'),
                    controller.departmentNames,
                    "type",
                  )),
              Obx(() => buildFilterOption(
                    context,
                    languageController.translate('event_location'),
                    controller.cityNames,
                    "location",
                  )),
              buildFilterOption(
                context,
                languageController.translate('date_type'),
                [
                  {
                    'displayText': languageController.translate('all'),
                    'value': 'all'
                  },
                  {
                    'displayText': languageController.translate('hijri'),
                    'value': 0
                  },
                  {
                    'displayText': languageController.translate('gregorian'),
                    'value': 1
                  },
                ],
                "dateType",
              ),
            ],
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredEvents.isEmpty) {
                return Center(
                  child: Text(
                    languageController.translate('no_events_available'),
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: controller.filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = controller.filteredEvents[index];
                  return EventCard(event: event);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildFilterOption(
    BuildContext context,
    String title,
    List<dynamic> options,
    String key,
  ) {
    final languageController = Get.put(LanguageController());
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/green_filter.svg'),
                      const SizedBox(width: 16),
                      Text(
                        languageController.translate('filter_by') + title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...options.map((option) => ListTile(
                        title: Text(
                          option['displayText'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          controller.updateFilter(key, option['value']);
                          Navigator.pop(context);
                        },
                      )),
                ],
              ),
            ),
          );
        },
      ),
      child: Text(title, style: const TextStyle(color: Colors.grey)),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.EVENT_DETAIL,
          arguments: event,
        );
      },
      child: Card(
        color: const Color(0xffFFFFFF),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    event.iamge,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.name,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111727),
                            ),
                          ),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Color(int.parse(event.eventType!.color
                                  .replaceFirst('#', '0xFF'))),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF707070),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          SvgPicture.asset(
                              'assets/icons/small_calender_card.svg'),
                          const SizedBox(width: 4),
                          Text(
                            "${event.day}/${event.month}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF00bb6e),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
