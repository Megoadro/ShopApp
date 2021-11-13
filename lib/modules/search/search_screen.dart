import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/compenents.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defalutFormfeild(
                        controller: searchController,
                        type: TextInputType.name,
                        valdiate: (String value) {
                          if (value.isEmpty) {
                            return 'Pleas input text search';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        onSubmited: (String text){
                          SearchCubit.get(context).search(text);
                        }
                      ),
                      const SizedBox(height: 20.0,),
                      if(state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 20.0,),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context).model.data.data[index],
                              context,isOldPrice : false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context).model.data.data.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
