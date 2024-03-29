import 'package:collegetemplate/paper_view.dart';
import 'package:collegetemplate/pdf_list.dart';
import 'package:collegetemplate/test_ads.dart';
import 'package:collegetemplate/webv.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {

  WidgetsFlutterBinding?.ensureInitialized();
  MobileAds.instance.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PapersTemplate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PapersTemplate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //bannerAd
  late BannerAd _bannerAd;
  late bool _isAdLoaded = false;
  final AdSize adSize = const AdSize(width: 300, height: 50);

  InterstitialAd? _interstitialAd;
  RewardedInterstitialAd? _rewardedInterstitialAd;

  @override
  void initState() {
    super.initState();
    //ads initialization
    _myBanner();
    _createInterstitialAd();
    _createRewardedInterstitialAd();
  }

  //banner_ad
  _myBanner() {
    _bannerAd = BannerAd(
      adUnitId: bannerTest,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {}),
    );
    _bannerAd.load();
  }

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => debugPrint('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
  );

  /////interstitial_ad
  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialVideoTest, //interstitialTest,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }

    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd?.show();
    _interstitialAd = (null) as InterstitialAd;
  }

  ///REWARDED AD
  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
      adUnitId: rewardedInterstitialTest,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          debugPrint('$ad loaded.');
          _rewardedInterstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedInterstitialAd failed to load: $error');
          _rewardedInterstitialAd = null;
          _createRewardedInterstitialAd();
        },
      ),
    );
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      debugPrint(
          'Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          debugPrint('$ad onAdShowedFullScreenContent.'),//TODO: REMOVE
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');//TODO: REMOVE
        ad.dispose();
        _createRewardedInterstitialAd();
      },

      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedInterstitialAd();
      },

    );

    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        debugPrint(
            '$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      },
    );
    _rewardedInterstitialAd = null;
  }


/////ads Dispose

  @override
  void dispose() {
    //TODO: REMOVE
    super.dispose();
    _myBanner()?.dispose();
    _interstitialAd?.dispose();
    _rewardedInterstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: pdfs.length,
        itemBuilder: (BuildContext context, int index) {

          ///////////////Concatenate Heading String Name//////////////////////
          String str = pdfs[index];
          // const start = "assets/pdfs/";
          const start = "assets/";
          const end = ".pdf";

          final startIndex = str.indexOf(start);
          final endIndex = str.indexOf(end, startIndex + start.length);
          String paperString =
              str.substring(startIndex + start.length, endIndex);
          ///////////////////////////////////////////////////////////////////
          
          return InkWell(
            // highlightColor: Colors.deepOrange,
            // splashColor: Colors.deepPurpleAccent,

            child: PdfsButton(
              paper: paperString,
            ),
            onTap: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => PaperViewer(
                    pdf: pdfs[index],
                    paperName: paperString,
                  ),
                ),
              );
              ///////////////INTERSTITIAL ADS/////////////
              _interstitialAd?.show();
              /////////////////////////////////////////////
              // await RewardedVideoAd.instance.show();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Tired()),
          );
          // _showRewardedInterstitialAd();//TODO: REMOVE
          _showInterstitialAd();
        },
        tooltip: 'Search',
        child: const Icon(Icons.web_stories),
      ),
      bottomNavigationBar: _isAdLoaded
          ? SizedBox(
              height: 50,
              width: 300,
              child: AdWidget(ad: _bannerAd),
            )
          : const SizedBox(),
    );
  }
}
