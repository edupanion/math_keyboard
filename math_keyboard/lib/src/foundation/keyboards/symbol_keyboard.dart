part of '../keyboard_button.dart';

/// Icon for the number keyboard.
final String symbolKeyboardIcon = 'packages/math_keyboard/lib/assets/symbol.svg';

/// Keyboard for number input.
final symbolKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: '+',
      value: '+',
      keyboardCharacters: ['+'],
      highlighted: true,
    ),
    _subtractButton,
    const BasicKeyboardButtonConfig(
      label: '×',
      value: r'\times',
      keyboardCharacters: ['*'],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '÷',
      value: r'\div',
      keyboardCharacters: ['/'],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'=',
      value: r'=',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\pm',
      value: r'\pm',
      asTex: true,
      highlighted: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'(',
      value: r'(',
      asTex: true,
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r')',
      value: r')',
      asTex: true,
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: ',',
      value: ',',
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: ':',
      value: ':',
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '!',
      value: '!',
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\vert \Box \vert',
      value: r'\vert',
      asTex: true,
      highlighted: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'>',
      value: r'\gt',
    ),
    const BasicKeyboardButtonConfig(
      label: r'<',
      value: r'/lt',
    ),
    const BasicKeyboardButtonConfig(
      label: r'\ge',
      value: r'\ge',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\le',
      value: r'\le',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\neq',
      value: r'\neq',
      asTex: true,
    ),
  ],
];
