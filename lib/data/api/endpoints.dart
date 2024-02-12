class EndPoints {
  static const login = 'auth/local';
  static const register = 'auth/local/register';
  static const predict = 'predict';
  static const getProfile = 'get-profile';
  static const setProfile = 'set-profile';
  static const forgotPassword = 'auth/forgot-password-mobile';
  static const resetPassword = 'auth/reset-password';
  static const getHorses = "horse-infos/get-info";
  static const registerHorse = "horse-infos/";
  static const getBreeds = "breeds";
  static const testData = "tests-data";
  static const preTestRequirements = "pre-test-requirements";
  static const getTestData = "tests-data/get-info?sort=id:desc";
  static const getTestInstructionData = "test-procedures?populate=*";
  static const getConfig = "config";
}
