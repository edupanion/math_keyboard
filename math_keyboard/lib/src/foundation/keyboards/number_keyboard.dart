part of '../keyboard_button.dart';

/// Icon for the number keyboard.
final String numberKeyboardIcon = 'packages/math_keyboard/lib/assets/number.svg';

/// Keyboard for number input.
final numberKeyboard = [
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    _decimalButton,
    const BasicKeyboardButtonConfig(
      label: r'\Box^2',
      value: '^2',
      args: [TeXArg.braces],
      asTex: true,
    ),
  ],
  [
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    const BasicKeyboardButtonConfig(
      label: r'\frac{\Box}{\Box}',
      value: r'\frac',
      args: [TeXArg.braces, TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box^{\Box}',
      value: '^',
      args: [TeXArg.braces],
      asTex: true,
    ),
  ],
  [
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    _digitButtons[0],
    const BasicKeyboardButtonConfig(
      label: r'\sqrt{\,}',
      value: r'\sqrt',
      args: [TeXArg.braces],
      asTex: true,
    ),
  ],
];
