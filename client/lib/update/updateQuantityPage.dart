import 'package:client/constants.dart';
import 'package:flutter/material.dart';
class UpdatePage extends StatefulWidget {

  final String id;
  final String imageUrl;
  final int quantity;
  UpdatePage({@required this.id, @required this.imageUrl, @required this.quantity});
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  double _currentSliderValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentSliderValue = double.parse(widget.quantity.toString());
  }
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      appBar: titleAppbar(context, title: 'Update Item'),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Hero(
                  tag: 'item${widget.id}',
                              child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    height: 200,
                    width: 200,
                    child: Image.network(
                      '${widget.imageUrl}',
                      fit: BoxFit.contain,
                    )
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    // Slider(
                    //   value: double.parse(quantity.toString()),
                    //   divisions: 5,
                    //   min: 1,
                    //   max: 100,
                    //   label: quantity.round().toString(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       quantity = int.parse(value.toString());
                    //     });
                    //   },
                    // ),
                    Slider(
      value: _currentSliderValue,
      min: 0,
      max: 100,
      divisions: 5,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}