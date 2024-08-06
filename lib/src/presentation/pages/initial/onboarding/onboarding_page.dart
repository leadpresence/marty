import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/src/core/di/dependency_manager.dart';
import 'package:sundaymart/src/models/models.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils/utils.dart';
import '../../../theme/theme.dart';

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground(),
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0.075.sh, right: 16),
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(AppAssets.pngApplogoImage),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 0.075.sh, right: 16),
                      alignment: Alignment.centerRight,
                      child: Text(
                        AppHelpers.getTranslation(TrKeys.skip),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          letterSpacing: -1,
                          color: AppColors.iconAndTextColor(),
                        ),
                      ),
                    ),
                    onTap: () {
                      LocalStorage.instance.setOnBoarded(onboarded: true);
                      context.replaceRoute(const LoginRoute());
                    },
                  ),
                ],
              ),

              SizedBox(
                width: 1.sw,
                height: 0.4.sh,
                child: Container(
                  child: Image.asset(AppAssets.pngWelcomeImage,
                    fit: BoxFit.cover,),
                ) ,
              ),
              const SizedBox(
                height: 12,
              ),

              Container(
                alignment: AlignmentDirectional.center,
                child: const Text('Everything you need',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                child: const Text('from the stores near you',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 60,),
                        height: 50,
                        width: 50,
                        child: Image.asset(AppAssets.pngGlobusImage
                        , fit: BoxFit.fill,),
                        decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 40,),
                        height: 50,
                        width: 50,
                        child: Image.asset(AppAssets.pngShopriteImage,
                          fit: BoxFit.fill,),
                        decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 80,),
                        height: 50,
                        width: 50,
                        child: Image.asset(AppAssets.pngSparImage),
                        decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),

                      GestureDetector(

                        onTap: (){ context.replaceRoute(const SearchShopsRoute());

                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 120,),

                          alignment: AlignmentDirectional.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: AppColors.green,
                              borderRadius: BorderRadius.circular(18)
                          ),
                          child: const Text('+2534',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: AlignmentDirectional.center,
                child: const Text('Easy Shopping - Stress free',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              const SizedBox(
                height: 16,
              ),


              Container(
                width: 1.sw,
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.center,
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: InkWell(
                        onTap: () {
                          LocalStorage.instance.setOnBoarded(onboarded: true);
                          context.replaceRoute(const LoginRoute());
                        },

                        child: SizedBox(
                          width: 0.5.sw - 60,
                          child: Text(
                            AppHelpers.getTranslation(TrKeys.login),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: AppColors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.green,
                          ),
                          borderRadius: BorderRadius.circular(12),

                      ),
                      child: InkWell(
                        onTap: () {
                          LocalStorage.instance.setOnBoarded(onboarded: true);
                          // context.replaceRoute(const SignUpRoute());
                        },
                        child: SizedBox(
                          width: 0.5.sw - 60,
                          child: Text(
                            AppHelpers.getTranslation(TrKeys.signUp),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: AppColors.iconAndTextColor(),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
