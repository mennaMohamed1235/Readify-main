import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/widgets/loading_widget.dart';
import 'package:fruit_e_commerce/core/widgets/search_bar_widget.dart';
import 'package:fruit_e_commerce/features/ai/presentation/blocs/cubit/ai_cubit.dart';
import 'package:fruit_e_commerce/features/ai/presentation/widgets/search_ai_widget.dart';

class AiSearchWithDesc extends StatelessWidget {
  const AiSearchWithDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: context.getHight(divide: 0.06), left: context.getWidth(divide: 0.037), right: context.getWidth(divide: 0.037), bottom: context.getHight(divide: 0.05)),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            SearchBarWidget(
              onChanged: (query) {
                context.read<AiCubit>().aiSearch(query);
              },
            ),
            SizedBox(
              height: context.getHight(divide: 0.02),
            ),
            BlocBuilder<AiCubit, AiState>(
              builder: (context, state) {
                if (state is SearchAiLoadingState) {
                  return const LoadingWidget();
                }
                if (state is SearchAiSuccessState) {
                  return SizedBox(
                    height: context.getHight(divide: 0.7),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: context.getHight(divide: 0.02),
                          );
                        },
                        itemCount: state.searchResults.length,
                        itemBuilder: (_, index) => SearchAiWidget(
                              text: state.searchResults[index],
                            )),
                  );
                }
                return const Align(
                    alignment: Alignment.bottomRight,
                    child: Image(
                      image: AssetImage('assets/icons/chat_bot_search_image.png'),
                      filterQuality: FilterQuality.high,
                    ));
              },
            ),
          ]),
        ),
      );
}
