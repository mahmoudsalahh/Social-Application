import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,

  //Color background = Colors.blue,
  required VoidCallback onpressed,
  required String text,
  Color? color ,
}) =>
    Container(
      width: width,
      //color: background,
      child: MaterialButton(
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget defaulttextformfeild({
  required TextEditingController controller,
  TextInputType? type,
  required String label,
  required FormFieldValidator validate,
  required IconData prefix,
  IconData? suffix,
  ValueChanged? onchange,
  bool obsecureText = false ,
  VoidCallback? suffixPressed,
   Function(String value)? onSubmit,
  Color? background ,
  Color? suffixColor = Colors.white,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      controller: controller,
      onChanged: onchange,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(

        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(color: Colors.white) ),
        hoverColor: Colors.white,
        labelText: label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: background,

        ),
        prefixIcon: Icon(prefix,color: suffixColor),
        suffixIcon: InkWell(child: Icon(suffix,color: suffixColor),onTap:suffixPressed ,),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color:Colors.white,fontSize: 15.0),
      obscureText: obsecureText,
      validator: validate,
    );

Widget NewsArtical(article, context) {
  return InkWell(
    onTap: () {
      //navigatorTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(width: 40.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${article['title']}',
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text('${article['publishedAt']}',
                    style: TextStyle(color: Colors.grey, fontSize: 17.0)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
void navigateAndRemoveUntil(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultTextButton({
  required String text,
  required VoidCallback onpressed,
  Color? color
}) =>
    TextButton(onPressed: onpressed, child: Text(text.toUpperCase(),style: TextStyle(color: color),));

//${article['urlToImage']}
//${article['title']}
//${article['publishedAt']}

void showToast(
    {
      required String text,
      required ToastState state,

    })=>
    Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:toastStateColor(state),
    textColor: Colors.white,
    fontSize: 16.0

);
enum ToastState{SUCCESS , ERROR , WARNING}

Color toastStateColor (ToastState state ) {
  Color? color ;
  switch (state) {
    case ToastState.SUCCESS :
      color = Colors.green;
      break;
    case ToastState.ERROR :
      color = Colors.red;
      break;
    case ToastState.WARNING :
      color = Colors.amber;
      break;
  }
      return color;

}
