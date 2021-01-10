import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget formHeader({String text}) {
  return Container(
    //padding: const EdgeInsets.all(20.0),
    alignment: Alignment.center,
    child: Text(
      text,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[600]),
    ),
  );
}

Widget formLabel({String text}) {
  return Container(
    width: 150,
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 10),
    child: Text(
      text.trim() + ": ",
      style: TextStyle(fontSize: 18, color: Colors.teal[700]),
    ),
  );
}

Widget formLabel2({String text}) {
  return Container(
    width: 180,
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 10),
    child: Text(
      text.trim() + ": ",
      style: TextStyle(
          fontSize: 18, color: Colors.teal[700], fontWeight: FontWeight.bold),
    ),
  );
}

Widget inputTextField({
  TextEditingController controller,
  String hint,
  String label,
  double width,
  Function onChange,
}) {
  return Container(
    //width: double.maxFinite,
    width: width,
    child: TextField(
      controller: controller,
      onChanged: onChange,
      style: TextStyle(
        color: Colors.teal[900],
        fontSize: 16,
      ),
      decoration: InputDecoration(
          //border: const OutlineInputBorder(),
          border: const OutlineInputBorder(),
          hintText: hint,
          labelText: label,
          contentPadding:
              EdgeInsets.only(bottom: 17, left: 5, top: 17, right: 10),
          isDense: true,
          //labelText: 'Product Name',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13)),
    ),
  );
}

Widget inputTextFieldWithSuffixButton({
  TextEditingController controller,
  String hint,
  String label,
  double width,
  Function onChange,
  IconButton iconbutton,
}) {
  return Container(
    //width: double.maxFinite,
    width: width,
    child: TextField(
      controller: controller,
      onChanged: onChange,
      style: TextStyle(
        color: Colors.teal[900],
        fontSize: 16,
      ),
      decoration: InputDecoration(
          suffixIcon: iconbutton,
          //border: const OutlineInputBorder(),
          border: const OutlineInputBorder(),
          hintText: hint,
          labelText: label,
          contentPadding:
              EdgeInsets.only(bottom: 17, left: 5, top: 17, right: 10),
          isDense: true,
          //labelText: 'Product Name',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13)),
    ),
  );
}

Widget inputIntField({
  TextEditingController controller,
  String hint,
  String label,
  double width,
  Function onChange,
}) {
  return Container(
    //width: double.maxFinite,
    width: width,
    child: TextField(
      controller: controller,
      onChanged: onChange,
      style: TextStyle(
        color: Colors.teal[900],
        fontSize: 16,
      ),
      decoration: InputDecoration(
        //border: const OutlineInputBorder(),
        border: const OutlineInputBorder(),
        hintText: hint,
        labelText: label,
        contentPadding:
            EdgeInsets.only(bottom: 17, left: 5, top: 17, right: 10),
        isDense: true,
        //labelText: 'Product Name',
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    ),
  );
}

Widget inputIntFieldWithSuffixButton({
  TextEditingController controller,
  String hint,
  String label,
  double width,
  Function onChange,
  IconButton iconbutton,
}) {
  return Container(
    //width: double.maxFinite,
    width: width,
    child: TextField(
      controller: controller,
      onChanged: onChange,
      style: TextStyle(
        color: Colors.teal[900],
        fontSize: 16,
      ),
      decoration: InputDecoration(
        //border: const OutlineInputBorder(),
        suffixIcon: iconbutton,
        border: const OutlineInputBorder(),
        hintText: hint,
        labelText: label,
        contentPadding:
            EdgeInsets.only(bottom: 17, left: 5, top: 17, right: 10),
        isDense: true,
        //labelText: 'Product Name',
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    ),
  );
}

Widget inputTextArea({
  TextEditingController controller,
  String hint,
  String label,
  double width,
  Function onChange,
}) {
  return Container(
    //width: double.maxFinite,
    width: width,
    child: TextField(
      controller: controller,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      onChanged: onChange,
      style: TextStyle(
        color: Colors.teal[900],
        fontSize: 16,
      ),
      decoration: InputDecoration(
          //border: const OutlineInputBorder(),
          border: const OutlineInputBorder(),
          hintText: hint,
          labelText: label,
          contentPadding:
              EdgeInsets.only(bottom: 17, left: 5, top: 17, right: 10),
          isDense: true,
          //labelText: 'Product Name',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13)),
    ),
  );
}

Widget formButton({Function onPressed, Color color, String text}) {
  return Padding(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: RaisedButton(
      color: color,
      textColor: Colors.white,
      child: Text(text,
          style: TextStyle(
            fontSize: 20,
          )),
      padding: EdgeInsets.all(20),
      onPressed: onPressed,
    ),
  );
}

Widget smallButton({Function onPressed, Color color, String text}) {
  return Container(
    //padding: EdgeInsets.only(left: 20, right: 20),
    margin: EdgeInsets.only(top: 5),
    child: RaisedButton(
      color: color,
      textColor: Colors.white,
      child: Text(text.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
          )),
      //padding: EdgeInsets.all(20),
      onPressed: onPressed,
    ),
  );
}

Widget buttonWithIcon(
    {String text,
    IconData icon,
    GestureTapCallback onTap,
    double width,
    Color textColor,
    Color color,
    double height,
    double radius}) {
  return GestureDetector(
    child: Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Row contents horizontally,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: textColor),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(
              text,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    ),
    onTap: onTap,
  );
}

Widget btnWithIcon(
    {String text,
    IconData icon,
    GestureTapCallback onTap,
    double width,
    Color textColor,
    Color color,
    Color iconColor,
    TextStyle textStyle,
    double height,
    double radius}) {
  return GestureDetector(
    child: Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Row contents horizontally,
          crossAxisAlignment:
              CrossAxisAlignment.center, //Center Row contents vertically,
          children: <Widget>[
            Text(
              text,
              style: textStyle,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(icon, color: iconColor),
          ],
        ),
      ),
    ),
    onTap: onTap,
  );
}

Widget iconButton({
  Function onPressed,
  double height,
  double width,
  double radius,
  Color color,
  IconData icon,
  double allMargin,
  double iconSize,
  Color textColor,
}) {
  return new Container(
      //width: 50,
      height: height,
      width: width,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
      child: Expanded(
        child: FlatButton(
          textColor: textColor,
          onPressed: onPressed,
          child: Icon(
            icon,
            size: iconSize,
          ),
        ),
      ));
}
