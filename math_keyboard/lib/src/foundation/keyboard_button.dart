import 'package:flutter/services.dart';
import 'package:math_keyboard/src/foundation/node.dart';

/// Class representing a button configuration.
abstract class KeyboardButtonConfig {
  /// Constructs a [KeyboardButtonConfig].
  const KeyboardButtonConfig({
    this.flex,
    this.keyboardCharacters = const [],
  });

  /// Optional flex.
  final int? flex;

  /// The list of [RawKeyEvent.character] that should trigger this keyboard
  /// button on a physical keyboard.
  ///
  /// Note that the case of the characters is ignored.
  ///
  /// Special keyboard keys like backspace and arrow keys are specially handled
  /// and do *not* require this to be set.
  ///
  /// Must not be `null` but can be empty.
  final List<String> keyboardCharacters;
}

/// Class representing a button configuration for a [FunctionButton].
class BasicKeyboardButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [KeyboardButtonConfig].
  const BasicKeyboardButtonConfig({
    required this.label,
    required this.value,
    this.args,
    this.asTex = false,
    this.highlighted = false,
    List<String> keyboardCharacters = const [],
    int? flex,
  }) : super(
          flex: flex,
          keyboardCharacters: keyboardCharacters,
        );

  /// The label of the button.
  final String label;

  /// The value in tex.
  final String value;

  /// List defining the arguments for the function behind this button.
  final List<TeXArg>? args;

  /// Whether to display the label as TeX or as plain text.
  final bool asTex;

  /// The highlight level of this button.
  final bool highlighted;
}

/// Class representing a button configuration of the Delete Button.
class DeleteButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  DeleteButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Previous Button.
class PreviousButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  PreviousButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Next Button.
class NextButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  NextButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Submit Button.
class SubmitButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [SubmitButtonConfig].
  SubmitButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Page Toggle Button.
class PageButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [PageButtonConfig].
  const PageButtonConfig({int? flex}) : super(flex: flex);
}

/// List of keyboard button configs for the digits from 0-9.
///
/// List access from 0 to 9 will return the appropriate digit button.
final _digitButtons = [
  for (var i = 0; i < 10; i++)
    BasicKeyboardButtonConfig(
      label: '$i',
      value: '$i',
      keyboardCharacters: ['$i'],
    ),
];

const _decimalButton = BasicKeyboardButtonConfig(
  label: '.',
  value: '.',
  keyboardCharacters: ['.', ','],
  highlighted: true,
);

const _subtractButton = BasicKeyboardButtonConfig(
  label: '−',
  value: '-',
  keyboardCharacters: ['-'],
  highlighted: true,
);

/// Keyboard showing extended functionality.
final functionKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: r'\pi',
      value: r'\pi',
      asTex: true,
    ),
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
    const BasicKeyboardButtonConfig(
      label: r'\theta',
      value: r'\theta',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\infty',
      value: r'\infty',
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\vert',
      value: r'\vert',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\frac{\Box}{\Box}',
      value: r'\frac',
      args: [TeXArg.braces, TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\neq',
      value: r'\neq',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'>',
      value: r'>',
    ),
    const BasicKeyboardButtonConfig(
      label: r'<',
      value: r'<',
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sqrt{\Box}',
      value: r'\sqrt',
      args: [TeXArg.braces],
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\Box^2',
      value: '^2',
      args: [TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box^{\Box}',
      value: '^',
      args: [TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'=',
      value: r'=',
      asTex: true,
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
    DeleteButtonConfig(),
  ],
  [
    const PageButtonConfig(flex: 3),
    PreviousButtonConfig(),
    NextButtonConfig(),
    SubmitButtonConfig(),
  ],
];

/// Standard keyboard for math expression input.
final standardKeyboard = [
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    const BasicKeyboardButtonConfig(
      label: '.',
      value: r'.',
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '+',
      value: '+',
      keyboardCharacters: ['+'],
      highlighted: true,
    ),
    _subtractButton,
  ],
  [
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    const BasicKeyboardButtonConfig(
      label: ',',
      value: r',',
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '×',
      value: r'\times',
      keyboardCharacters: ['*'],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '÷',
      value: r'\frac',
      keyboardCharacters: ['/'],
      args: [TeXArg.braces, TeXArg.braces],
      highlighted: true,
    ),
  ],
  [
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    _digitButtons[0],
    const BasicKeyboardButtonConfig(
      label: r'\pm',
      value: r'\pm',
      asTex: true,
    ),
    DeleteButtonConfig(),
  ],
  [
    const PageButtonConfig(),
    PreviousButtonConfig(),
    NextButtonConfig(),
    SubmitButtonConfig(),
  ],
];

/// Keyboard getting shown for number input only.
final numberKeyboard = [
  [
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    _subtractButton,
  ],
  [
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    _decimalButton,
  ],
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    DeleteButtonConfig(),
  ],
  [
    PreviousButtonConfig(),
    _digitButtons[0],
    NextButtonConfig(),
    SubmitButtonConfig(),
  ],
];

/// Text keyboard for math expression input.
final textKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: r'a',
      value: '{a}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'b',
      value: '{b}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'c',
      value: '{c}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'd',
      value: '{d}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'e',
      value: '{e}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'i',
      value: '{i}',
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'k',
      value: '{k}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'l',
      value: '{l}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'm',
      value: '{m}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'n',
      value: '{n}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'p',
      value: '{p}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'q',
      value: '{q}',
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'r',
      value: '{r}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r's',
      value: '{s}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r't',
      value: '{t}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'u',
      value: '{u}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'v',
      value: '{v}',
      asTex: true,
    ),
    DeleteButtonConfig(),
  ],
  [
    const PageButtonConfig(),
    const BasicKeyboardButtonConfig(
      label: '(',
      value: '(',
      highlighted: true,
      keyboardCharacters: ['('],
    ),
    const BasicKeyboardButtonConfig(
      label: ')',
      value: ')',
      highlighted: true,
      keyboardCharacters: [')'],
    ),
    PreviousButtonConfig(),
    NextButtonConfig(),
    SubmitButtonConfig(),
  ],
];
