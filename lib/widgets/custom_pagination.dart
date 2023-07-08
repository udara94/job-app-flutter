import 'package:flutter/material.dart';
import 'package:job_app/utils/common.dart';

import '../resources/colors.dart';
import '../resources/images.dart';

class CustomPagination extends StatelessWidget {
  const CustomPagination(
      {Key? key,
      required this.goPreviousPage,
      required this.goNextPage,
      required this.pageNumber,
      required this.allowMoveForward})
      : super(key: key);
  final Function goPreviousPage;
  final Function goNextPage;
  final int pageNumber;
  final bool allowMoveForward;

  @override
  Widget build(BuildContext context) {
    final theme = CommonUtils.getCustomTheme(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              pageNumber != 1?
              goPreviousPage():{};
            },
            child: Container(
              decoration: BoxDecoration(
                color: pageNumber == 1? theme.uiColors.disabled : theme.bgColors.tertiary,
                borderRadius: BorderRadius.circular(6),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ColorFiltered(
                  colorFilter:
                       ColorFilter.mode(theme.textColors.inverse, BlendMode.srcIn),
                  child: Image.asset(
                    ImagesRepo.backIcon,
                    width: 30,
                    height: 30,
                  )),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: theme.bgColors.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              pageNumber.toString(),
              style:  TextStyle(
                  color: theme.textColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              allowMoveForward?
              goNextPage(): {};
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: allowMoveForward? theme.bgColors.tertiary: theme.uiColors.disabled,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ColorFiltered(
                  colorFilter:
                       ColorFilter.mode(theme.textColors.inverse, BlendMode.srcIn),
                  child: Image.asset(
                    ImagesRepo.forwardIcon,
                    width: 30,
                    height: 30,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
