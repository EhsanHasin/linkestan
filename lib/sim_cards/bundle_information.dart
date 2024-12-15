class BundleInfo{

  List<Map<String, String>>monthly;
  List<Map<String, String>> weekly;
  List<Map<String, String>> nightly;
  List<Map<String, String>> daily;

  BundleInfo({required this.monthly,
    required this.weekly,
    required this.nightly,
    required this.daily});
}


Map<String, List<Map<String, BundleInfo>>> companiesBundles = {
    'awcc' : [
      {'internet bundles': BundleInfo(monthly: awccInternetBundles['monthly']!, weekly: awccInternetBundles['weekly']!, nightly: awccInternetBundles['nightly']!, daily: awccInternetBundles['daily']!)},
      {'voice bundles': BundleInfo(monthly: awccVoiceBundles["monthly"]!, weekly: awccVoiceBundles['weekly']!, nightly: awccVoiceBundles['nightly']!, daily: awccVoiceBundles['daily']!)},
      {'sms bundles': BundleInfo(monthly: awccSMSBundles['monthly']!, weekly: awccSMSBundles['weekly']!, nightly: awccSMSBundles['nightly']!, daily: awccSMSBundles['daily']!)},
    ],
    'etisalat' : [
      {'internet bundles': BundleInfo(monthly: etisalatInternetBundles['monthly']!, weekly: etisalatInternetBundles['weekly']!, nightly: etisalatInternetBundles['nightly']!, daily: etisalatInternetBundles['daily']!)},
      {'voice bundles': BundleInfo(monthly: etisalatVoiceBundles['monthly']!, weekly: etisalatVoiceBundles['weekly']!, nightly: etisalatVoiceBundles['nightly']!, daily: etisalatVoiceBundles['daily']!)},
      {'sms bundles': BundleInfo(monthly: etisalatSMSBundles['monthly']!, weekly: etisalatSMSBundles['weekly']!, nightly: etisalatSMSBundles['nightly']!, daily: etisalatSMSBundles['daily']!)},
    ],
    'mtn' : [
      {'internet bundles': BundleInfo(monthly: mtnInternetBundles['monthly']!, weekly: mtnInternetBundles['weekly']!, nightly: mtnInternetBundles['nightly']!, daily: mtnInternetBundles['daily']!)},
      {'voice bundles': BundleInfo(monthly: mtnVoiceBundles['monthly']!, weekly: mtnVoiceBundles['weekly']!, nightly: mtnVoiceBundles['nightly']!, daily: mtnVoiceBundles['daily']!)},
      {'sms bundles': BundleInfo(monthly: mtnSMSBundles['monthly']!, weekly: mtnSMSBundles['weekly']!, nightly: mtnSMSBundles['nightly']!, daily: mtnSMSBundles['daily']!)},
    ],
    'roshan' : [
      {'internet bundles': BundleInfo(monthly: roshanInternetBundles['monthly']!, weekly: roshanInternetBundles['weekly']!, nightly: roshanInternetBundles['nightly']!, daily: roshanInternetBundles['daily']!)},
      {'voice bundles': BundleInfo(monthly: roshanVoiceBundles['monthly']!, weekly: roshanVoiceBundles['weekly']!, nightly: roshanVoiceBundles['nightly']!, daily: roshanVoiceBundles['daily']!)},
      {'sms bundles': BundleInfo(monthly: roshanSMSBundles['monthly']!, weekly: roshanSMSBundles['weekly']!, nightly: roshanSMSBundles['nightly']!, daily: roshanSMSBundles['daily']!)},
    ],
    'salaam' : [
      {'internet bundles': BundleInfo(monthly: salaamInternetBundles['monthly']!, weekly: salaamInternetBundles['weekly']!, nightly: salaamInternetBundles['nightly']!, daily: salaamInternetBundles['daily']!)},
      {'voice bundles': BundleInfo(monthly: salaamVoiceBundles['monthly']!, weekly: salaamVoiceBundles['weekly']!, nightly: salaamVoiceBundles['nightly']!, daily: salaamVoiceBundles['daily']!)},
      {'sms bundles': BundleInfo(monthly: salaamSMSBundles['monthly']!, weekly: salaamSMSBundles['weekly']!, nightly: salaamSMSBundles['nightly']!, daily: salaamSMSBundles['daily']!)},
    ],
  };

Map<String, List <Map<String, String>>> salaamVoiceBundles = {
  'monthly': [
    {'title': '1500 Minutes Package', 'description': 'Dear Customer! with this Package You can get 1500 Minutes of Call 30 days in exchange for 299 AFs. To Activate Send (A 1500) & to Deactivate Send (D 1500) to (740).', 'activation': 'A 1500', 'deactivation': 'D 1500','number': '740' },
    {'title': '500 Minutes Package', 'description': 'Dear Customer! with this Package You can get 1500 Minutes of Call 30 days in exchange for 299 AFs. To Activate Send (A 90) & to Deactivate Send (D 90) to (740).', 'activation': 'A 90', 'deactivation': 'D 90','number': '740' },
    {'title': '70 Minutes Package', 'description': 'Dear Customer! with this Package You can get 1500 Minutes of Call 30 days in exchange for 299 AFs. To Activate Send (A 90) & to Deactivate Send (D 90) to (740).', 'activation': 'A 90', 'deactivation': 'D 90', 'number': '740'},
    {'title': 'Unlimited Minutes Package', 'description': 'Dear Customer! with this Package You can get 1500 Minutes of Call 30 days in exchange for 299 AFs. To Activate Send (A UM) & to Deactivate Send (D UM) to (740).', 'activation': 'A UM', 'deactivation': 'D UM', 'number': '740'},
  ],
  'weekly': [
    {'title': '500 Minutes Package', 'description': 'Dear Customer! with this Package You can get 500 Minutes of Call 7 days in exchange for 89 AFs. To Activate Send (A 89) & to Deactivate Send (D 89) to (740).', 'activation': 'A 89', 'deactivation': 'D 89', 'number': '740'},
    {'title': '30 Minutes Package', 'description': 'Dear Customer! with this Package You can get 30 Off_net Minutes of Call 7 days in exchange for 40 AFs. To Activate Send (A OW) & to Deactivate Send (D OW) to (740).', 'activation': 'A OW', 'deactivation': 'D OW', 'number': '740'},
  ],
  'nightly': [],
  'daily': [
    {'title': '300 Minutes Package', 'description': 'Dear Customer! with this Package You can get 300 Minutes of Call 1 day in exchange for 45 AFs. To Activate Send (A 50) & to Deactivate Send (D 50) to (740).', 'activation': 'A 50', 'deactivation': 'D 50', 'number': '740'},
    {'title': '200 Minutes Package', 'description': 'Dear Customer! with this Package You can get 200 Minutes of Call 1 day in exchange for 30 AFs. To Activate Send (A 30) & to Deactivate Send (D 30) to (740).', 'activation': 'A 30', 'deactivation': 'D 30', 'number': '740'},
    {'title': '60 Minutes Package', 'description': 'Dear Customer! with this Package You can get 60 Off-Net Minutes of Call 1 day in exchange for 20 AFs. To Activate Send (A 20) & to Deactivate Send (D 20) to (740).', 'activation': 'A 20', 'deactivation': 'D 20', 'number': '740'},
    {'title': '15 Minutes Package', 'description': 'Dear Customer! with this Package You can get 15 Off-Net Minutes of Call 1 day in exchange for 25 AFs. To Activate Send (A OD) & to Deactivate Send (D OD) to (740).', 'activation': 'A OD', 'deactivation': 'D OD', 'number': '740'},
    {'title': 'Unlimited Minutes Package', 'description': 'Dear Customer! with this Package You can get Unlimited Minutes of Call 1 day in exchange for 10 AFs. To Activate Send (A UD) & to Deactivate Send (D UD) to (740).', 'activation': 'A UD', 'deactivation': 'D UD', 'number': '740'},
  ],
};

Map<String, List <Map<String, String>>> salaamInternetBundles = {
  'monthly': [
    {'title': '1GB Internet Package', 'description': 'Dear Customer! with this Package You can get 1GB for Internet 30 days in exchange for 92 AFs. To Activate Send (A 1GB) & to Deactivate Send (D 1GB) to (740).', 'activation': 'A 1GB', 'deactivation': 'D 1GB', 'number' : '740'},
    {'title': '2GB Internet Package', 'description': 'Dear Customer! with this Package You can get 2GB for Internet 30 days in exchange for 140 AFs. To Activate Send (A 2GB) & to Deactivate Send (D 2GB) to (740).', 'activation': 'A 2GB', 'deactivation': 'D 2GB', 'number': '740' },
    {'title': '3GB Internet Package', 'description': 'Dear Customer! with this Package You can get 3GB for Internet 30 days in exchange for 184 AFs. To Activate Send (A 3GB) & to Deactivate Send (D 3GB) to (740).', 'activation': 'A 3GB', 'deactivation': 'D 3GB', 'number': '740' },
    {'title': '5GB Internet Package', 'description': 'Dear Customer! with this Package You can get 5GB for Internet 30 days in exchange for 276 AFs. To Activate Send (A 5GB) & to Deactivate Send (D 5GB) to (740).', 'activation': 'A 5GB', 'deactivation': 'D 5GB', 'number': '740' },
    {'title': '10GB Internet Package', 'description': 'Dear Customer! with this Package You can get 10GB for Internet 30 days in exchange for 415 AFs. To Activate Send (A 10GB) & to Deactivate Send (D 10GB) to (740).', 'activation': 'A 10GB', 'deactivation': 'D 10GB', 'number': '740' },
    {'title': '30GB Internet Package', 'description': 'Dear Customer! with this Package You can get 30GB for Internet 30 days in exchange for 1200 AFs. To Activate Send (A 30GB) & to Deactivate Send (D 30GB) to (740).', 'activation': 'A 30GB', 'deactivation': 'D 30GB', 'number': '740' },
  ],
  'weekly': [
    {'title': '250MB Weekly Package', 'description': 'Dear Customer! with this Package You can get 250MB for Internet 14 days in exchange for 28 AFs. To Activate Send (A 250MB) & to Deactivate Send (D 250MB) to (740).', 'activation': 'A 250MB', 'deactivation': 'D 250MB', 'number': '740'},
  ],
  'nightly': [
    {'title': '1.5GB Internet Package', 'description': 'Dear Customer! with this Package You can get 1.5GB for Internet 7 days in exchange for 50 AFs. To Activate Send (A SML) & to Deactivate Send (D SML) to (740).', 'activation': 'A SML', 'deactivation': 'D SML', 'number': '740'},
    {'title': '3GB Internet Package', 'description': 'Dear Customer! with this Package You can get 3GB for Internet 30 days in exchange for 90 AFs. To Activate Send (A MDM) & to Deactivate Send (D MDM) to (740).', 'activation': 'A MDM', 'deactivation': 'D MDM', 'number': '740'},
    {'title': '7GB Internet Package', 'description': 'Dear Customer! with this Package You can get 7GB for Internet 30 days in exchange for 200 AFs. To Activate Send (A MDM) & to Deactivate Send (D LRG) to (740).', 'activation': 'A LRG', 'deactivation': 'D LRG', 'number': '740'},
    {'title': '13GB Internet Package', 'description': 'Dear Customer! with this Package You can get 13GB for Internet 30 days in exchange for 350 AFs. To Activate Send (A XTR) & to Deactivate Send (D XTR) to (740).', 'activation': 'A XTR', 'deactivation': 'D XTR', 'number': '740'},
  ],
  'daily': [
    {'title': '1GB Daily Package', 'description': 'Dear Customer! with this Package You can get 1GB for Internet 1 day in exchange for 49 AFs. To Activate Send (A 49) & to Deactivate Send (D 49) to (740).', 'activation': 'A 49', 'deactivate': 'D 49','number': '740' },
    {'title': '100MB Daily Package', 'description': 'Dear Customer! with this Package You can get 100MB for Internet 1 day in exchange for 10 AFs. To Activate Send (A 100) & to Deactivate Send (D 100) to (740).', 'activation': 'A 100', 'deactivation': 'D 100','number': '740' },
  ],
};

Map<String, List <Map<String, String>>> salaamSMSBundles = {
  'monthly': [
    {'title': 'Infinite SMS Package', 'description': 'Dear Customer! with this Package You can get Infinite  SMS for 30 days in exchange for 50 AFs. To Activate Send (A UMS) & to Deactivate Send (D UMS) to (740).', 'activation': 'A UMS', 'deactivation': 'D UMS', 'number': '740'},
  ],
  'weekly': [],
  'nightly': [],
  'daily': [],
};

Map<String, List <Map<String, String>>> awccVoiceBundles = {
  'monthly': [
    {'title': '6600 Minutes Package', 'description': 'Dear Customer! with this Package You can get 6600 of Voice Minutes for 30 days in exchange for 499 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*233*2*1#', 'deactivation': '*233*2*2#', 'number': '1'},
    {'title': '2000 Minutes Package', 'description': 'Dear Customer! with this Package You can get 2000 of Voice Minutes for 30 days in exchange for 300 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*233*4*1#', 'deactivation': '*233*4*2#', 'number': '1'},
    {'title': '1500 Minutes Package', 'description': 'Dear Customer! with this Package You can get 1500 of Voice Minutes for 30 days in exchange for 200 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*233*12*1#', 'deactivation': '*233*12*2#', 'number': '1'},
    {'title': '1000 Minutes Package', 'description': 'Dear Customer! with this Package You can get 1000 of Voice Minutes for 30 days in exchange for 180 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*233*9*1#', 'deactivation': '*233*9*2#', 'number': '1'},
    {'title': '650 Minutes Package', 'description': 'Dear Customer! with this Package You can get 900 of Voice Minutes On-Net for 30 days in exchange for 650 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*233*2*1#', 'deactivation': '233*2*2#', 'number': '1'},
    {'title': '450 Minutes Package', 'description': 'Dear Customer! with this Package You can get 250 of Voice Minutes Off-Net for 30 days in exchange for 450 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*233*2*1#', 'deactivation': '233*2*2#', 'number': '1'},
    {'title': '83 Minutes Package', 'description': 'Dear Customer! with this Package You can get 83 of Voice Minutes On-Net for 30 days in exchange for 150 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*233*2*1#', 'deactivation': '233*2*2#', 'number': '1'},
  ],
  'weekly': [
    {'title': '650 Minutes Package', 'description': 'Dear Customer! with this Package You can get 650 of Voice Minutes for 2 weeks in exchange for 135 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*233*7*1#', 'deactivation': '*233*7*2#','number': '1' },
    {'title': '550 Minutes Package', 'description': 'Dear Customer! with this Package You can get 550 of Voice Minutes for 1 weeks in exchange for 90 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*233*8*1#', 'deactivation': '*555*7*2#', 'number': '1'},
    {'title': '200 Minutes Package', 'description': 'Dear Customer! with this Package You can get 200 of Voice Minutes for 1 weeks in exchange for 46 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*555*7*1#', 'deactivation': '*233*8*2#', 'number': '1'},
  ],
  'nightly': [
    {'title': '350 Minutes Package', 'description': 'Dear Customer! with this Package You can get 350 of Voice Minutes for 1 Night in exchange for 10 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*212*1*1#', 'deactivation': '*212*1*4#', 'number': '1'},
    {'title': '800 Minutes Package', 'description': 'Dear Customer! with this Package You can get 800 of Voice Minutes for 7 Night in exchange for 30 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*212*30*1#', 'deactivation': '*212*30*4#', 'number': '1'},
    {'title': '4000 Minutes Package', 'description': 'Dear Customer! with this Package You can get 4000 of Voice Minutes for 30 Nights in exchange for 150 AFs. To Activate Dial (*233*2*1#) & to Deactivate Dial (*233*2*2#).', 'activation': '*212*150*1#', 'deactivation': '*212*150*4#', 'number': '1'},
  ],
  'daily': [
    {'title': '125 Minutes Package', 'description': 'Dear Customer! with this Package You can get 125 of Voice Minutes for 1 Night in exchange for 25 AFs. To Activate Dial (*233*1*1#) & to Deactivate Dial (*233*1*2#).', 'activation': '*233*1*1#', 'deactivation': '*233*1*2#', 'number': '1'},
    {'title': '60 Minutes Package', 'description': 'Dear Customer! with this Package You can get 60 of Voice Minutes for 1 Hour in exchange for 10 AFs. To Activate Dial (*233*10*1#) & to Deactivate Dial (*233*10*2#).', 'activation': '*233*10*1#', 'deactivation': '*233*10*2#', 'number': '1'},
    {'title': '50 Minutes Package', 'description': 'Dear Customer! with this Package You can get 50 of Voice Minutes for 1 Day in exchange for 15 AFs. To Activate Dial (*233*15*1#) & to Deactivate Dial *233*15*2#).', 'activation': '*233*15*1#', 'deactivation': '*233*15*2#', 'number': '1'},
    {'title': '15 Minutes Package', 'description': 'Dear Customer! with this Package You can get 15 of Voice Minutes for 1 Night in exchange for 10 AFs. To Activate Dial (*233*3*1#) & to Deactivate Dial (*233*3*2#).', 'activation': '*233*3*1#', 'deactivation': '*233*3*2#', 'number': '1'},
  ],
};

Map<String, List <Map<String, String>>> awccInternetBundles = {
  'monthly': [
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
  ],
  'weekly': [
    {'title': 'a', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'c', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
  ],
  'nightly': [
    {'title': 'a', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'c', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
  ],
  'daily': [
    {'title': 'a', 'description': 'abc', 'activation': '255', 'deactivation': '233', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
    {'title': 'c', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '1'},
  ],
};

Map<String, List <Map<String, String>>> awccSMSBundles = {
  'monthly': [{'title': '2000 SMS Package', 'description': 'Dear Customer! with this Package You can get 2000 of SMS for 30 Days in exchange for 50 AFs. To Activate Dial (*369*1#) & to Deactivate Dial (*369*2#).', 'activation': '*369*1#', 'deactivation': '*369*2#', 'number': '1'},],
  'weekly': [{'title': '2000 SMS Package', 'description': 'Dear Customer! with this Package You can get 2000 of SMS for 7 Days in exchange for 20 AFs. To Activate Dial (*369*1#) & to Deactivate Dial (*369*2#).', 'activation': '*368*1#', 'deactivation': '*368*2#', 'number': '1'},],
  'nightly': [],
  'daily': [{'title': '500 SMS Package', 'description': 'abc', 'activation': '*367*1#', 'deactivation': '*367*2#','number': '1'}],
};

Map<String, List <Map<String, String>>> etisalatVoiceBundles = {
  'monthly': [
    {'title': 'aaaaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'aaaaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'aaaaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'aaaaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
  ],
  'weekly': [
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '55'},
  ],
  'nightly': [],
  'daily': [
    {'title': 'a', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'c', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'c', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
  ],
};

Map<String, List <Map<String, String>>> etisalatInternetBundles = {
  'monthly': [
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
   ],
  'weekly': [
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
  ],
  'nightly': [
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
  ],
  'daily': [
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
  ],
};

Map<String, List <Map<String, String>>> etisalatSMSBundles = {
  'monthly': [{'title': 'ccccc', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},],
  'weekly': [{'title': 'a', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},],
  'nightly': [],
  'daily': [{'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},],
};

Map<String, List <Map<String, String>>> mtnVoiceBundles = {
  'monthly': [
    {'title': 'aaaaa', 'description': 'abc', 'activation': '5', 'deactivation': 'U', 'number': '247'},
    {'title': 'aaaaa', 'description': 'abc', 'activation': '8', 'deactivation': 'U', 'number': '247'},
  ],
  'weekly': [
    {'title': 'aaaaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
  ],
  'nightly': [
    {'title': 'aaaaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'aaaaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
  ],
  'daily': [
    {'title': 'aaaaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
    {'title': 'aaaaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},
  ],
};

Map<String, List <Map<String, String>>> mtnInternetBundles = {
  'monthly': [
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
  ],
  'weekly': [
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
  ],
  'nightly': [
    {'title': 'bbbbb', 'description': 'abc', 'activation': '*344*41#', 'deactivation': '*344*8#', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': '*344*42#', 'deactivation': '*344*8#', 'number': '555'},
  ],
  'daily': [
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
    {'title': 'bbbbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': '555'},
  ],
};

Map<String, List <Map<String, String>>> mtnSMSBundles = {
  'monthly': [{'title': 'ccccc', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':'676'},],
  'weekly': [{'title': 'a', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':'676'},],
  'nightly': [],
  'daily': [{'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':'676'},],
};

Map<String, List <Map<String, String>>> roshanVoiceBundles = {
  'monthly': [
    {'title': 'aaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'aaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'aaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'aaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'aaa', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
  ],
  'weekly': [
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
  ],
  'nightly': [
    {'title': 'a', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},

  ],
  'daily': [
    {'title': 'a', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
  ],
};

Map<String, List <Map<String, String>>> roshanInternetBundles = {
  'monthly': [
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    ],
  'weekly': [
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
  ],
  'nightly': [
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
  ],
  'daily': [
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
    {'title': 'bbb', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number':''},
  ],
};

Map<String, List <Map<String, String>>> roshanSMSBundles = {
  'monthly': [{'title': 'ccc', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},],
  'weekly': [{'title': 'a', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},],
  'nightly': [],
  'daily': [{'title': 'b', 'description': 'abc', 'activation': 'a', 'deactivation': 'b', 'number': ''},],
};

