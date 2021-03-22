import 'package:flutter/material.dart';
import 'package:test_app/net/flutterfire.dart';

class AddView extends StatefulWidget {
  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "bitcoin",
    "Tether",
    "Etherium",
    "RavenCoin",
    "Doge",
    "Dot",
    "Litecoin",
    "Atom"
  ];
  TextEditingController _amountController = TextEditingController();
  String dropDownValue = "bitcoin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            DropdownButton(
                value: dropDownValue,
                onChanged: (String value) {
                  setState(() {
                    print(value);
                    dropDownValue = value;
                  });
                },
                items: coins.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList()),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: "coin amount"),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.amber,
              ),
              child: MaterialButton(
                onPressed: () async {
                  await addCoin(dropDownValue, _amountController.text);
                  Navigator.of(context).pop();
                },
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
