part of 'app_theme.dart';

class AppStyle extends ThemeExtension<AppStyle> {
  final Color thirdPartyAuthButtonColor;
  final Color thirdPartyAuthButtonTextColor;
  final Color popularSearchCardBgColor;
  final Color secondaryButtonBgColor;
  final Color secondaryScaffoldColor;
  final Color popularColor;
  final Color trendingColor;
  final Color successColor;
  final Color underProcessColor;
  final Color errorColor;
  final Color addFundsButtonColor;
  final Color positiveReturnBorderColor;
  final Color positiveReturnFillColor;
  final Color negativeReturnBorderColor;
  final Color negativeReturnFillColor;

  const AppStyle._({
    required this.thirdPartyAuthButtonColor,
    required this.thirdPartyAuthButtonTextColor,
    required this.secondaryScaffoldColor,
    required this.popularColor,
    required this.trendingColor,
    required this.successColor,
    required this.secondaryButtonBgColor,
    required this.underProcessColor,
    required this.errorColor,
    required this.addFundsButtonColor,
    required this.positiveReturnBorderColor,
    required this.positiveReturnFillColor,
    required this.negativeReturnBorderColor,
    required this.negativeReturnFillColor,
    required this.popularSearchCardBgColor,
  });

  factory AppStyle._darkTheme() {
    return const AppStyle._(
      thirdPartyAuthButtonTextColor: Colors.black,
      thirdPartyAuthButtonColor: Colors.white,
      popularSearchCardBgColor: Color(0xFF242424),
      secondaryScaffoldColor: Color(0xFF111111),
      popularColor: Color(0xFF7B3686),
      trendingColor: Color(0xFF365186),
      secondaryButtonBgColor: Color(0xFF242424),
      successColor: Color(0xFF368670),
      underProcessColor: Color(0xFF867436),
      errorColor: Color(0xFF863636),
      addFundsButtonColor: Color(0xFF368670),
      positiveReturnBorderColor: Color(0xFF368670),
      positiveReturnFillColor: Color(0xFF081411),
      negativeReturnBorderColor: Color(0xFF863636),
      negativeReturnFillColor: Color(0xFF140808),
    );
  }

  @override
  ThemeExtension<AppStyle> copyWith({
    Color? thirdPartyAuthButtonColor,
    Color? thirdPartyAuthButtonTextColor,
    Color? secondaryScaffoldColor,
    Color? popularColor,
    Color? trendingColor,
    Color? secondaryButtonBgColor,
    Color? successColor,
    Color? underProcessColor,
    Color? errorColor,
    Color? addFundsButtonColor,
    Color? popularSearchCardBgColor,
    Color? customOutlinedButtonFillColor,
    Color? positiveReturnBorderColor,
    Color? positiveReturnFillColor,
    Color? negativeReturnBorderColor,
    Color? negativeReturnFillColor,
  }) =>
      AppStyle._(
        thirdPartyAuthButtonColor:
        thirdPartyAuthButtonColor ?? this.thirdPartyAuthButtonColor,
        thirdPartyAuthButtonTextColor:
        thirdPartyAuthButtonTextColor ?? this.thirdPartyAuthButtonTextColor,
        popularSearchCardBgColor:
        popularSearchCardBgColor ?? this.popularSearchCardBgColor,
        popularColor: popularColor ?? this.popularColor,
        trendingColor: trendingColor ?? this.trendingColor,
        secondaryButtonBgColor:
        secondaryButtonBgColor ?? this.secondaryButtonBgColor,
        secondaryScaffoldColor:
        secondaryScaffoldColor ?? this.secondaryScaffoldColor,
        successColor: successColor ?? this.successColor,
        underProcessColor: underProcessColor ?? this.underProcessColor,
        errorColor: errorColor ?? this.errorColor,
        addFundsButtonColor: addFundsButtonColor ?? this.addFundsButtonColor,
        positiveReturnBorderColor:
        positiveReturnBorderColor ?? this.positiveReturnBorderColor,
        positiveReturnFillColor:
        positiveReturnFillColor ?? this.positiveReturnFillColor,
        negativeReturnBorderColor:
        negativeReturnBorderColor ?? this.negativeReturnBorderColor,
        negativeReturnFillColor:
        negativeReturnFillColor ?? this.negativeReturnFillColor,
      );

  @override
  ThemeExtension<AppStyle> lerp(ThemeExtension<AppStyle>? other, double t) {
    if (other is! AppStyle) return this;

    return AppStyle._(
      thirdPartyAuthButtonTextColor: Color.lerp(
        thirdPartyAuthButtonTextColor,
        other.thirdPartyAuthButtonTextColor,
        t,
      )!,
      thirdPartyAuthButtonColor: Color.lerp(
        thirdPartyAuthButtonColor,
        other.thirdPartyAuthButtonColor,
        t,
      )!,
      popularSearchCardBgColor: Color.lerp(
        popularSearchCardBgColor,
        other.popularSearchCardBgColor,
        t,
      )!,
      secondaryButtonBgColor:
      Color.lerp(secondaryButtonBgColor, other.secondaryButtonBgColor, t)!,
      secondaryScaffoldColor:
      Color.lerp(secondaryScaffoldColor, other.secondaryScaffoldColor, t)!,
      popularColor: Color.lerp(popularColor, other.popularColor, t)!,
      trendingColor: Color.lerp(trendingColor, other.trendingColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      underProcessColor:
      Color.lerp(underProcessColor, other.underProcessColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      addFundsButtonColor:
      Color.lerp(addFundsButtonColor, other.addFundsButtonColor, t)!,
      positiveReturnBorderColor: Color.lerp(
          positiveReturnBorderColor, other.positiveReturnBorderColor, t)!,
      positiveReturnFillColor: Color.lerp(
          positiveReturnFillColor, other.positiveReturnFillColor, t)!,
      negativeReturnBorderColor: Color.lerp(
          negativeReturnBorderColor, other.negativeReturnBorderColor, t)!,
      negativeReturnFillColor: Color.lerp(
          negativeReturnFillColor, other.negativeReturnFillColor, t)!,
    );
  }
}