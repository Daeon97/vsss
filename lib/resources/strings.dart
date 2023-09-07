// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

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
const messageKey = 'message';
const defaultKey = 'default';
const partKey = 'part';
const snippetValue = 'snippet';
const qKey = 'q';
const maxResultsKey = 'maxResults';
const keyKey = 'key';

// Endpoints
const chatBaseUrl = 'https://hook.eu1.make.com';
const courseRecommendationBaseUrl = 'https://youtube.googleapis.com/youtube/v3';

// Paths
const searchPath = '/search';

// Instance names
const chatBaseUrlInstanceName = 'chatBaseUrl';
const courseRecommendationBaseUrlInstanceName = 'courseRecommendationBaseUrl';
const forChatsInstanceName = 'forChats';
const forCourseRecommendationsInstanceName = 'forCourseRecommendations';

// .env key names
const chatPath = 'CHAT_PATH';
const youtubeDataApiKey = 'YOUTUBE_DATA_API_KEY';

// Asset paths
const _assetsPath = 'assets';
const helloIllustrationPath = '$_assetsPath/hello_illustration.png';
const robotPath = '$_assetsPath/robot.png';
const welcomeIllustrationPath = '$_assetsPath/welcome_illustration.png';
const serverDownIllustrationPath = '$_assetsPath/server_down_illustration.png';

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
    'Welcome to the StudentEase chat section. How may we help you today';
const relatedToLiteral = 'related to';
const deleteLiteral = 'Delete';
const couldNotRetrieveRecommendationsLiteral =
    'Could not retrieve recommendations';

// Options
const option1LongLiteral =
    'Can you provide guidance on how to balance my academic workload with extracurricular activities and part-time job opportunities';
const option1ShortLiteral = 'Academic workload balance';
const option2FirstPartLongLiteral =
    'Are there any research or internship opportunities';
const option2SecondPartLongLiteral =
    'that you recommend I pursue to gain practical experience';
const option2ShortLiteral = 'Research or internship';
const option3LongLiteral =
    'How can I improve my study habits and time management skills to perform better academically';
const option3ShortLiteral = 'Improve study habits';

// Special characters
const emptyString = '';
const whiteSpace = ' ';
const comma = ',';
const fullStop = '.';
const waveEmoji = '👋';
const fowardSlash = '/';
const threeDots = '...';

// Regex
const nameSplitRegexPattern = r'\s';

// Hive DB boxes
const chatsBox = 'chatsBox';
const chatsUtilsBox = 'chatsUtilsBox';

// Hive DB box keys
const initialChatOpenKey = 'initialChatOpen';
