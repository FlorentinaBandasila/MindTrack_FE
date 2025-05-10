import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';

void showTaskOptionsPopup(
    BuildContext context, String title, String description) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            width: 305,
            height: 250,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: MyColors.pink,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Titlu
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: MyColors.black,
                  ),
                ),

                // Descriere
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: MyColors.black,
                  ),
                ),

                // Butoane
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 105,
                      height: 32,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.cream,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          print("Task \"$title\" marked as Abandoned.");
                          Navigator.of(context).pop();
                        },
                        child: const Text("Abandon",
                            style: TextStyle(
                                color: MyColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      width: 105,
                      height: 32,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.turqouise,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          print("Task \"$title\" marked as Done.");
                          Navigator.of(context).pop();
                        },
                        child: const Text("Done",
                            style: TextStyle(
                                color: MyColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
