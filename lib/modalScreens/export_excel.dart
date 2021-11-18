import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/generated/l10n.dart';




class ExportExcel extends StatefulWidget {
  final List<QueryDocumentSnapshot> userExpense;
  ExportExcel(this.userExpense);
  @override
  _ExportExcelState createState() => _ExportExcelState();
}

class _ExportExcelState extends State<ExportExcel> {
  @override
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
    sheet.getRangeByName("C1").setText('${S.of(context).expenseDate}');
    int j = 2;
    for(int i = 0 ; i < widget.userExpense.length ; i++){
      sheet.getRangeByName("A$j").setText(widget.userExpense[i].get('expenseName'));
      sheet.getRangeByName("B$j").setText(widget.userExpense[i].get('expenseCost'));
      Timestamp time = widget.userExpense[i].get('expenseDate');
      sheet.getRangeByName("C$j").setText(DateFormat("yyyy-MM-dd").format(time.toDate()));
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
