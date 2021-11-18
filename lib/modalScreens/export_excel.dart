import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ExportExcel extends StatefulWidget {
  final List<QueryDocumentSnapshot> userExpense;
  ExportExcel(this.userExpense);
  @override
  _ExportExcelState createState() => _ExportExcelState();
}

class _ExportExcelState extends State<ExportExcel> {
  @override

  SharedPreferences pref;
  String currentLang = "ar";

  void getCurrenLanguage() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      currentLang = pref.getString('language');
    });
  }

  Map<String, String> arabicCategory = {
    'Restaurants': 'مطاعم',
    'Shopping': "تسوق",
    'Gas': "بنزين",
    'Coffee': "قهوة",
    'Finance': "مالية",
    'Grocery': "بقالة",
    'Furniture': "أثاث",
    'Health': "صحة",
    'Online-Shopping': "تسوق إلكتروني",
    'Entertainment': "ترفيه",
    'Education': "تعليم",
    'Other': "أخرى"
  };

  @override
  void initState() {
    getCurrenLanguage();
    super.initState();

  }

  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child:  ElevatedButton(
          style: ButtonStyle(
            backgroundColor:  MaterialStateProperty.all<Color>(
                Color(0xff01937C)
            ),
          ),
          child: Text("${S.of(context).createExcel}"),
          onPressed: createExcel,
        ),
      ),
    );

  }
  Future<void> createExcel() async{

    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName("A1").setText('${S.of(context).expenseName}');
    sheet.getRangeByName("B1").setText('${S.of(context).expenseCost}');
    sheet.getRangeByName("C1").setText('${S.of(context).expenseCategory}');
    sheet.getRangeByName("D1").setText('${S.of(context).expenseDate}');
    int j = 2;
    for(int i = 0 ; i < widget.userExpense.length ; i++){
      sheet.getRangeByName("A$j").setText(widget.userExpense[i].get('expenseName'));
      sheet.getRangeByName("B$j").setText(widget.userExpense[i].get('expenseCost'));
      currentLang == 'ar'?   sheet.getRangeByName("C$j").setText(arabicCategory[widget.userExpense[i].get('expenseIcon')]) :
      sheet.getRangeByName("C$j").setText(widget.userExpense[i].get('expenseIcon'));
      Timestamp time = widget.userExpense[i].get('expenseDate');
      sheet.getRangeByName("D$j").setText(DateFormat("yyyy-MM-dd").format(time.toDate()));
      j++;
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();


    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Masarifi.xlsx';
    final file = File(fileName);
    await file.writeAsBytes(bytes,flush: true);
    OpenFile.open(fileName);





  }
}
