import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/modules/AddEvent/views/more_options_screen.dart';
import 'package:yatrim/app/modules/MyEvents/model/my_event_model.dart';

class PersonalEventDetailView extends StatelessWidget {
  const PersonalEventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final PersonalEvent event = Get.arguments as PersonalEvent;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          event.name,
          style: TextStyle(
            color: Color(0xFF111727),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF00BB6E)),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // صورة ثابتة
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/image/personal_event.png', // ضع صورة مناسبة
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // اسم الحدث
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        event.name,
                        style: TextStyle(
                          color: Color(0xFF111727),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // الوصف
                    if (event.description != null &&
                        event.description!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          event.description!,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontSize: 14,
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // تفاصيل الحدث
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DetailColumn('نوع المناسبة', event.typeEvent.name),
                            Container(
                                color: Color(0xff707070), height: 14, width: 1),
                            DetailColumn('تكرار', getLoopText(event.typeLoop)),
                            Container(
                                color: Color(0xff707070), height: 14, width: 1),
                            DetailColumn('تاريخ البداية', event.dateOnly),
                            Container(
                                color: Color(0xff707070), height: 14, width: 1),
                            DetailColumn('الوقت', event.timeOnly),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DetailColumn('تاريخ الانتهاء', event.dateEnd),
                            Container(
                                color: Color(0xff707070), height: 14, width: 1),
                            DetailColumn(
                                'المدة المتبقية', "${event.daysToEnd} يوم"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // زر التذكير
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00BB6E),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Get.to(MoreOptionsScreen());
                        },
                        child: Text(
                          'إضافة تذكير',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // أزرار الإجراء
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionButton(icon: Icons.edit, label: 'تعديل'),
                  ActionButton(icon: Icons.share, label: 'مشاركة'),
                  ActionButton(icon: Icons.delete, label: 'حذف'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getLoopText(int typeLoop) {
    switch (typeLoop) {
      case 0:
        return "لا يتكرر";
      case 1:
        return "يوميًا";
      case 2:
        return "أسبوعيًا";
      case 3:
        return "شهريًا";
      case 4:
        return "سنويًا";
      default:
        return "غير معروف";
    }
  }
}

// تفاصيل صغيرة
class DetailColumn extends StatelessWidget {
  final String label;
  final String value;

  const DetailColumn(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF00BB6E),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Color(0xFF707070),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// زر الإجراء
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFF00BB6E)),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF707070),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
