
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SecurityAnimation extends StatefulWidget {
  @override
  State<SecurityAnimation> createState() => _SecurityAnimationState();
}

class _SecurityAnimationState extends State<SecurityAnimation>
    with TickerProviderStateMixin {

  bool nonSecurity = false;
  bool halfSecurity = true;
  bool fullSecurity = false;

  double _width = 0.001;
  bool _visible = false;



  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  int segmentedControlGroupValue = 0;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAnim();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);
    animation.forward();
  }

  void showAnim() async {
    await Future.delayed(const Duration(milliseconds: 500))
        .then((value) => setState(() {
      _width = MediaQuery.of(context).size.width * 0.8;
    }));
  }
  @override
  void dispose() {
    animation.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appbar =AppBar(
      title: Row(
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: SvgPicture.asset("assets/images/insta.svg", color: Colors.grey),
          ),
          const SizedBox(
            width:10,
          ),
          const Text("basic_flutter",style: TextStyle(color: Colors.grey),),
        ],
      ),
      centerTitle: true,
    );

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - appbar.preferredSize.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appbar,
      body:  Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
                colors: [
                  Color(0xff181818),
                  Color(0xff303030),
                ])
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Neumorphic(
                  style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(screenWidth * 0.04)),
                      shape: NeumorphicShape.flat,
                      depth: -5,
                      shadowDarkColorEmboss: Colors.black,
                      shadowLightColorEmboss: Colors.grey

                  ),
                  child: AnimatedContainer(
                    width: _width,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                    ),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastOutSlowIn,
                    child: Padding(
                      padding:  EdgeInsets.only(left:screenWidth*0.05,right: screenWidth*0.05 ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        runAlignment: WrapAlignment.center ,
                        children: [
                          SvgPicture.asset(
                            "assets/images/non_security.svg",
                            color: nonSecurity
                                ? Colors.transparent
                                : Colors.white70,
                          ),
                          SvgPicture.asset(
                            "assets/images/half_security.svg",
                            color: halfSecurity
                                ? Colors.transparent
                                : Colors.white70,
                          ),
                          SvgPicture.asset(
                            "assets/images/full_security.svg",
                            color: fullSecurity
                                ? Colors.transparent
                                : Colors.white70,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {

                    if (nonSecurity) {

                      nonSecurity = false;
                      halfSecurity = true;
                      fullSecurity = false;

                    } else if (halfSecurity) {
                      nonSecurity = false;
                      halfSecurity = false;
                      fullSecurity = true;

                    } else if (fullSecurity) {
                      nonSecurity = true;
                      halfSecurity = false;
                      fullSecurity = false;

                    }
                    animation = AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 1000),
                    );
                    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);
                    animation.forward();
                    setState(() {
                      _visible = !_visible;
                    });

                  },
                  child: AnimatedContainer(
                    width: screenWidth * 0.87,
                    height: screenHeight * 0.12,
                    alignment: fullSecurity ? Alignment.centerRight : halfSecurity ? Alignment.center : Alignment.centerLeft,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        boxShape: const NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.flat,
                        depth: -2,
                        lightSource: LightSource.bottomRight,
                        shadowLightColor: Colors.black,
                        shadowDarkColor: Colors.black,
                        shadowDarkColorEmboss: Colors.black,
                        shadowLightColorEmboss: Colors.grey[700],
                        color: const Color(0xff212121),
                      ),
                      child: FadeTransition(
                        // If the widget is visible, animate to 0.0 (invisible).
                        // If the widget is hidden, animate to 1.0 (fully visible).
                        opacity: _fadeInFadeOut,
                        // duration: const Duration(milliseconds: 500),
                        // The green box must be a child of the AnimatedOpacity widget.
                        child: Container(
                          width: screenWidth * 0.25,
                          height: screenWidth * 0.25,
                          padding: EdgeInsets.all(screenWidth * 0.05),
                          child: nonSecurity
                              ? SvgPicture.asset(
                              "assets/images/non_security.svg")
                              : halfSecurity
                              ? SvgPicture.asset(
                              "assets/images/half_security.svg")
                              : SvgPicture.asset(
                              "assets/images/full_security.svg"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
