import 'package:bitcoin_ticker/components/card_container.dart';
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

  DropdownButton<String> _getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> newItem = DropdownMenuItem(
        child: Text(
          currency,
          textAlign: TextAlign.center,
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
        getCurrencyData(value);
      },
    );
  }

  CupertinoPicker _getIOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(
        Text(currency),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.teal,
      itemExtent: 32,
      onSelectedItemChanged: (selected) {
        getCurrencyData(selected);
      },
      children: pickerItems,
    );
  }

  void getCurrencyData(currency) {
    print('value----- $currency');

    for (String crypto in cryptoList) {}
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              CardContainer(
                crypto: 'BTC',
                currency: 'USD',
                currencyValue: 0,
              ),
              CardContainer(
                crypto: 'ETH',
                currency: 'USD',
                currencyValue: 0,
              ),
              CardContainer(
                crypto: 'LTC',
                currency: 'USD',
                currencyValue: 0,
              ),
            ],
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30),
            color: Colors.teal,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Platform.isIOS ? 20.0 : 80,
              ),
              child: Platform.isIOS ? _getIOSPicker() : _getAndroidDropdown(),
            ),
          ),
        ],
      ),
    );
  }
}
