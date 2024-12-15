final Map<String, List<Map<String, String>>> loan = {
  'awcc': [{'10': '707'}, {'20': '707'}],
  'etisalat': [
    {'10': '3000'},
    {'20': '3000'},
    {'40': '3000'},
    {'80': '3000'},
  ],
  'mtn': [
    {'10': '404'},
    {'20': '404'},
    {'30': '404'},
    {'40': '404'},
    {'60': '404'},
    {'100': '404'},
    {'150': '404'},
    {'200': '404'},
  ],
  'roshan': [{'': '*122#'}],
  'salaam': [{'': '*742#'}],
};

final Map<String, String> customersCare = {
  'awcc': '151',
  'etisalat': '888',
  'mtn': '779',
  'roshan': '333',
  'salaam': '744',
};

final Map<String, String> checkBalance = {
  'awcc': '*123#',
  'etisalat': '*123#',
  'mtn': '*789#',
  'roshan': '*444#',
  'salaam': '*888#',
};

Map<String, Map<String, String>> apn = {
  'awcc': {'Name': 'AWCC WEB', 'APN': 'internet', 'MCC': '412', 'MNC': '50'},
  'etisalat': {'Name': 'Etisalat WEB', 'APN': 'etisalat.af.web', 'MCC': '412', 'MNC': '50'},
  'mtn': {'Name': 'MTN WEB', 'APN': 'internet.mtn.com.af', 'MCC': '412', 'MNC': '50'},
  'roshan': {'Name': 'Roshan WEB', 'APN': 'internet', 'MCC': '412', 'MNC': '50'},
  'salaam': {'Name': 'Salaam WEB', 'APN': 'salaam', 'MCC': '412', 'MNC': '50'},
};

Map<String, String> balanceTransfer = {
  'awcc': '*444*1*',
  'etisalat': '*125*',
  'mtn': '*776*2*',
  'roshan': '*123*',
  'salaam': '*741*',
};

Map<String, Map<String, String>> fourGActivate = {
  'awcc': {'': '4444'},
  'etisalat': {'4G': '3378'},
  'mtn': {},
  'roshan': {'3g': '555'},
  'salaam': {'data': ' 740'},
};

