class AppConstants {
  AppConstants._();

  // Storage Keys
  static const String keyToken = 'auth_token';
  static const String keyUser = 'user_data';
  static const String keyOnboarded = 'is_onboarded';
  static const String keyTheme = 'app_theme';

  // API
  static const String baseUrl = 'https://api.myclosly.com/v1';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Onboarding Steps
  static const int totalOnboardingSteps = 9;

  // Animation Durations
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 500);

  // OTP
  static const int otpLength = 4;
  static const int otpResendSeconds = 30;

  // Scanner
  static const double scannerAspectRatio = 3 / 4;
}

class AppStrings {
  AppStrings._();

  // Brand
  static const String appName = 'myClosly';
  static const String tagline = 'The social circle of shopping.';
  static const String aiTagline = 'AI finds the fashion you\'ll love.';

  // Splash / Landing
  static const String landingTitle = 'Your style.';
  static const String landingTitleItalic = 'Finally';
  static const String landingTitleEnd = 'understood';
  static const String createAccount = 'Create Account';
  static const String alreadyHaveAccount = 'I already have an account';

  // Auth
  static const String welcomeBack = 'Welcome back';
  static const String loginTitle = 'Log in to';
  static const String loginTitleItalic = 'your profile';
  static const String buildFeed = 'Start building your personal fashion feed.';
  static const String emailLabel = 'Email';
  static const String emailHint = 'Enter Email Address';
  static const String passwordLabel = 'Password';
  static const String passwordHint = 'Enter Your Password';
  static const String rememberMe = 'Remember Me';
  static const String forgotPassword = 'Forgot Password?';
  static const String continueBtn = 'Continue';
  static const String orText = 'OR';
  static const String noAccount = "Don't have an account?";
  static const String signUp = 'Sign Up';
  static const String haveAccount = 'Already have an account?';
  static const String login = 'Log In';

  // Register
  static const String nowHere = 'Now here..';
  static const String createTitle = 'Create';
  static const String createTitleItalic = 'your profile';
  static const String dobLabel = 'Date of Birth';
  static const String dobHint = 'MM/DD/YY';
  static const String genderLabel = 'Gender';
  static const String agreeTerms = 'I agree to the Terms & Service and Privacy Policy.';

  // Verify
  static const String lastStep = 'Last step';
  static const String verifyTitle = 'Verify your';
  static const String verifyTitleItalic = 'Account';
  static const String sentCode = "We've sent a code";
  static const String toYourEmail = 'to your email.';
  static const String enterCode = 'Enter the 4-digit code to verify your account.';
  static const String verifyBtn = 'Verify';
  static const String sendCodeAgain = 'Send code again';

  // Onboarding
  static const String aiPoweredFashion = 'AI-POWERED FASHION';
  static const String letAiCreate = 'Let AI Create';
  static const String yourStyle = 'your style.';
  static const String onboardingSubtitle =
      'Answer a few quick questions so we can build your personal fashion feed — tailored to your DNA, location & taste.';
}