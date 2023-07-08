import 'package:flutter/material.dart';
import 'package:job_app/models/user.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/const.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/screens/search.dart';
import 'package:job_app/utils/common.dart';

class WelcomeComponent extends StatefulWidget {
  const WelcomeComponent({Key? key}) : super(key: key);

  @override
  State<WelcomeComponent> createState() => _WelcomeComponentState();
}

class _WelcomeComponentState extends State<WelcomeComponent> {
  TextEditingController searchController = TextEditingController();
  final List<String> jobTypes = ["Full-time", "Part-time", "Contractor"];
  String selectedJobType = "Full-time";

  @override
  Widget build(BuildContext context) {
    final theme = CommonUtils.getCustomTheme(context);
    UserProfile user = CommonUtils.getUser(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${Const.hello} ${user.firstName}",
          style:  TextStyle(
            fontSize: 24,
            color: theme.textColors.secondary,
          ),
          textAlign: TextAlign.start,
        ),
         Text(
          Const.findYourJob,
          style: TextStyle(
              fontSize: 26,
              color: theme.textColors.primary,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.bgColors.primary,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow:  [
                        BoxShadow(
                          offset: const Offset(1, 1),
                          color: theme.uiColors.disabled,
                          blurRadius: 4.0,
                          spreadRadius: 0.4,
                        )
                      ],
                    ),
                    child: TextFormField(
                      onChanged: (val) {},
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      decoration:  InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        border: InputBorder.none,
                        hintText: Const.whatAreYouLooking,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: theme.textColors.label,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                  if(searchController.text != ""){
                    moveToSearchPage(context, searchController.text);
                  }

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.bgColors.tertiary,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        ImagesRepo.search,
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: jobTypes.length,
            itemBuilder: (context, index) {
              final item = jobTypes[index];
              return GestureDetector(
                onTap: (){
                  setState(() {
                    selectedJobType = item;
                  });
                },
                child: Padding(
                  padding:  EdgeInsets.only(top: 8, bottom: 8, right: 8, left: index == 0? 0: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.bgColors.primary,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: selectedJobType == item
                            ? theme.uiColors.secondary
                            : theme.uiColors.disabled,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Center(child: Text(item, style: TextStyle(
                        color: selectedJobType == item ? theme.uiColors.secondary: theme.uiColors.disabled
                      ),)),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  void moveToSearchPage(BuildContext context, String key){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) =>  SearchScreen(keyWord: key,)));
  }
}
