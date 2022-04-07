import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_cubit.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/models/post_model.dart';
import 'package:flutter_app7/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenPostScreen extends StatelessWidget {
  PostModel model;
  int index;
  OpenPostScreen(this.model,this.index);

  var formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    appCubit cubit = appCubit.get(context);
    cubit.getComments(cubit.listIdPosts[index]);

    return BlocConsumer<appCubit, appStates>(
      listener: (context, state) {},
      builder: (context, state) {
        appCubit cubit = appCubit.get(context);
        // cubit.getComments(cubit.listIdPosts[index]);


        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                  hintText: 'Write a comment ...',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'this field must not be empty';
                                  }
                                },
                                onFieldSubmitted: (v) {
                                  formKey.currentState!.validate();
                                },
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  cubit.addComment(cubit.listIdPosts[index], '${DateTime.now()}', textController.text);
                                  textController.clear();
                                }
                              },
                              icon: Icon(
                                IconBroken.Send,
                              )),
                        ],
                      ),
                      cubit.listComments.isEmpty ? Container() : Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Comments'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cubit.listComments.length,
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage('${cubit.listComments[index].profile}'),
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
                                            '${cubit.listComments[index].name}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${cubit.listComments[index].date}',
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${cubit.listComments[index].text}',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
