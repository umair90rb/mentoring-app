import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/Home_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class Rating extends StatefulWidget {
  String peerId;
  Rating(this.peerId);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double rating;

  TextEditingController review = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please rate this mentor.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Raleway",
              ),
            ),
            SizedBox(height: 10,),
            SmoothStarRating(
              onRated: (value){
                setState(() {
                  rating = value;
                });
              },
            ),
            SizedBox(height: 3,),
            TextField(
              controller: review,
              decoration: InputDecoration(
                hintText: 'Review'
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => Home()
                      ));
                    },
                    child: Text(
                      'Later',
                      style: TextStyle(
                        color: Color(0xFF1A3A77),
                        fontFamily: "Raleway",
                      ),
                    )),
                ElevatedButton(
                    onPressed: () async {
                      ProgressDialog pr = ProgressDialog(context);
                      pr.style(message: 'Please wait...');
                      await pr.show();
                      User user = FirebaseAuth.instance.currentUser;
                      FirebaseFirestore.instance.collection('profile').doc(widget.peerId)
                          .set({
                        'reviews':FieldValue.arrayUnion([
                          {
                            'stars':rating.toString(),
                            'review':review.text,
                            'name': user.email,
                            'avatar': user.photoURL??'https://www.allthetests.com/quiz22/picture/pic_1171831236_1.png'
                          }
                        ])
                      }, SetOptions(merge: true)).then((value) async {
                        await pr.hide();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => Home()
                        ));
                      });
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Raleway",
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
      );
  }
}
