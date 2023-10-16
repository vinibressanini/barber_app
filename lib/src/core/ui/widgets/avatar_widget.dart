import 'package:barber_app/src/core/ui/barbershop_icons.dart';
import 'package:barber_app/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final bool hideUploadIcon;
  const AvatarWidget({super.key, this.hideUploadIcon = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104,
      height: 104,
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.avatar),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Offstage(
              offstage: hideUploadIcon,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorsConstants.brown,
                    width: 3.5,
                  ),
                ),
                child: const Icon(
                  BarbershopIcons.addEmployee,
                  size: 20,
                  color: ColorsConstants.brown,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
