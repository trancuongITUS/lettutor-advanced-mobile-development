import 'package:flutter/material.dart';

class CountrySelect extends StatefulWidget {
  final List<String> countries;
  final String selectedCountry;
  final ValueChanged<String> onCountryChanged;

  const CountrySelect({
    Key? key,
    required this.countries,
    required this.selectedCountry,
    required this.onCountryChanged,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CountrySelectState createState() => _CountrySelectState();
}

class _CountrySelectState extends State<CountrySelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButton<String>(
          underline: Container(),
          isDense: true,
          isExpanded: true,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          value: widget.selectedCountry,
          onChanged: (String? newValue) {
            if (newValue != null) {
              widget.onCountryChanged(newValue);
            }
          },
          items: widget.countries.map<DropdownMenuItem<String>>((String country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            );
          }).toList(),
        ),
      ),
    );
  }
}