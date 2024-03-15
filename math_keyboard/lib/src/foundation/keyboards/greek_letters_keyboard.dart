part of '../keyboard_button.dart';

/// Icon for the function keyboard.
final String greekKeyboardIcon = 'packages/math_keyboard/lib/assets/greek_letters.svg';

/// Keyboard showing extended functionality.
final greekKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: r'\alpha',
      value: r'\alpha',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\beta',
      value: r'\beta',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\gamma',
      value: r'\gamma',
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\theta',
      value: r'\theta',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sigma',
      value: r'\sigma',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\omega',
      value: r'\omega',
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\pi',
      value: r'\pi',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\phi',
      value: r'\phi',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\infty',
      value: r'\infty',
      asTex: true,
    ),
  ],
];
