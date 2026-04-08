import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/network/network_banner.dart';
import 'package:roasters/core/network/network_retry_mixin.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';
import 'package:roasters/features/my_product/presentation/cubit/cubit.dart';
import 'package:roasters/features/my_product/presentation/cubit/state.dart';
import 'package:roasters/features/my_product/presentation/widgets/item_card_product.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class MyProductPage extends StatefulWidget {
  const MyProductPage({super.key});

  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> with NetworkRetryMixin  {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  void _loadData() {
    if (isLoading) return;

    isLoading = true;


    context.read<MyProductCubit>().getMyProducts();

    Future.delayed(Duration(seconds: 1), () {
      isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<MyProductCubit>().getMyProducts();
    listenNetwork(() {
      _loadData();
    });
  }
  void _onScroll() {
    final cubit = context.read<MyProductCubit>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent &&
        cubit.state is MyProductSuccess &&
        !(cubit.state as MyProductSuccess).hasReachedMax) {
      cubit.getMyProducts();
    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              padding:EdgeInsets.symmetric(horizontal:size.padding.screenHorizontal ,
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
                          AppLocalizations.of(context).translate("my_products_title"),
                          style: AppTextStyles.dosisExtraBold32(),
                          overflow: TextOverflow.ellipsis, // إذا ضاق المكان يختصر النص
                        ),
                      ],
                    ),

                  ),
                  SizedBox(height: size.spacing.medium,),
                  Expanded(
                    child: BlocListener<MyProductCubit, MyProductState>(
                      listener: (context, state) {
                        if (state is RemoveMyProductLoading) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                              child: AppLoader(),
                            ),
                          );
                       Navigator.pop(context);
                        }

                        if(state is UpdateIsSoldError)
                        {
                          showToast(
                            text: AppLocalizations.of(context).translate(state.message),
                            state: ToastStates.SUCCESS,
                          );
                        }
                        if(state is RemoveProductError)
                        {
                          showToast(
                            text: AppLocalizations.of(context).translate(state.message),
                            state: ToastStates.SUCCESS,
                          );
                        }
                      }
                      ,child: BlocBuilder<MyProductCubit,MyProductState>(
                      builder: (context, state) {
                        List<ProductMyProductEntity> myProducts = [];

                    if (state is MyProductLoading) return const Center(child: AppLoader());
                    if (state is MyProductEmpty) {
                    return Center(child: Text(AppLocalizations.of(context).translate("my_products_empty_ui"),
                        style: AppTextStyles.firaMedium18()));

                    }
                    if (state is MyProductError) {
                      showToast(    text: AppLocalizations.of(context).translate(state.message)
                          , state: ToastStates.SUCCESS);
                    return Center(
                    child: IconButton(
                    icon:  Icon(Icons.refresh,size:size.icons.medium ,),
                    onPressed: () {
                    context.read<MyProductCubit>().getMyProducts(isRefresh: true,
                    );
                    },
                    ),
                    );
                    }

                    if (state is UpdateIsSoldError) {
                      myProducts = context.read<MyProductCubit>().products;
                    }
                        if (state is RemoveProductError) {
                          myProducts = context.read<MyProductCubit>().products;
                        }
                    bool isLoadingMore = false;
                    if (state is MyProductSuccess) myProducts = state.myProduct;
                    if (state is MyProductLoadingMore) {
                    myProducts = state.products;
                    isLoadingMore = true;
                    }
                    return  ListView.separated(
                      controller: _scrollController,
                    itemBuilder: (context, index) {
                    if (index >= myProducts.length) return const AppLoader();
                    final myProduct = myProducts[index];

                    return ItemCardProduct(
                      key: ValueKey(myProduct.id),

                      product: myProduct,
                    );
                    },
                    itemCount: myProducts.length + (isLoadingMore ? 1 : 0),
                    separatorBuilder: (_, __) => SizedBox(height: size.spacing.medium),);
                    },),)



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
