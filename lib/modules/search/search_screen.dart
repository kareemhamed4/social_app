import 'package:flutter/material.dart';
import 'package:socialjetx/shared/components/components.dart';
import 'package:socialjetx/shared/styles/colors.dart';
import 'package:socialjetx/shared/styles/icon_broken.dart';

//ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(bottom: 8.0,start: 8.0,end:8.0 ),
        child: Column(
          children: [
            Container(
              color:Theme.of(context).scaffoldBackgroundColor,
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: Theme.of(context).textTheme.caption!.copyWith(fontSize: 18),
                  prefixIcon: const Icon(IconBroken.Search,size: 20,),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Center(child: Text('All',style: Theme.of(context).textTheme.bodyText2,))),
                Expanded(child: Center(child: Text('People',style: Theme.of(context).textTheme.bodyText2,))),
                Expanded(child: Center(child: Text('Post',style: Theme.of(context).textTheme.bodyText2,))),
                Expanded(child: Center(child: Column(
                  children: [
                    Text('Photos',style: Theme.of(context).textTheme.subtitle2!.copyWith(color: myFavColor5),),
                    SizedBox(height: 10,),
                    Container(
                      height: 3,
                      width: 60,
                      decoration: BoxDecoration(
                        color: myFavColor5,
                      ),
                    )
                  ],
                ))),
                Expanded(child: Center(child: Text('Events',style: Theme.of(context).textTheme.bodyText2,))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
