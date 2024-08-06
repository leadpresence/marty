import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/provider/app_provider.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'riverpod/provider/select_lang_provider.dart';
import 'widgets/language_item_widget.dart';

class SelectLangPage extends ConsumerStatefulWidget {
  final bool isRequired;

  const SelectLangPage({Key? key, required this.isRequired}) : super(key: key);

  @override
  ConsumerState<SelectLangPage> createState() => _SelectLangPageState();
}

class _SelectLangPageState extends ConsumerState<SelectLangPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref
            .read(selectLangProvider.notifier)
            .getLanguages(isRequired: widget.isRequired);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(selectLangProvider);
    final notifier = ref.read(selectLangProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isLoading || state.isSaving,
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: AppColors.mainBackground(),
          extendBody: true,
          appBar: CommonAppBar(
            title: AppHelpers.getTranslation(TrKeys.selectLanguage),
            hasBack: !widget.isRequired,
            onLeadingPressed: context.popRoute,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 60,
                  padding: REdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBack(),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    onChanged: notifier.onSearch,
                    cursorWidth: 1.r,
                    cursorColor: AppColors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          AppHelpers.getTranslation(TrKeys.searchLanguage),
                      prefixIcon: Icon(
                        FlutterRemix.search_2_line,
                        size: 20.sp,
                        color: AppColors.secondaryIconTextColor(),
                      ),
                      hintStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        letterSpacing: -0.5,
                        color: AppColors.secondaryIconTextColor(),
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
                state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3.r,
                          color: AppColors.green,
                        ),
                      )
                    : Column(
                        children: state.languages.map(
                          (item) {
                            return LanguageItemWidget(
                              isChecked: state.selectedLanguage?.id == item.id,
                              text: item.title,
                              imageUrl: item.img,
                              onPress: () => notifier.setSelectedLanguage(item),
                            );
                          },
                        ).toList(),
                      ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: REdgeInsets.only(bottom: 30, left: 16, right: 16),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
              ),
              onPressed: () {
                if (widget.isRequired) {
                  notifier.makeSelectedLang(
                    context,
                    widget.isRequired,
                    afterUpdating: () {
                      ref
                          .read(appProvider.notifier)
                          .changeLocale(state.selectedLanguage);
                    },
                  );
                } else {
                  notifier.changeLang(
                    context,
                    afterUpdating: () {
                      ref
                          .read(appProvider.notifier)
                          .changeLocale(state.selectedLanguage);
                    },
                  );
                }
              },
              child: Container(
                width: 1.sw - 30,
                height: 60.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: state.isSaving
                    ? SizedBox(
                        height: 20.r,
                        width: 20.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.r,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        AppHelpers.getTranslation(TrKeys.next),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: AppColors.white,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
