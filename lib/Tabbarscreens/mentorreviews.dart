import 'package:brain_store/services/db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Mentorreviews extends StatelessWidget {
  DocumentSnapshot podcaster;
  Mentorreviews(this.podcaster);

  @override
  Widget build(BuildContext context) {
    if(podcaster.data().containsKey('reviews')){
      List reviews = podcaster['reviews'];
      return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50.0,

                          backgroundImage:
                          NetworkImage(reviews[index]['avatar']),
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(width: 10,),
                        Text(reviews[index]['name']),
                        SizedBox(width: 15,),
                        SmoothStarRating(
                          rating: double.parse(reviews[index]['stars']),
                          isReadOnly: true,
                          size: 25,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          defaultIconData: Icons.star_border,
                          starCount: 5,
                          allowHalfRating: true,
                          spacing: 1.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(reviews[index]['review'], textAlign: TextAlign.justify,),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder:(context, index){
          return Divider();
        },
        itemCount: reviews.length,
      );
    } else {
      return Center(
        child: Text('No Review yet!'),
      );
    }
  }

}
