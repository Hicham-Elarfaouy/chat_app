import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_cubit.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/modules/open_chat_module/open_chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit, appStates>(
      listener: (context, state) {},
      builder: (context, state) {
        appCubit cubit = appCubit.get(context);

        return Column(
          children: [
            if(cubit.users.isNotEmpty)
              Expanded(
              child: ListView.separated(
                itemCount: cubit.users.length,
                separatorBuilder: (context, index) => SizedBox(height: 10,),
                itemBuilder: (context, index) => InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (newcontext) => BlocProvider.value(
                          value: BlocProvider.of<appCubit>(context),
                          child: OpenChatScreen(cubit.users[index]),
                        )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage('${cubit.users[index].image}'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${cubit.users[index].name}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
