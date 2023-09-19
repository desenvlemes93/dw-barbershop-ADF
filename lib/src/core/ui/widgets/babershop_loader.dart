import 'package:dw_barber_shop/src/core/ui/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BabershopLoader extends StatelessWidget {
  const BabershopLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: ColorsConstants.brow,
        size: 60,
      ),
    );
  }
}
