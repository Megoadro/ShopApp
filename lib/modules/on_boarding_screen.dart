import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/cache_helper.dart';
import 'package:shop_app/shared/compenents.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// class model for each item in screen
class BoardingModel {
   final String image;
   final String tittle;
   final String body;

  BoardingModel ({
    @required this.image,
    @required this.tittle,
    @required this.body,
});

}
class OnBoardingScreen extends StatefulWidget {
  //const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List <BoardingModel> boarding =[
    BoardingModel(
      image: 'assets/images/onboarding_1.jpg',
      tittle: 'Explore many products',
      body : 'On Boarding 1 body',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_2.jpg',
      tittle: 'Choose and checkout',
      body : 'On Boarding 2 body',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_3.jpg',
      tittle: 'Get it delivered',
      body : 'On Boarding 3 body',
    ),
  ];

  bool isLast = false;
  void submit (){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateToAndFinish(context, ShopLoginScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('ShopApp'),
        actions: [
          TextButton(
              onPressed: submit,
              child: Text('SKIP',
                  style: TextStyle(
                  fontSize: 14,
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold)))
        ],
      ),
       body: Padding(
         padding: const EdgeInsets.all(20.0),
         child: Column(
           children: [
             Expanded(
               child: PageView.builder(
                   onPageChanged: ( int index){
                     if (index == boarding.length-1){
                       setState(() {
                         isLast=true;
                       });
                     }else{
                       setState(() {
                         isLast=false;
                       });
                     }
                   },
                   controller: boardController,
                   physics: BouncingScrollPhysics(),
                   itemBuilder: (context , index)=> buildBoardingItem(boarding[index]),
                 itemCount: boarding.length,
               ),
             ),
           ],
         ),
       )
    );

  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      SizedBox(height: 20,),
      Text('${model.tittle}' , style: TextStyle(fontSize: 24,color: Colors.pink,fontWeight: FontWeight.bold),),
      SizedBox(height: 20,),
      Text('${model.body}' , style: const TextStyle(fontSize: 14),),
      const SizedBox(height: 20,),
      Row(
        children :  [
          SmoothPageIndicator(
              controller: boardController,
              count: boarding.length,
              effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: Colors.pinkAccent,
                dotHeight: 10,
                expansionFactor: 4,
                dotWidth: 10,
                spacing: 5.0,
              ),
          ),
          const Spacer(),
          TextButton(
              onPressed: (){
                if (isLast){
                     submit();
                }else{
                  boardController.nextPage(duration:
                  const Duration(
                    milliseconds: 750,
                  ),
                      curve: Curves.fastLinearToSlowEaseIn );
                }

              },
              child: Text('NEXT',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold),))

        ],
      ),


    ],
  );
}
