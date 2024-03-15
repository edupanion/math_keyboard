part of '../keyboard_button.dart';

/// Icon for the standard keyboard.
final mathFunctionKeyboardIcon = 'packages/math_keyboard/lib/assets/math_function.svg';

/// Standard keyboard for math expression input.
final mathFunctionKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: r'\sin',
      value: r'\sin',
      asTex: true,
      args: [TeXArg.parentheses],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\cos',
      value: r'\cos',
      asTex: true,
      args: [TeXArg.parentheses],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\tan',
      value: r'\tan',
      asTex: true,
      args: [TeXArg.parentheses],
      highlighted: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\sec',
      value: r'\sec',
      asTex: true,
      args: [TeXArg.parentheses],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\cosec',
      value: r'\cosec',
      asTex: true,
      args: [TeXArg.parentheses],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\cot',
      value: r'\cot',
      asTex: true,
      args: [TeXArg.parentheses],
      highlighted: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\log_{\Box}',
      value: r'\log_',
      args: [TeXArg.braces, TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\log',
      value: r'\log',
      args: [TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\ln',
      value: r'\ln',
      args: [TeXArg.parentheses],
      asTex: true,
    ),
  ],
];
