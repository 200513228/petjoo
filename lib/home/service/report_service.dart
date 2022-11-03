import 'package:cloud_firestore/cloud_firestore.dart';

class ReportService {
  static var db = FirebaseFirestore.instance;

  static Future sendReport(Map<String, dynamic> dataMap) async {
    try {
      await db.collection('reports').add(dataMap);
      return 'REPORT';
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
