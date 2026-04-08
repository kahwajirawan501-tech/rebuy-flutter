import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/network/network_banner.dart';
import 'package:roasters/core/network/network_retry_mixin.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/features/profile/presentation/cubit/cubit_languages.dart';
import 'package:roasters/features/search/domain/entities/product_search_entity.dart';
import 'package:roasters/features/search/presentation/cubit/cubit.dart';
import 'package:roasters/features/search/presentation/cubit/state.dart';
import 'package:roasters/features/search/presentation/widget/box_type_product.dart';
import 'package:roasters/features/search/presentation/widget/product_item.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/state.dart';
import 'package:roasters/shared/widgets/inputs/app_search_field.dart';
import 'package:roasters/shared/widgets/loaders/app_loader.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>  with NetworkRetryMixin  {
  final size = AppSizes.instance;
  final searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  int? typeId;
  int? selectedProvinceId;
  int selectedIndex = 0;
  bool isLoading = false;

  void _loadData() {
    if (isLoading) return;

    isLoading = true;

    context.read<SearchCubit>().getSearch(
      typeId: typeId!,
      provinceId: selectedProvinceId,
      text: searchController.text,
      isRefresh: true,
    );

    Future.delayed(Duration(seconds: 1), () {
      isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    listenNetwork(() {
      _loadData();
    });
  }

  void _onScroll() {
    if (typeId == null) return;
    final cubit = context.read<SearchCubit>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent &&
        cubit.state is SearchSuccess &&
        !(cubit.state as SearchSuccess).hasReachedMax) {
      cubit.getSearch(
        typeId: typeId!,
        provinceId: selectedProvinceId,
        text: searchController.text,
      );
    }
  }

  void _onSearchChanged(String value) {
    if (typeId == null) return;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchCubit>().getSearch(
        typeId: typeId!,
        provinceId: selectedProvinceId,
        text: value,
        isRefresh: true,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.padding.screenHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.padding.screenVertical),
                  Text(AppLocalizations.of(context).translate("search_page_title"), style: AppTextStyles.dosisExtraBold32()),
                  SizedBox(height: size.spacing.medium),
                  AppSearchField(
                    controller: searchController,
                    hint:AppLocalizations.of(context).translate("search_page_search_hint"),
                    onChanged: _onSearchChanged,
                  ),
                  SizedBox(height: size.spacing.medium),


                  // الأنواع
                  BlocBuilder<SharedCubit, SharedState>(
                    builder: (context, state) {
                      if (state is SharedLoaded && state.types.isNotEmpty) {
                        final types = state.types;
                        if (typeId == null) {
                          typeId = types[0].id;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context.read<SearchCubit>().getSearch(
                              typeId: typeId!,
                              provinceId: selectedProvinceId,
                              text: searchController.text,
                              isRefresh: true,
                            );
                          });
                        }
                        return SizedBox(
                          height: size.buttons.smallHeight,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: types.length,
                            separatorBuilder: (_, __) => SizedBox(width: size.spacing.small),
                            itemBuilder: (context, index) {
                              final type = types[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    typeId = type.id;
                                    context.read<SearchCubit>().getSearch(
                                      typeId: typeId!,
                                      provinceId: selectedProvinceId,
                                      text: searchController.text,
                                      isRefresh: true,
                                    );
                                  });
                                },
                                child: BoxTypeProduct(
                                  text: type.name,
                                  isSelected: selectedIndex == index,
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(height: size.spacing.small),
                  // المحافظات
                  BlocBuilder<SharedCubit, SharedState>(
                    builder: (context, state) {
                      final isRtl = Directionality.of(context) == TextDirection.rtl;

                      if (state is SharedLoaded && state.provinces.isNotEmpty) {
                        return Align(
                          alignment: isRtl ? Alignment.topLeft : Alignment.topRight,
                          child: DropdownButton<int?>(
                            elevation: 0,
                            value: selectedProvinceId,
                            dropdownColor: AppColors.backgroundSearchBox,
                            borderRadius: BorderRadius.circular(size.borderRadius.extraLarge),
                            items: [
                               DropdownMenuItem<int?>(
                                value: null,
                                child: Text(
                               AppLocalizations.of(context).translate("search_page_select_province"),
                                  style: AppTextStyles.firaMedium16(color: AppColors.textPrimaryDark)),


                              ),
                              ...state.provinces.map(
                                    (p) => DropdownMenuItem<int?>(
                                  value: p.id,
                                  child: Text(
                                    p.name,
                                    style: AppTextStyles.firaMedium16(color: AppColors.textPrimaryDark),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedProvinceId = value;
                                context.read<SearchCubit>().getSearch(
                                  typeId: typeId!,
                                  provinceId: selectedProvinceId,
                                  text: searchController.text,
                                  isRefresh: true,
                                );
                              });
                            },
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),              // قائمة المنتجات
                  Expanded(
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if (state is SearchLoading) return const Center(child: AppLoader());
                        if (state is SearchEmpty) {
                          return Center(child:
                          Text(AppLocalizations.of(context).translate("search_page_no_items"),
                              style: AppTextStyles.firaMedium18()));
                        }
                        if (state is SearchError) {
                          showToast(text: state.message, state: ToastStates.SUCCESS);

                          return Center(
                            child: IconButton(
                              icon:  Icon(Icons.refresh,size:size.icons.medium ,),
                              onPressed: () {
                                context.read<SearchCubit>().getSearch(
                                  typeId: typeId!,
                                  provinceId: selectedProvinceId,
                                  text: searchController.text,
                                  isRefresh: true,
                                );
                              },
                            ),
                          );

                        }

                        List<ProductSearchEntity> products = [];
                        bool isLoadingMore = false;
                          if(state is SearchFavoriteError){
                            {
                              showToast(text: state.message, state: ToastStates.SUCCESS);
                              products = context.read<SearchCubit>().products;

                            }
                          }
                        if (state is SearchSuccess) products = state.products;
                        if (state is SearchLoadingMore) {
                          products = state.products;
                          isLoadingMore = true;
                        }

                        return ListView.separated(
                          controller: _scrollController,
                          itemCount: products.length + (isLoadingMore ? 1 : 0),
                          separatorBuilder: (_, __) => SizedBox(height: size.spacing.medium),
                          itemBuilder: (context, index) {
                            if (index >= products.length) return const AppLoader();
                            final product = products[index];
                            return ProductItem(
                              key: ValueKey(product.id),
                              sellerName: product.user,
                              sellerProfileImage: product.user.profileImage,
                              productDescription: product.description,
                              productPrice: product.price,
                              imageUrls: product.images,
                              addressText: product.addressText,
                              contact: product.contacts,
                              isSold: product.isSold,
                              province: product.province.name,
                              createdAt: product.createdAt,
                              isFavorite: product.isFavorite,
                              id: product.id,

                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const NetworkOverlay(),

          ],
        ),
      ),
    );
  }
}