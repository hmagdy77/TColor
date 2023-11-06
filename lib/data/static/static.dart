import '../../../core/constants/app_image_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../models/on_boarding_model.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      title: AppStrings.onBoardingOneTitle,
      body: AppStrings.onBoardingOneContent,
      image: AppImageAssets.onBoardingOne),
  OnBoardingModel(
      title: AppStrings.onBoardingTwoTitle,
      body: AppStrings.onBoardingTwoContent,
      image: AppImageAssets.onBoardingTwo),
  OnBoardingModel(
      title: AppStrings.onBoardingThreeTitle,
      body: AppStrings.onBoardingThreeContent,
      image: AppImageAssets.onBoardingThree),
];
