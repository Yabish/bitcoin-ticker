import 'package:flutter/material.dart';

class CardContainer extends StatefulWidget {
  const CardContainer({
    Key? key,
    required this.currency,
    required this.currencyValue,
    required this.crypto,
  }) : super(key: key);

  final String currency;
  final String crypto;
  final int currencyValue;

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 28.0,
          ),
          child: Text(
            '1 ${widget.crypto} = ${widget.currencyValue} ${widget.currency}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
