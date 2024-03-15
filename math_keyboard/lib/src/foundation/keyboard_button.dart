import 'package:flutter/widgets.dart';
import 'package:math_keyboard/src/foundation/node.dart';

part './keyboards/greek_letters_keyboard.dart';
part './keyboards/upper_case_text_keyboard.dart';
part './keyboards/lower_case_text_keyboard.dart';
part './keyboards/math_function_keyboard.dart';
part './keyboards/number_keyboard.dart';
part './keyboards/symbol_keyboard.dart';

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
    this.suffixArgs,
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
  final List<TeXArg>? suffixArgs;

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

/// Configuration for a page in the keyboard.
class KeyboardPageConfig {
  /// Constructs a [KeyboardPageConfig].
  KeyboardPageConfig({
    required this.keyboard,
    required this.icon,
  });

  /// The icon for the page.
  final String icon;

  /// The keyboard for the page.
  final List<List<KeyboardButtonConfig>> keyboard;

  /// The key for the page.
  final GlobalKey key = GlobalKey();
}

/// Keyboard showing extended functionality.
final keyboardMap = [
  KeyboardPageConfig(keyboard: numberKeyboard, icon: numberKeyboardIcon),
  KeyboardPageConfig(keyboard: symbolKeyboard, icon: symbolKeyboardIcon),
  KeyboardPageConfig(keyboard: mathFunctionKeyboard, icon: mathFunctionKeyboardIcon),
  KeyboardPageConfig(keyboard: greekKeyboard, icon: greekKeyboardIcon),
  KeyboardPageConfig(keyboard: lowerCaseTextKeyboard, icon: lowerCaseTextKeyboardIcon),
  KeyboardPageConfig(keyboard: upperCaseTextKeyboard, icon: upperCaseTextKeyboardIcon),
];
//   0: KeyboardPageConfig(
//     keyboard: numberKeyboard,
//     icon: numberKeyboardIcon,
//   ),
//   1: KeyboardPageConfig(
//     keyboard: symbolKeyboard,
//     icon: symbolKeyboardIcon,
//   ),
//   2: KeyboardPageConfig(
//     keyboard: mathFunctionKeyboard,
//     icon: mathFunctionKeyboardIcon,
//   ),
//   3: KeyboardPageConfig(
//     keyboard: upperCaseTextKeyboard,
//     icon: upperCaseTextKeyboardIcon,
//   ),
//   4: KeyboardPageConfig(
//     keyboard: lowerCaseTextKeyboard,
//     icon: lowerCaseTextKeyboardIcon,
//   ),
//   5: KeyboardPageConfig(
//     keyboard: functionKeyboard,
//     icon: functionKeyboardIcon,
//   ),
// };
