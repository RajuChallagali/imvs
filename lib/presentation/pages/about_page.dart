import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  static const String routeName = "/AboutPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ఉపోద్ఘాతం'),
        backgroundColor: Colors.brown.shade100,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        /*decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/imvsAppLogo.png'), // Optional BG
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),*/
        child: const SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/imvs_Bp2_app.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'మహా ఘన. శ్రీ శ్రీ శ్రీ డా. మోసెస్ డి. ప్రకాశం,',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                Text(
                  'సింహపురి పీఠ కాపరి',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                ),
                ),
                SizedBox(height: 10),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Text(
                  'ప్రియమైన క్రీస్తు సహోదరులారా,\n\n'
                  'మన "ఇదే మన విశ్వాసము" యాప్‌ను చూసి ఎంతో ఆనందం కలుగుతోంది. ఇది మన నెల్లూరు మేత్రాసన ప్రజల కోసం ప్రత్యేకంగా రూపొందించబడిన ఒక పవిత్రమైన, ఆధ్యాత్మికమైన ప్రయత్నం. ఈ యాప్ మన విశ్వాసాన్ని ప్రతి రోజు జీవించేందుకు మార్గదర్శకంగా ఉంటుంది.\n\n'
                  'ఈ యాప్ ద్వారా కథోలికుల ప్రార్థనలు, అనుదిన బైబిల్ పఠనాలు, దివ్యబలిపూజ, బైబిల్ గ్రంథం, నెల్లూరు మేత్రాసన యూట్యూబ్ ఛానెల్ వంటి ఎన్నో ఆత్మీయ విషయాలు అందుబాటులో ఉంటాయి. మన తెలుగు విశ్వాస సంస్కృతిని ప్రతిబింబించే విధంగా, "కీర్తనామృతం" నుండి ఎంపిక చేసిన పాటలు, "మోక్షపు వాకిలి" నుండి తీసుకున్న ప్రార్థనలు ఈ యాప్‌లో చేర్చబడినవి.\n\n'
                  'ప్రతి ఒక్కరి చేతిలో ఉండే మొబైల్ ఫోన్ లో ఈ విధమైన విశ్వాస ఆవాసం ఉండటం ఎంతో ఆశీర్వాదకరం. ఇది ప్రత్యేకంగా మన యువతను ప్రభుతో మరింత దగ్గరగా ఉండేలా సహాయపడుతుంది.\n\n'
                  'ఈ యాప్‌ను అభివృద్ధి చేసిన గురుశ్రీ కలివెల చంద్ర గారికి, అతనికి సహకరించిన వారందరికీ నా హృదయపూర్వక అభినందనలు తెలియజేస్తున్నాను. ప్రతి రోజూ ఈ యాప్ ద్వారా మన ప్రార్థన జీవితం బలపడాలని, ప్రభు అనుగ్రహం మీ అందరిపై ఉండాలని కోరుకుంటున్నాను.\n\n'
                  'ప్రభువులో,\n'
                  '+మహా ఘన. శ్రీ శ్రీ శ్రీ డా. మోసెస్ డి. ప్రకాశం,\n'
                  'సింహపురి పీఠ కాపరి\n',
                  style: TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 30),
            
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/imvs_Bp_app.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'మహా ఘన. శ్రీ శ్రీ శ్రీ డా. పిల్లి అంతోని దాస్,',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                Text(
                  'సింహపురి సహ-వారస పీఠ కాపరి',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                ),
                ),
                SizedBox(height: 10),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Text(
                  'ప్రియమైన సహవిశ్వాసులారా,\n\n'
                  'మన ప్రభువు యేసుక్రీస్తులో మీకు శాంతి, ఆనందం కలుగాలని ప్రార్థిస్తున్నాను. విశ్వాసాన్ని నిత్యం జీవించేందుకు, ప్రార్థనలో గాఢంగా ఉండేందుకు, మరియు దేవునితో సన్నిహితమైన బంధాన్ని కొనసాగించేందుకు మనకు తోడ్పడే ఒక సాంకేతిక సాధనంగా “ఇదే మన విశ్వాసము” అనే యాప్‌ను ప్రారంభించినందుకు నేను ఎంతో ఆనందిస్తున్నాను.\n\n'
                  'ఈ యాప్ ద్వారా ప్రతి రోజు ప్రార్థనలు, బైబిల్ పఠనాలు, దివ్య బలిపూజ, పరిశుద్ధ గ్రంథం మరియు మన ఆధ్యాత్మిక జీవితాన్ని మేల్కొలిపే యూట్యూబ్ ఛానల్ అందుబాటులో ఉంటాయి. మన సంప్రదాయ గీతాలైన “కీర్తనామృతం” మరియు సుగుణ ప్రార్థనలైన “మోక్షపు వాకిలి” వంటి విలువైన ఆధ్యాత్మిక సంపదను ఇందులో చేర్చడం అభినందనీయం.\n\n'
                  'ఈ యాప్ రూపకర్త ఫా. కలివెల చంద్ర గారికి నా ప్రత్యేక అభినందనలు తెలియజేస్తున్నాను. వారి సంకల్పం, శ్రద్ధ, విశ్వాసం ఈ యాప్ రూపంలో ఫలించాయి. మానవాతీతమైన ఈ సాంకేతిక సాధనాన్ని మన పండితులు, యువత, కుటుంబాలు రోజువారీ భక్తి జీవితంలో భాగంగా ఉపయోగించాలనే నా ఆకాంక్ష.\n\n'
                  'మన విశ్వాసాన్ని బలోపేతం చేయడమే కాక, కొత్త తరం యువతకు మన శ్రీ సభ సంపదను అందించాలనే ఈ యాప్ లక్ష్యాన్ని ఆశీర్వదిస్తున్నాను.\n\n'
                  'ప్రతి కుటుంబం లోనూ, ప్రతి హృదయంలోనూ క్రీస్తు వెలుగు వెలుగుగా విరజిమ్మాలని ప్రార్థిస్తూ...\n\n'
                  'ప్రభువులో,\n'
                  '+మహా ఘన. శ్రీ శ్రీ శ్రీ డా. పిల్లి అంతోని దాస్,\n'
                  'సింహపురి సహ-వారస పీఠ కాపరి\n',
                  style: TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 30),

                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/imvs_Fr_app.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'గురుశ్రీ కలివెల చంద్ర,',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                Text(
                  'సింహపురి పీఠం',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                ),
                ),
                SizedBox(height: 10),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Text(
                  'ఒక గురువు హృదయాంతరాల నుంచి\n\n'
                  'ప్రియమైన క్రీస్తు సహోదరీ సహోదరులారా,\n\n'
                  'ప్రభువుకు స్తోత్రము తెలియజేస్తూ, మీ ముందుకు "ఇదే మన విశ్వాసము" అనే ఆధ్యాత్మిక మొబైల్ యాప్‌ను ఎంతో ఆనందంతో పరిచయం చేస్తున్నాను. ఈ యాప్ మన నెల్లూరు మేత్రాసన విశ్వాసుల కోసం ప్రత్యేకంగా రూపొందించబడింది.\n\n'
                  'ఈ యాప్ ద్వారా మనకు ప్రతి రోజు కథోలిక ప్రార్థనలు, అనుదిన బైబిల్ పఠనాలు, దివ్యబలిపూజ (Mass), పరిశుద్ధ గ్రంథము (Bible), నెల్లూరు మేత్రాసన యూట్యూబ్ ఛానల్ లాంటి ఆత్మీయమైన విషయాలు అందుబాటులో ఉంటాయి. ఇందులో “కీర్తనామృతం” నుండి ఎంపికైన భక్తిగీతాలు మరియు “మోక్షపు వాకిలి” నుండి ప్రాచీన ప్రార్థనలు సేకరించబడ్డాయి.\n\n'
                  'ఈ యాప్ ద్వారా మన విశ్వాసాన్ని ప్రతిరోజూ జీవించేందుకు, మానసిక శాంతిని పొందేందుకు, మరియు మన ప్రభువుతో సంబంధాన్ని మరింత బలోపేతం చేసుకోవడానికి సహాయం చేస్తుంది. ఇంట్లోనైనా, ప్రయాణంలోనైనా, ఏ సమయంలోనైనా ఈ యాప్ మిమ్మల్ని ఆధ్యాత్మికంగా సమృద్ధిగా ఉంచుతుంది.\n\n'
                  'ఈ యాప్ కు ప్రోత్సాహం, దీవెనలు అందించిన మా మేత్రానులు మోస్ట్ రెవరెండ్ డాక్టర్ మోసెస్ డి. ప్రకాశం గారికి, మరియు సహ వారస మేత్రానులు మోస్ట్ రెవరెండ్ డాక్టర్ పిల్లి అంతోని దాస్ గారికి నా మనఃపూర్వక కృతజ్ఞతలు తెలియజేస్తున్నాను. మీరు అందరూ ఈ యాప్‌ను ప్రార్థనతో, భక్తితో ఉపయోగించి మీ విశ్వాసాన్ని నిలిపి ఉంచగలరని ఆశిస్తున్నాను.\n\n'
                  'మనమందరం సంతోషంగా, ధైర్యంగా ప్రకటించుకుందాం — “ఇదే మన విశ్వాసము!”\n\n'
                  'ప్రభువులో,\n'
                  'గురుశ్రీ కలివెల చంద్ర,\n'
                  'సింహపురి పీఠం\n',
                  style: TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 30),
                Text(
                  '© 2025 Ide Mana Vishwasam\n\n'
                  'Developed by Challagali Raju\n'
                  'For any queries, please contact: +91 8074039144\n\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
