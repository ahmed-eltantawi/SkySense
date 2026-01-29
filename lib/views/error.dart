import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/views/search_view.dart';

class Error extends StatelessWidget {
  const Error({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 450, child: LottieBuilder.asset(image)),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              onTap(context);
            },
            child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.primary),
                height: 50,
                width: double.infinity,
                child: Center(
                    child: Text(
                  'Try again',
                  style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.onPrimary),
                ))),
          ),
        ],
      ),
    );
  }

  void onTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const SearchView();
      },
    ));
  }
}
