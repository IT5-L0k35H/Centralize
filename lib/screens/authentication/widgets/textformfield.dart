import 'package:flutter/material.dart';
import 'package:Centralize/widgets/responsive_ui.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;


  CustomTextField(
    {this.hint,
      this.textEditingController,
      this.keyboardType,
      this.icon,
      this.obscureText= false,
     });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      color: Colors.white,
      
      borderRadius: BorderRadius.circular(50.0),
      shadowColor: Colors.deepPurple,
      
    // elevation: large? 2 : (medium? 1.5 :1),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
      /*    enabledBorder: const OutlineInputBorder(
      // width: 0.0 produces a thin "hairline" border
      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
    ),
        */  
          prefixIcon: Icon(icon, color: Colors.orange[300], size: 23),
          hintText: hint,
         /* border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide.none),
             */
        ),
      ),
    );
  }
}
