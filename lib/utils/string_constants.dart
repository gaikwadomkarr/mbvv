String TOKEN = "";
String TOKEN_EXPIRES = "";
String REFRESH_TOKEN = "";
String REFRESH_TOKEN_EXPIRES = "";
String BASEURL = 'http://192.168.0.103:3013';
String addNewCriminal = '/criminal';
String addcheckupFormUrl = '/criminal/form/';
String checkuphistroyUrl = '/criminal/checkup-history/';
String profileUrl = '/users/me/';
String searchaccusedUrl = '/criminal/search?searchQuery=';
String loginUrl = '/auth/signin';
String uploadFile = '/criminal/multipleUpload';
String specialUnit = 'specialUnit';
String policeStation = 'policeStation';
String panregex = "[A-Z]{5}[0-9]{4}[A-Z]{1}";
String electionidregex = "^([a-zA-Z]){3}([0-9]){7}?\$/g";
String passportregex = "^[A-Z][0-9]{7}\$";
String vehicleregex = "^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}\$";
String aadharCardregex = "^[0-9]{4} [0-9]{4} [0-9]{4}\$";
List<String> specialUnits = [
  "Select Unit",
  "policeHeadQuarter",
  "controlRoom",
  "cyberCrimeCell",
  "economicOffenceWing",
  "specialBranch",
  "trafficBranch",
  "crimeBranch",
  "motorTransportBranch",
  "wirelessBranch"
];
List<String> policeStations = [
  'Police Station',
  'achole',
  'arnala',
  'bhayandar',
  'bollij',
  'kashimira',
  'mandavi',
  'manikpur',
  'miraRoad',
  'nallasopara',
  'navghar',
  'nayagaon',
  'nayanagar',
  'pelhar',
  'tulinj',
  'uttanSagari',
  'vasai',
  'virar',
  'waliv'
];
const Map<String, dynamic> ennglishMarathi = {
  "recordcheckformen": 'Form for checking accused on record',
  "recordcheckformmr": 'रेकॉर्डवरील आरोपी चेक करण्याचा फॉर्म',
  "taglineen":
      'Initiative by\nCrime branch\nMira-Bhayander, Vasai-Virar Police Commissionrate',
  "taglinemr": 'मीरा-भाईंदर, वसई-विरार पोलीस उपक्रम',
  "useriden": 'User Id',
  "useridmr": 'युझर आयडी',
  "passworden": 'Password',
  "passwordmr": 'पासवर्ड',
  "loginen": 'Login',
  "loginmr": 'लॉग इन करा',
  "homeen": 'Home',
  "homemr": 'होम',
  "profileen": 'Profile',
  "profilemr": 'प्रोफाइल',
  "accusednameen": 'Full Name',
  "accusednamemr": 'आरोपीचे नाव',
  "accusedaliasnameen": 'Alias Name',
  "accusedaliasnamemr": 'आरोपीचे नाव',
  "accusedaddressen": 'Address',
  "accusedaddressmr": 'आरोपीचा पत्ता',
  "mobilenumberen": 'Mobile Number',
  "mobilenumbermr": 'मोबाईल नंबर',
  "passportnoen": 'Passport Number',
  "passportnomr": 'पासपोर्ट क्रमांक',
  "bankacntnoen": 'Bank Account Number',
  "bankacntnomr": 'बँक अकाउंट नंबर',
  "pannoen": 'PAN Number',
  "pannomr": 'पॅनकार्ड नंबर',
  "electionen": 'Election ID Number',
  "electionmr": 'पॅनकार्ड नंबर',
  "submiten": 'SUBMIT',
  "submitmr": 'नोंदणी करा',
  "policestatiionen": 'Police Station',
  "policestatiionmr": 'पोलीस ठाण',
  "firnoen": 'FIR No.',
  "firnomr": 'गुन्हा रजिस्टर नंबर',
  "sectionen": 'Section No.',
  "sectionmr": 'कलम',
  "currentworken": 'Current Work',
  "currentworkmr": 'सध्या करीत असलेले काम',
  "currentworkcompanyen": 'Current Work Organization / Company name',
  "currentworkcompanymr": 'सध्या करीत असलेले काम',
  "companyemployernameen": 'Employer / Company Owner Name',
  "companyemployernamemr": 'सध्या करीत असलेले काम',
  "employeraddressen": 'Employer / Company Owner Address',
  "employeraddressmr": 'सध्या करीत असलेले काम',
  "doesdrugen": 'Whether this accused often takes NDPS Drugs or alcohol?',
  "doesdrugmr": 'अमली पदार्थाचे सेवन करतो का?',
  "yesen": 'Yes',
  "yesmr": 'हो',
  "noen": 'No',
  "nomr": 'नाही',
  "nexten": 'Next',
  "nextmr": 'पुढे जा',
  "moreinfoen": 'Does the accused know about other accused?',
  "moreinfomr": 'गुन्हेगारांबाबत आणखी माहिती',
  "sometimesen": 'Sometimes',
  "sometimesmr": 'समटाइम्स',
  "whichdrugsen": 'Which Drugs',
  "whichdrugsmr": 'अमली पदार्थ',
  "policestationlisten": [
    'Police Station',
    'achole',
    'arnala',
    'bhayandar',
    'bollij',
    'kashimira',
    'mandavi',
    'manikpur',
    'miraRoad',
    'nallasopara',
    'navghar',
    'nayagaon',
    'nayanagar',
    'pelhar',
    'tulinj',
    'uttanSagari',
    'vasai',
    'virar',
    'waliv'
  ],
  "policestationlistmr": [
    'पोलीस स्टेशन निवडा',
    'आचोळे',
    'अर्नाळ',
    'भाईंदर',
    'बोळीज',
    'काशिमीरा',
    'मांडवी',
    'माणिकपूर',
    'मीरा रोड',
    'नालासोपारा',
    'नवघर',
    'नायगाव',
    'नयनगर',
    'पेल्हार',
    'तुळींज',
    'उत्तान सागरी',
    'वसई',
    'विरार',
    'वाळीव'
  ],
  "modusopoerandien": [
    'HBT',
    'Theft',
    'Motor Vehicle Theft (Auto)',
    'Motor Vehicle Theft (2W)',
    'Motor Vehicle Theft (4W)',
    'Motor Vehicle Theft (Heavy Vehicle)',
    'Chain Snatching',
    'Robbery',
    'Decoity',
    'Bogus Police',
    'NDPS (Consumption)',
    'NDPS (Possession)',
    'Cheating and Forgery',
    'Extortion',
    'Kidnapping',
    'Rape / Molestation',
    'Option 17',
    'Assault',
    'Fire Arm',
    'Illicit Liquor',
    'Murder'
  ]
};