import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../my_diary/provider/provider.dart';
class InputDataPage extends StatefulWidget {
  const InputDataPage({super.key});

  @override
  _InputDataPageState createState() => _InputDataPageState();
}

class _InputDataPageState extends State<InputDataPage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  late DateProvider dateProvider;
  @override
  void initState() {
    dateProvider = Provider.of<DateProvider>(context, listen: false);
    dateProvider.checkAndDisplayData();
    super.initState();
  }
  void _submitData() {
    final enteredHeight = _heightController.text;
    final enteredWeight = _weightController.text;

    if (enteredHeight.isEmpty || enteredWeight.isEmpty) {
      return;
    }

    final height = double.tryParse(enteredHeight);
    final weight = double.tryParse(enteredWeight);

    if (height == null || weight == null) {
      return;
    }

    // You can now use the height and weight values
    print('Height: $height, Weight: $weight');

    // Optionally, you can clear the text fields after submission
    _heightController.clear();
    _weightController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Height and Weight'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: 'Height (cm)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                // final todayStart = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
                final todayStart = DateTime(dateProvider.selectedDate.year, dateProvider.selectedDate.month, dateProvider.selectedDate.day);
                final todayEnd = todayStart.add(const Duration(days: 1));
                  final querySnapshot = await _firestore
                      .collection('db_body')
                      .where('time', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
                      .where('time', isLessThan: Timestamp.fromDate(todayEnd))
                      .get();

                  if (querySnapshot.docs.isNotEmpty) {
                  // Hiển thị dữ liệu nếu ngày tháng khớp
                    _firestore.collection('db_body').doc(querySnapshot.docs.first.id).update(
                      {
                        'idUser':'aa',
                        'height':_heightController.text,
                        'weight':_weightController.text,
                        'time':Timestamp.now()
                      }
                    );
                  // _dataId =querySnapshot.docs.first.id;
                    dateProvider.setBodyId(querySnapshot.docs.first.id);
                  } else {
                  // Tạo mới dữ liệu nếu ngày tháng không khớp
                  final newData = {
                    'idUser':'aa',
                    'height':_heightController.text,
                    'weight':_weightController.text,
                    'time':Timestamp.now()
                  };
                  final docRef = await _firestore.collection('db_body').add(newData);
                  dateProvider.setBodyId(docRef.id);
                  }
                Fluttertoast.showToast(msg: "Sucess");
                _heightController.clear();
                _weightController.clear();
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: const Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}