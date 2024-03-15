part of '../keyboard_button.dart';

/// Icon for the lower case text keyboard.
final String lowerCaseTextKeyboardIcon = 'packages/math_keyboard/lib/assets/lower_alphabet.svg';

final _lowerCaseTextKeyboard = [
  ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'],
  ['j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r'],
  ['s', 't', 'u', 'v', 'w', 'x', 'y', 'z'],
];

/// Text keyboard for math expression input.
final lowerCaseTextKeyboard = [
  for (final row in _lowerCaseTextKeyboard)
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
