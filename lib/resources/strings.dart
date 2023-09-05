// ignore_for_file: public_member_api_docs

// Routes
const defaultScreenRoute = '/';
const onboardingScreenRoute = '/onboarding';
const chatScreenRoute = '/chat';
const homeScreenRoute = '/home';

// Keys/values
const onboardingKey = 'onboarding';
const contentTypeKey = 'Content-Type';
const contentTypeValue = 'application/json';
const acceptKey = 'Accept';
const acceptValue = '*/*';
const authorizationKey = 'Authorization';
const bearerValue = 'Bearer';

// Endpoint
const baseUrl = 'https://hook.eu1.make.com';

// .env key names
const chatPath = 'CHAT_PATH';

// Asset paths
const _assetsPath = 'assets';
const helloIllustrationPath = '$_assetsPath/hello_illustration.png';
const welcomeIllustrationPath = '$_assetsPath/welcome_illustration.png';

// UI literals
const helloLiteral = 'Hello';
const whatIsYourNameAndCourseOfStudyLiteral =
    'What is your name and course of study?';
const nameFieldCannotBeEmptyLiteral = 'Name field cannot be empty';
const nameLiteral = 'Name';
const courseOfStudyLiteral = 'Course of study';
const computerScienceLiteral = 'Computer Science';
const massCommunicationLiteral = 'Mass Communication';
const economicsLiteral = 'Economics';
const selectCourseOfStudyLiteral = 'Please select a course of study';
const welcomeToStudentEaseLiteral = 'Welcome to StudentEase';
const yourPersonalizedVirtualStudentSupportServiceLiteral =
    'Your personalized virtual student support service';
const chatLiteral = 'Chat';
const couldNotGetChatsLiteral = 'Could not get chats';
const couldNotSendMessageLiteral = 'Could not send message';
const initialMessage =
    'Welcome to the virtual support service. How may we help you today';

// Options
// ignore: lines_longer_than_80_chars
const option1LongLiteral =
    'Can you provide guidance on how to balance my academic workload with extracurricular activities and part-time job opportunities';
const option1ShortLiteral = 'Academic workload balance';
const option2FirstPartLongLiteral =
    'Are there any research or internship opportunities related to ';
const option2SecondPartLongLiteral =
    ' that you recommend I pursue to gain practical experience';
const option2ShortLiteral = 'Research or internship';
const option3LongLiteral =
    'How can I improve my study habits and time management skills to perform better academically';
const option3ShortLiteral = 'Improve study habits';

// Special characters
const emptyString = '';
const whiteSpace = ' ';
const comma = ',';
const fullStop = '.';

// Regex
const nameSplitRegexPattern = r'\s';

// Hive DB boxes
const chatsBox = 'chatsBox';
const chatsUtilsBox = 'chatsUtilsBox';

// Hive DB box keys
const initialChatOpenKey = 'initialChatOpen';
