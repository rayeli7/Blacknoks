

import 'package:blacknoks/models/theme.dart';
import 'package:blacknoks/services/api(s)/fetch_api.dart';

import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: GSE_Companies.length,
            itemBuilder: (context, index) {                
              return Card(
                elevation: 2,
               child: ListTile(
                 enableFeedback: true,
        
                 title: Row(
                   children: [
                     Container(
                       height:20,
                       width: 60,
                       color: textWhiteGrey,
                     ),
                   ],
                 ),
                    
                 subtitle: Text(
                   GSE_Companies[index],
                   style:const TextStyle(
                   color: Colors.grey,
                    ),
                  ),
                    
                 trailing:
                    Column(
                      children: [
                        SizedBox(
                          width: 90,
                          child: ElevatedButton(
                             onPressed: (){}, child: null,
                          ),
                        ),
                      ],
                    ),
            
                  ),
                );
            });
            }
}
