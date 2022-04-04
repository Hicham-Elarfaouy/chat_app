import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_cubit.dart';
import 'package:flutter_app7/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    appCubit cubit = appCubit.get(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            child: Image(
              image: NetworkImage('https://media.istockphoto.com/vectors/flag-ribbon-welcome-old-school-flag-banner-vector-id1223088904?k=20&m=1223088904&s=612x612&w=0&h=b_ilJpFTSQbZeCrZusHRLEskmfiONWH0hFASAJbgz9g='),
              height: 140,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image(
                            image: AssetImage('assets/images/profile.png'),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Abdellah Abdo',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.verified_rounded,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                              ],
                            ),
                            Text(
                              'Janvier 10, 2022 at 11:33 pm',
                              style: TextStyle(color: Colors.black54),
                            )
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(IconBroken.More_Square)),
                      ],
                    ),
                    Divider(),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vestibulum lorem sed risus ultricies tristique nulla. Viverra suspendisse potenti nullam ac tortor vitae.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        image: AssetImage('assets/images/ramadan.jpg'),
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconBroken.Heart,
                            )),
                        Text(
                          '200',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconBroken.Chat,
                            )),
                        Text(
                          '200',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          child: Image(
                            image: AssetImage('assets/images/profile.png'),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Write a comment ...',
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconBroken.Send,
                            )),
                        Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: 6,
            ),
            itemCount: 10,
          ),
        ],
      ),
    );
  }
}
