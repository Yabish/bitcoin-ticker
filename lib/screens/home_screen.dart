import 'package:bitcoin_ticker/components/card_container.dart';
import 'package:bitcoin_ticker/services/coin_data.dart';
import 'package:bitcoin_ticker/services/network.dart';
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

  String currencyValueBTC = '';
  String currencyValueETH = '';
  String currencyValueLTC = '';

  @override
  void initState() {
    super.initState();
    _getCurrencyData(selectedDropDown);
  }

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
        _getCurrencyData(selectedDropDown);
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
      useMagnifier: true,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedDropDown = currenciesList[index];
        });
        _getCurrencyData(selectedDropDown);
      },
      children: pickerItems,
    );
  }

  void _getCurrencyData(currency) async {
    NetworkHandler networkHandler = NetworkHandler();

    setState(() {
      currencyValueBTC = '?';
      currencyValueETH = '?';
      currencyValueLTC = '?';
    });

    dynamic res1 = await networkHandler.getCurrencyDataFromWeb(
      cryptoList[0],
      selectedDropDown,
    ); // BTC
    dynamic res2 = await networkHandler.getCurrencyDataFromWeb(
      cryptoList[1],
      selectedDropDown,
    ); // ETH
    dynamic res3 = await networkHandler.getCurrencyDataFromWeb(
      cryptoList[2],
      selectedDropDown,
    ); // LTC

    double rate1 = res1['rate'];
    double rate2 = res2['rate'];
    double rate3 = res3['rate'];

    setState(() {
      currencyValueBTC = rate1.floor().toString();
      currencyValueETH = rate2.floor().toString();
      currencyValueLTC = rate3.floor().toString();
    });
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
            children: [
              CardContainer(
                crypto: 'BTC',
                currency: selectedDropDown,
                currencyValue: currencyValueBTC,
              ),
              CardContainer(
                crypto: 'ETH',
                currency: selectedDropDown,
                currencyValue: currencyValueETH,
              ),
              CardContainer(
                crypto: 'LTC',
                currency: selectedDropDown,
                currencyValue: currencyValueLTC,
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
              child: _getIOSPicker(),
              // child: Platform.isIOS ? _getIOSPicker() : _getAndroidDropdown(),
            ),
          ),
        ],
      ),
    );
  }
}
