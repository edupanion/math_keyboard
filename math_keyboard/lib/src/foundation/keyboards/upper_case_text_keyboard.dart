part of '../keyboard_button.dart';

/// Icon for the upper case text keyboard.
final String upperCaseTextKeyboardIcon = 'packages/math_keyboard/lib/assets/upper_alphabet.svg';

final _upperCaseTextKeyboard = [
  ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'],
  ['J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R'],
  ['S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'],
];

/// Text keyboard for math expression input.
final upperCaseTextKeyboard = [
  for (final row in _upperCaseTextKeyboard)
    [
      for (final key in row)
        BasicKeyboardButtonConfig(
          label: key,
          value: '{$key}',
          asTex: true,
          highlighted: true,
          keyboardCharacters: [key],
        ),
    ],
];
