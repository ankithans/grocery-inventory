import 'package:client/auth/login/tokenService.dart';
import 'package:client/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.edit),
        label: Text('Update'),
        onPressed: () async {
          Toast.show('Updating', context);
          try{
            var token = context.read<TokenService>().getToken;
            Response response = await Dio().post(
              '$api/api/v1/grocery/quantity',
              options: Options(
                headers: {
                  'x-auth-token': token,
                }
              ),
              data: {
                'gid': widget.id,
                'quantity': this._currentSliderValue,
              }
            );
            if(response.statusCode == 200){
              Toast.show('Updated', context);
            Navigator.pop(context);
            }
          }
          catch(e){
            Toast.show('An error occured', context);
          }
        },
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}