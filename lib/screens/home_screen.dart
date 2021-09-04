import 'package:bitcoin_ticker/services/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedDropDown = 'AED';

  void getDropdownItems() {
    for (var i = 0; i < currenciesList.length; i++) {
      print(currenciesList[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    getDropdownItems();
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
            child: DropdownButton<String>(
              value: selectedDropDown,
              items: const [
                DropdownMenuItem(
                  child: Text(
                    'USD',
                  ),
                  value: "USD",
                ),
                DropdownMenuItem(
                  child: Text(
                    'INR',
                  ),
                  value: "INR",
                ),
                DropdownMenuItem(
                  child: Text(
                    'AED',
                  ),
                  value: "AED",
                ),
              ],
              onChanged: (value) {
                print(value);
                setState(() {
                  selectedDropDown = value.toString();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
