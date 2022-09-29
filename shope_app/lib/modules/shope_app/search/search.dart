import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/layout/shope_app/cubit/cubit.dart';
import 'package:mm/modules/shope_app/search/cuibt/cuibt.dart';
import 'package:mm/modules/shope_app/search/cuibt/states.dart';
import 'package:mm/shared/components/components.dart';

class SearchScreen extends StatelessWidget {


 var formKey = GlobalKey<FormState>();
 var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        textInputType: TextInputType.text,
                        validate:(value){
                          if(value!.isEmpty){
                            return ' Enter text to search';
                          }
                          return null;
                        },
                      onSubmit: (text){
                        SearchCubit.get(context).search(text);
                      },
                        label: 'Search',
                        prefixIcon: Icons.search,

                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index)=>buildListProducts(SearchCubit.get(context).model!.data!.data![index], context, isOldPrice: false),
                        separatorBuilder: (context, index)=>myDivider(),
                        itemCount: SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        },

      ),
    );
  }
}
