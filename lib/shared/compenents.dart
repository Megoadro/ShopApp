import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/favorites_model.dart';


Widget defaultButton(
    {double width = double.infinity,
      Color background = Colors.pink,
      bool isUpperCase = true,
      @required Function function,
      @required String text}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );




Widget defalutFormfeild({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmited,
  Function onTap,
  Function onChanged,
  @required Function  valdiate,
  @required String label,
  @required IconData prefix,
  bool ispassword = false,
  IconData suffix,
  Function suffixpressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      enabled: isClickable,
      obscureText: ispassword,
      onFieldSubmitted: onSubmited,
      onChanged: onChanged,
      onTap: onTap,
      validator: (s) => valdiate(s),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
            onPressed: () {
              suffixpressed();
            },
            icon: Icon(suffix))
            : null,
        border: const OutlineInputBorder(),
      ),
    );




Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
        onPressed: () {
          function();
        },
        child: Text(text.toUpperCase()));





void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
    (Route<dynamic> route) => false,

);

void showToast ({
  @required String text,
  @required ToastStates state} )=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch (state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
 Widget myDivider()=> Padding(
   padding: const EdgeInsetsDirectional.only(start: 20),
   child: Container(
     width: double.infinity ,
     height: 1.0,
     color: Colors.grey[300],
   ),
 );

Widget buildListProduct( model, context,{bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120.0,
              height: 120.0,
            ),
            if (model.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  height: 1.3, // heigt between 2 lines
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.toString()}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice.toString()}',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 15.0,
                    // انا استغليت ان Map عندي فيها bool  ومن خلاله هقدر اعمل check  علي اللون
                    backgroundColor:
                    ShopCubit.get(context).favorites[model.id]
                        ? Colors.pink
                        : Colors.grey,
                    child: IconButton(
                      onPressed: () {
                        ShopCubit.get(context)
                            .changeFavorites(model.id);
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  ),
);
