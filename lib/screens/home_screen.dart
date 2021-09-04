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

  String BTCCurrencyValue = '';
  String ETHCurrencyValue = '';
  String LTCCurrencyValue = '';

  @override
  void initState() {
    super.initState();
    getCurrencyData(selectedDropDown);
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
        getCurrencyData(selectedDropDown);
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
      onSelectedItemChanged: (index) {
        setState(() {
          selectedDropDown = currenciesList[index];
        });
        getCurrencyData(selectedDropDown);
      },
      children: pickerItems,
    );
  }

  void getCurrencyData(currency) async {
    print('value----- $currency');
    NetworkHandler networkHandler = NetworkHandler();

    setState(() {
      BTCCurrencyValue = '?';
      ETHCurrencyValue = '?';
      LTCCurrencyValue = '?';
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
      BTCCurrencyValue = rate1.floor().toString();
      ETHCurrencyValue = rate2.floor().toString();
      LTCCurrencyValue = rate3.floor().toString();
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
                currencyValue: BTCCurrencyValue,
              ),
              CardContainer(
                crypto: 'ETH',
                currency: selectedDropDown,
                currencyValue: ETHCurrencyValue,
              ),
              CardContainer(
                crypto: 'LTC',
                currency: selectedDropDown,
                currencyValue: LTCCurrencyValue,
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
