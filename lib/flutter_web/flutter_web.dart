import 'package:flutter/material.dart';

class FlutterWeb extends StatelessWidget {
  const FlutterWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SignUpScreen(),
        '/more': (context) => const MoreScreen()
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: SignUpForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _formProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
        onChanged: _updateFormProgress,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedProgressIndicator(value: _formProgress),
            Text(
              'Sign up',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: _firstNameTextController,
                decoration: const InputDecoration(hintText: 'First name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: _lastNameTextController,
                decoration: const InputDecoration(hintText: 'Last name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: _usernameTextController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
            ),
            TextButton(
              onPressed: _formProgress == 1 ? _goToNextScreen : null,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.blue;
                }),
              ),
              child: const Text('Sign Up'),
            )
          ],
        ));
  }

  void _goToNextScreen() {
    Navigator.of(context).pushNamed('/more');
  }

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController
    ];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }
}

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  void _showWelcomeScreen() {
    Navigator.of(context).pushNamed('/welcome');
  }

  int _currentStep = 0;

  List<Step> stepList() => [
        Step(
            title: Text('Account'),
            isActive: _currentStep >= 0,
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            content: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                ),
                SizedBox(height: 8),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                )
              ],
            )),
        Step(
            title: Text('Address'),
            isActive: _currentStep >= 1,
            state: _currentStep <= 1 ? StepState.editing : StepState.complete,
            content: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                ),
              ],
            )),
        Step(
          title: Text('Confirm'),
          isActive: _currentStep >= 2,
          state: _currentStep <= 2 ? StepState.editing : StepState.complete,
          content: Center(
            child: Text('Confirm'),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: Stepper(
        steps: stepList(),
        type: StepperType.horizontal,
        elevation: 0,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < (stepList().length - 1)) {
            setState(() {
              _currentStep++;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatefulWidget {
  const AnimatedProgressIndicator({super.key, required this.value});

  final double value;

  @override
  State<AnimatedProgressIndicator> createState() =>
      _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    final colorTween = TweenSequence([
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.red, end: Colors.orange), weight: 1),
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
          weight: 1),
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.yellow, end: Colors.green),
          weight: 1),
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withOpacity(0.4),
      ),
    );
  }
}
