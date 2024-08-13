import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/app_colors.dart';
import 'package:news_app/home/tabs/tab_widget.dart';
import 'package:news_app/model/SourceResponse.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.whiteColor,
          child: Image.asset("assets/images/main_background.png" ,
          width: double.infinity,
          height: double.infinity,
          fit:  BoxFit.cover,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'News App',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: FutureBuilder<SourceResponse?>(
            future: ApiManager.getSources(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(
                  color: AppColors.primaryLightColor,
                ),
                );}
                else if(snapshot.hasError){
                  return Column(
                  children: [
                    Text("Something went wrong"),
                     ElevatedButton(onPressed: (){
                       ApiManager.getSources();
                       setState(() {

                       });
                     }, child: Text("Try Again"))
                  ],
                  );
              }
                if(snapshot.data!.status != 'ok'){
                  return Column(
                    children: [
                      Text(snapshot.data!.message!),
                      ElevatedButton(onPressed: (){
                        ApiManager.getSources();
                        setState(() {

                        });
                      }, child: Text("Try Again"))
                    ],

                  );
                }
                var sourcesList =snapshot.data!.sources! ;
                return TabsWidget(sourcesList: sourcesList);
              }
          ),
        ),
      ],
    );
  }
}
