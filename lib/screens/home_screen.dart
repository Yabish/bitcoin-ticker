import 'package:bitcoin_ticker/services/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedDropDown = 'USD';

  DropdownButton<String> getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> newItem = DropdownMenuItem(
        child: Text(
          currency,
        ),
        value: currency,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedDropDown,
      isExpanded: true,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedDropDown = value.toString();
        });
      },
    );
  }

  CupertinoPicker getIOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(
        Text(currency),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.teal,
      itemExtent: 32,
      onSelectedItemChanged: (selected) {},
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Ticker'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.teal,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 28.0,
                ),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30),
            color: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Platform.isIOS ? getIOSPicker() : getAndroidDropdown(),
            ),
          ),
        ],
      ),
    );
  }
}
