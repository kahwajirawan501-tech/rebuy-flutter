import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/network/network_banner.dart';
import 'package:roasters/core/network/network_retry_mixin.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/features/my_favorits/domain/entities/favorite_entity.dart';
import 'package:roasters/features/my_favorits/presentation/cubit/cubit.dart';
import 'package:roasters/features/my_favorits/presentation/cubit/state.dart';
import 'package:roasters/features/my_favorits/presentation/widgets/item_card_favorite.dart';
import 'package:roasters/shared/widgets/buttons/app_back_button.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}


class _FavoritePageState extends State<FavoritePage>  with NetworkRetryMixin {

  bool isLoading = false;

  void _loadData() {
    if (isLoading) return;

    isLoading = true;


    context.read<FavoriteCubit>().getFavorites();
    Future.delayed(Duration(seconds: 1), () {
      isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().getFavorites();
    listenNetwork(() {
      _loadData();
    });
  }
  @override
  Widget build(BuildContext context) {
    var size=AppSizes.instance;
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body:SafeArea(
        child: Stack(
          children: [
            Padding(

                padding:
                EdgeInsets.symmetric(horizontal:size.padding.screenHorizontal ,
                 ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top:size.padding.screenVertical),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [

                        Text(
                          AppLocalizations.of(context).translate("favorites_title"),

                          style: AppTextStyles.dosisExtraBold32(),
                          overflow: TextOverflow.ellipsis, // إذا ضاق المكان يختصر النص
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.spacing.medium,),
                  Expanded(
                    child: BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, state) {
                        List<FavoriteEntity> favorites = [];

                        if (state is FavoriteLoading) return const Center(child: AppLoader());
                        if (state is FavoriteEmpty) {
                          return Center(child: Text(AppLocalizations.of(context).translate("favorites_empty_ui"),
                              style: AppTextStyles.firaMedium18()));
                        }

                        if (state is FavoriteError) {
                          showToast(    text: AppLocalizations.of(context).translate(state.message),
                              state: ToastStates.SUCCESS);
                          return Center(
                            child: IconButton(
                              icon:  Icon(Icons.refresh,size:size.icons.medium ,),
                              onPressed: () {
                                context.read<FavoriteCubit>().getFavorites();
                              },
                            ),
                          );
                        }
                        if(state is AddRemoveFavoriteError){
                          {
                            showToast(
                              text: AppLocalizations.of(context).translate(state.message),
                              state: ToastStates.SUCCESS,
                            );
                            favorites=context.read<FavoriteCubit>().products;
                          }
                        }
                        if (state is FavoriteSuccess) favorites = state.favorite;

                        return  ListView.separated
                          (itemBuilder: (context, index) {
                          final favorite = favorites[index].product;

                          return ItemCard(
                            product: favorite,
                           );
                        },
                            separatorBuilder: (context, index) => SizedBox(height: size.spacing.small,),
                            itemCount:favorites.length);
                      },


                    ),
                  )
                ],
              ),

                ),
            const NetworkOverlay(),

          ],
        ),
      ) ,
    );
  }
}
