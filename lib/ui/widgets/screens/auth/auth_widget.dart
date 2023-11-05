import 'package:flutter/material.dart';
import 'package:hacaton/ui/navigation/main_navigation.dart';
import 'package:hacaton/ui/widgets/entity_models/auth_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

const TextStyle boldTextStyle = TextStyle(
    fontSize: 22,
    letterSpacing: 1,
    fontFamily: 'New_channel_font',
    fontWeight: FontWeight.bold,
    color: Colors.white);
const TextStyle lightTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'New_channel_font',
    color: Colors.white,
    letterSpacing: 1);
TextStyle errorTextStyle = TextStyle(
    fontFamily: 'New_channel_font',
    letterSpacing: 1,
    fontSize: 18,
    color: Colors.deepOrangeAccent.shade700);

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/auth_back.jpg'), fit: BoxFit.cover),
          color: Colors.white),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white54,
              child: const _HeaderWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 2),
          Text(
            'Авторизация',
            style: boldTextStyle,
          ),
          SizedBox(height: 2),
          _ActionMessageWidget(),
          SizedBox(height: 2),
          _FormWidget(),
          SizedBox(height: 2),
          // Text(
          //     "На ваш номер поступит сброс-звонок, последние 4 цифры которого являются кодом.",
          //     style: lightTextStyle),
        ],
      ),
    );
  }
}

class _ActionMessageWidget extends StatelessWidget {
  const _ActionMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool accessible =
        context.select((AuthViewModel model) => model.accessible);
    accessible ? const _CodeField() : const _PhoneNumberField();
    return Text(
      accessible ? "Введите код(последние цифры)" : "Введите номер телефона",
      style: lightTextStyle,
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({super.key});

  void _getCode() {}

  void _resetCode() {}

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _AuthInputField(),
        _ErrorMessageWidget(),
        SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AuthButtonWidget(),
          ],
        ),
      ],
    );
  }
}

class _AuthInputField extends StatelessWidget {
  const _AuthInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final bool accessible =
        context.select((AuthViewModel model) => model.accessible);
    return accessible ? const _CodeField() : const _PhoneNumberField();
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel? model = context.read<AuthViewModel?>();
    if (model == null) return const SizedBox.shrink();
    return SizedBox(
      width: 275,
      child: TextField(
        cursorColor: Colors.white,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 24),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '+7 (000) 000 00-00',
          hintStyle: TextStyle(color: Colors.white, fontSize: 24),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          MaskTextInputFormatter(
              mask: '+# (###) ###-##-##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
        ],
        onChanged: model.changePhone,
      ),
    );
  }
}

class _CodeField extends StatelessWidget {
  const _CodeField({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel? model = context.read<AuthViewModel?>();
    if (model == null) return const SizedBox.shrink();
    return SizedBox(
      width: 275,
      child: TextField(
        cursorColor: Colors.white,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 24),
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '0000',
            hintStyle: TextStyle(color: Colors.white, fontSize: 24)),
        keyboardType: TextInputType.number,
        inputFormatters: [
          MaskTextInputFormatter(
              mask: '####',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
        ],
        onChanged: model.changeCode,
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool accessible =
        context.select((AuthViewModel model) => model.accessible);
    return accessible
        ? const _LogInButtonWidget()
        : const _GetCodeButtonWidget();
  }
}

class _GetCodeButtonWidget extends StatelessWidget {
  const _GetCodeButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthViewModel? model = context.watch<AuthViewModel?>();
    if (model == null) return const SizedBox.shrink();
    final bool active = model.state.canAct;
    final buttonChild = model.state.isLoading
        ? const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(),
          )
        : const Text('Получить код');
    final onPressed = active
        ? () {
            model.getAccessToken();
          }
        : null;
    final color = active ? Colors.deepOrange : Colors.deepOrange.shade200;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(boldTextStyle)),
      child: buttonChild,
    );
  }
}

class _LogInButtonWidget extends StatelessWidget {
  const _LogInButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthViewModel? model = context.watch<AuthViewModel?>();
    if (model == null) return const SizedBox.shrink();
    final bool active = model.state.canAct;
    final buttonChild = model.state.isLoading
        ? const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(),
          )
        : const Text('Войти');
    final onPressed = active
        ? () async {
            if (await model.makeAuthToken()) {
              Navigator.of(context)
                  .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
            }
          }
        : null;
    final color = active ? Colors.deepOrange : Colors.deepOrange.shade200;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(boldTextStyle)),
      child: buttonChild,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String errorMessage =context.select((AuthViewModel model) => model.state.errorMessage);
    if (errorMessage.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        errorMessage,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: errorTextStyle,
      ),
    );
  }
}
