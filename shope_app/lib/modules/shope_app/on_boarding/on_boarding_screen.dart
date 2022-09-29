import 'package:flutter/material.dart';
import 'package:mm/modules/shope_app/login/login_screen.dart';
import 'package:mm/shared/components/components.dart';
import 'package:mm/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/style/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}



class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/on_boarding.png',
        title: 'On Boarding 1 title',
        body: 'On boarding 1 body'),
    BoardingModel(
        image: 'assets/images/on_boarding.png',
        title: 'On Boarding 2 title',
        body: 'On boarding 2 body'),
    BoardingModel(
        image: 'assets/images/on_boarding.png',
        title: 'On Boarding 3 title',
        body: 'On boarding 3 body'),
  ];

  var boardingPage = PageController();

  bool isLast = false;

  void submet(){
    CacheHelper.saveData(kye: 'OnBoarding', value: true)!.then((value) {
      if(value){
        navigateAndFinish(context,  LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submet();
            },
            child: const Text('SKIP'),
          ),
        ],
      ),
      body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (context, index) =>
                        boardingItemsBuilder(boarding[index]),
                    itemCount: boarding.length,
                    physics: const BouncingScrollPhysics(),
                    controller: boardingPage,
                    onPageChanged: (index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                      controller: boardingPage,
                      count: boarding.length,
                      effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaulteColor,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5.0,
                        expansionFactor: 4,
                      ),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        if (isLast) {
                          submet();
                        } else {
                          boardingPage.nextPage(
                            duration: const Duration(
                              seconds: 1,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                )
              ],
            ),
          ),
    );
  }

  Widget boardingItemsBuilder(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset(model.image)),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black54,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );
}
