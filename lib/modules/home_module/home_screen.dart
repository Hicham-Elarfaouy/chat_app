import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_cubit.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/models/post_model.dart';
import 'package:flutter_app7/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<appCubit, appStates>(
      listener: (context, state) {},
      builder: (context, state) {
        appCubit cubit = appCubit.get(context);
        print(cubit.listPosts.length);


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
                itemBuilder: (context, index) => PostItem(cubit.listPosts[index],cubit,index),
                separatorBuilder: (context, index) => SizedBox(
                  height: 6,
                ),
                itemCount: cubit.listPosts.length,
              ),
            ],
          ),
        );
      },
    );
  }
  Widget PostItem(PostModel model,appCubit cubit,int index) {

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.profile}'),
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
                          '${model.name}',
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
                      '${model.date}',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '${model.text}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if(model.image != null)
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                  image: NetworkImage('${model.image}'),
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    cubit.likePost(cubit.listIdPosts[index],index,cubit.listLiked[index].contains(cubit.userModel?.uid));
                  },
                  icon: cubit.listLiked[index].contains(cubit.userModel?.uid) ? Icon(
                      Icons.favorite_outlined,color: Colors.red,
                  ) : Icon(
                    IconBroken.Heart,
                  ),
                ),
                Text(
                  '${cubit.listLiked[index].length}',
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
                  '${model.comments}',
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
                  backgroundImage: NetworkImage('${cubit.userModel?.image}'),
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
    );
  }
}
