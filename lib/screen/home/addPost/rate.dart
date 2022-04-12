import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../config/palette.dart';

class rate extends StatefulWidget {
  @override
  _rateState createState() => _rateState();
}

class _rateState extends State<rate> {
  double rating = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor,
          foregroundColor: Palette.textColor,
          elevation: 0, //no shadow
          automaticallyImplyLeading: false, //no arrow
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rate of your visit: $rating',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 32),
              RatingBar.builder(
                minRating: 1,
                itemSize: 30,
                itemPadding: EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber),
                updateOnDrag: true,
                onRatingUpdate: (rating) => setState(() {
                  this.rating = rating;
                }),
              ),
            ],
          ),
        ),
      );
}
