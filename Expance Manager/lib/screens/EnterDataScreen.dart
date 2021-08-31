import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_expense_manager/api/firebaseDatabase.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class EnterDataScreen extends StatefulWidget {
  const EnterDataScreen({Key? key}) : super(key: key);

  @override
  _EnterDataScreenState createState() => _EnterDataScreenState();
}

class _EnterDataScreenState extends State<EnterDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  String _amountType = "Income";


  void initState() {
    _amountController.addListener(() => setState(() {}));
    _categoryController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amount = _amountController.text;
    final category = _categoryController.text;
    // final double overallIncome;
    // late double overallExpense;
    // if(_amountType == 'Income') {
    //   overallIncome = double.parse(amount);
    // }else {
    //   overallExpense = double.parse(amount);
    // }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Enter Data"),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: _amountController,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Amount",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.attach_money),
                    suffixIcon: _amountController.text.isEmpty
                        ? null
                        : IconButton(
                      onPressed: () {
                        _amountController.clear();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                  validator: (String? value) {
                    if (value != null && value.isEmpty)
                      return "Please enter value";
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _categoryController,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Category",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.list),
                    suffixIcon: _categoryController.text.isEmpty
                        ? null
                        : IconButton(
                      onPressed: () {
                        _categoryController.clear();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                  validator: (String? value) {
                    if (value != null && value.isEmpty)
                      return "Please enter value";
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Select Type : ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: DropdownButton(
                        value: _amountType,
                        isExpanded: true,
                        underline: SizedBox(),
                        onChanged: (String? value) {
                          setState(() {
                            _amountType = value!;
                          });
                        },
                        items: <String>["Income", "Expense"]
                            .map(
                              (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async{
                    final Map<String, dynamic> map = {
                      //"amount": _amountController.toString(),
                      "amount": amount,
                      "category": category,
                      //"category": _categoryController.toString(),
                      "type": _amountType,
                      "date": DateTime.now().toIso8601String(),
                    };

                    // print(amount);
                    // print(category);
                    // print(_amountType);
                    await Database.create(map,auth.currentUser!.uid);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text("SUBMIT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


