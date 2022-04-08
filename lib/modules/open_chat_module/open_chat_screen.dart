import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_cubit.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/models/message_model.dart';
import 'package:flutter_app7/models/user_model.dart';
import 'package:flutter_app7/shared/components/constants.dart';
import 'package:flutter_app7/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenChatScreen extends StatelessWidget {
  UserModel model;

  OpenChatScreen(this.model);

  var formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    appCubit cubit = appCubit.get(context);
    cubit.getMessages(model.uid);

    return BlocConsumer<appCubit, appStates>(
      listener: (context, state) {},
      builder: (context, state) {
        appCubit cubit = appCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '${model.name}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5, right: 10),
            child: Column(
              children: [
                if(cubit.listMessages.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                    itemCount: cubit.listMessages.length,
                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                    itemBuilder: (context, index) {
                      if(cubit.listMessages[index].idSender == uid)
                        return MyMessage(cubit.listMessages[index]);
                      else
                        return ReceiveMessage(cubit.listMessages[index]);
                    },
                ),
                  ),
                SizedBox(height: 10,),
                Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'type your message here ...',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            if(messageController.text.isNotEmpty){
                              cubit.sendMessage(model.uid, DateTime.now().toString(), messageController.text);
                              messageController.clear();
                            }
                          },
                          icon: Icon(IconBroken.Send),
                        ),
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

  Widget ReceiveMessage(MessageModel model) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
        ),
        child: Text(
          '${model.message}',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white
          ),
        ),
      ),
    ],
  );
  Widget MyMessage(MessageModel model) => Row(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Text(
          '${model.message}',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white
          ),
        ),
      ),
    ],
  );
}
