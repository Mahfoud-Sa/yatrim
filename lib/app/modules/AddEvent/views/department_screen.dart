import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/data/event_loop.dart';

class RepetitionController extends GetxController {
  var selectedRepetition = 1.obs; // القيمة الافتراضية "بدون تكرار"
}

class RepetitionScreen extends StatelessWidget {
  final String? initialRepeat;
  final RepetitionController controller = Get.put(RepetitionController());

  RepetitionScreen({super.key, this.initialRepeat}) {
    // إذا كان هناك قيمة ابتدائية، يمكن تعيينها هنا:
    if (initialRepeat != null && initialRepeat!.isNotEmpty) {
      int mappedId = 1; // افتراضي "بدون تكرار"
      if (initialRepeat == 'يومي') {
        mappedId = 2;
      } else if (initialRepeat == 'أسبوعي') {
        mappedId = 3;
      } else if (initialRepeat == 'شهري') {
        mappedId = 4;
      } else if (initialRepeat == 'سنوي') {
        mappedId = 5;
      }
      controller.selectedRepetition.value = mappedId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // عند الرجوع، يتم إعادة القيمة المختارة إلى الصفحة السابقة.
      onWillPop: () async {
        final selectedId = controller.selectedRepetition.value;
        final repetition = Repetition.values.firstWhere(
          (r) => r.id == selectedId,
          orElse: () => Repetition.values[0],
        );
        Get.back(result: repetition.name);
        return false; // منع الرجوع التلقائي
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("التكرار"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              final selectedId = controller.selectedRepetition.value;
              final repetition = Repetition.values.firstWhere(
                (r) => r.id == selectedId,
                orElse: () => Repetition.values[0],
              );
              Get.back(result: repetition.name);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                // هنا لا نقوم بتغليف ListView.builder بالكامل بـ Obx،
                // بل نغلف كل عنصر داخل itemBuilder بـ Obx حتى يتم تحديثه عند تغير المتغير.
                child: ListView.builder(
                  itemCount: Repetition.values.length,
                  itemBuilder: (context, index) {
                    final repetition = Repetition.values[index];
                    return Obx(() {
                      final isSelected =
                          controller.selectedRepetition.value == repetition.id;
                      return buildRepetitionOption(
                        label: repetition.name,
                        repetitionId: repetition.id,
                        isSelected: isSelected,
                        onTap: () {
                          controller.selectedRepetition.value = repetition.id;
                        },
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRepetitionOption({
    required String label,
    required int repetitionId,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
