import 'package:flutter/material.dart';

class ItemMessageMember extends StatelessWidget {

  const ItemMessageMember({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45.0,
        ),
        child: Card(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 60.0,
                  top: 5.0,
                  bottom: 25.0
                ),
                child: Text(
                    'Hey',
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                ),
              ),

              Positioned(
                bottom: 4.0,
                right: 10.0,
                child: Text(
                  '20:58',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey[600]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
