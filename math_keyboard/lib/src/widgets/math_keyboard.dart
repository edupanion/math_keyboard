import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:math_keyboard/src/foundation/keyboard_button.dart';
import 'package:math_keyboard/src/widgets/decimal_separator.dart';
import 'package:math_keyboard/src/widgets/keyboard_button.dart';
import 'package:math_keyboard/src/widgets/math_field.dart';
import 'package:math_keyboard/src/widgets/view_insets.dart';

/// Enumeration for the types of keyboard that a math keyboard can adopt.
///
/// This way we allow different button configurations. The user may only need to
/// input a number.
enum MathKeyboardType {
  /// Keyboard for entering complete math expressions.
  ///
  /// This shows numbers + operators and a toggle button to switch to another
  /// page with extended functions.
  expression,

  /// Keyboard for number input only.
  numberOnly,
}

/// Widget displaying the math keyboard.
class MathKeyboard extends StatelessWidget {
  /// Constructs a [MathKeyboard].
  const MathKeyboard({
    Key? key,
    required this.controller,
    this.type = MathKeyboardType.expression,
    this.variables = const [],
    this.onSubmit,
    this.insetsState,
    this.slideAnimation,
    this.padding = const EdgeInsets.only(
      bottom: 4,
      left: 4,
      right: 4,
    ),
  }) : super(key: key);

  /// The controller for editing the math field.
  ///
  /// Must not be `null`.
  final MathFieldEditingController controller;

  /// The state for reporting the keyboard insets.
  ///
  /// If `null`, the math keyboard will not report about its bottom inset.
  final MathKeyboardViewInsetsState? insetsState;

  /// Animation that indicates the current slide progress of the keyboard.
  ///
  /// If `null`, the keyboard is always fully slided out.
  final Animation<double>? slideAnimation;

  /// The Variables a user can use.
  final List<String> variables;

  /// The Type of the Keyboard.
  final MathKeyboardType type;

  /// Function that is called when the enter / submit button is tapped.
  ///
  /// Can be `null`.
  final VoidCallback? onSubmit;

  /// Insets of the keyboard.
  ///
  /// Defaults to `const EdgeInsets.only(bottom: 4, left: 4, right: 4),`.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final curvedSlideAnimation = CurvedAnimation(
      parent: slideAnimation ?? AlwaysStoppedAnimation(1),
      curve: Curves.ease,
    );

    final _scrollController = ScrollController();

    final keyboardPages = [...keyboardMap];

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: const Offset(0, 0),
      ).animate(curvedSlideAnimation),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Material(
              type: MaterialType.transparency,
              child: ColoredBox(
                color: Color(0xFFD8DBE3),
                child: SafeArea(
                  top: false,
                  child: _KeyboardBody(
                    insetsState: insetsState,
                    slideAnimation: slideAnimation == null ? null : curvedSlideAnimation,
                    child: Padding(
                      padding: padding,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(),
                          child: Column(
                            children: [
                              _Categories(
                                controller: controller,
                                variables: variables,
                                scrollController: _scrollController,
                                pages: keyboardPages,
                              ),
                              _Buttons(
                                scrollController: _scrollController,
                                controller: controller,
                                pages: keyboardPages,
                                onSubmit: onSubmit,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget that reports about the math keyboard body's bottom inset.
class _KeyboardBody extends StatefulWidget {
  const _KeyboardBody({
    Key? key,
    this.insetsState,
    this.slideAnimation,
    required this.child,
  }) : super(key: key);

  final MathKeyboardViewInsetsState? insetsState;

  /// The animation for sliding the keyboard.
  ///
  /// This is used in the body for reporting fractional sliding progress, i.e.
  /// reporting a smaller size while sliding.
  final Animation<double>? slideAnimation;

  final Widget child;

  @override
  _KeyboardBodyState createState() => _KeyboardBodyState();
}

class _KeyboardBodyState extends State<_KeyboardBody> {
  @override
  void initState() {
    super.initState();

    widget.slideAnimation?.addListener(_handleAnimation);
  }

  @override
  void didUpdateWidget(_KeyboardBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.insetsState != widget.insetsState) {
      _removeInsets(oldWidget.insetsState);
      _reportInsets(widget.insetsState);
    }

    if (oldWidget.slideAnimation != widget.slideAnimation) {
      oldWidget.slideAnimation?.removeListener(_handleAnimation);
      widget.slideAnimation?.addListener(_handleAnimation);
    }
  }

  @override
  void dispose() {
    _removeInsets(widget.insetsState);
    widget.slideAnimation?.removeListener(_handleAnimation);

    super.dispose();
  }

  void _handleAnimation() {
    _reportInsets(widget.insetsState);
  }

  void _removeInsets(MathKeyboardViewInsetsState? insetsState) {
    if (insetsState == null) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.insetsState![ObjectKey(this)] = null;
    });
  }

  void _reportInsets(MathKeyboardViewInsetsState? insetsState) {
    if (insetsState == null) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final renderBox = context.findRenderObject() as RenderBox;
      insetsState[ObjectKey(this)] = renderBox.size.height * (widget.slideAnimation?.value ?? 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    _reportInsets(widget.insetsState);
    return widget.child;
  }
}

/// Widget showing the variables a user can use.
class _Categories extends StatefulWidget {
  /// Constructs a [_Categories] Widget.
  const _Categories({
    Key? key,
    required this.controller,
    required this.variables,
    required this.pages,
    this.scrollController,
  }) : super(key: key);

  /// The editing controller for the math field that the variables are connected
  /// to.
  final MathFieldEditingController controller;

  /// The variables to show.
  final List<String> variables;

  final List<KeyboardPageConfig> pages;

  final ScrollController? scrollController;

  @override
  State<_Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<_Categories> {
  int _selected = 0;
  Completer<void>? _moved;

  @override
  void initState() {
    super.initState();

    widget.scrollController?.addListener(_handleScroll);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_handleScroll);
    super.dispose();
  }

  void _handleScroll() async {
    if (_moved?.isCompleted == false) return;

    for (var i = 0; i < widget.pages.length; i++) {
      final key = widget.pages[i].key;
      final renderBox = key.currentContext?.findRenderObject() as RenderBox;
      final size = renderBox.size;
      final position = renderBox.localToGlobal(Offset.zero);
      final dx = position.dx;
      final dxEnd = dx + size.width;

      if (dx <= 8 && dxEnd >= 0) {
        if (_selected != i) {
          setState(() {
            _selected = i;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      color: Color(0xFFD8DBE3),
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.pages.length; i++)
                  _CategoryButton(
                    name: widget.pages[i].icon,
                    selected: _selected == i,
                    onTap: () async {
                      if (_moved?.isCompleted == false) return;

                      setState(() {
                        _selected = i;
                      });

                      _moved = Completer();

                      await Scrollable.ensureVisible(
                        widget.pages[i].key.currentContext!,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                      _moved?.complete();
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Widget displaying the buttons.
class _Buttons extends StatelessWidget {
  /// Constructs a [_Buttons] Widget.
  const _Buttons({
    Key? key,
    required this.controller,
    required this.pages,
    this.onSubmit,
    this.scrollController,
  }) : super(key: key);

  /// The editing controller for the math field that the variables are connected
  /// to.
  final MathFieldEditingController controller;

  final List<KeyboardPageConfig> pages;

  /// Function that is called when the enter / submit button is tapped.
  ///
  /// Can be `null`.
  final VoidCallback? onSubmit;

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Column(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < pages.length; i++)
                    Padding(
                      padding: EdgeInsets.only(left: i == 0 ? 0 : 2.0, right: i == pages.length - 1 ? 0 : 2.0),
                      child: Column(
                        key: pages[i].key,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final row in pages[i].keyboard)
                            Row(
                              children: [
                                for (final config in row)
                                  if (config is BasicKeyboardButtonConfig)
                                    _BasicButton(
                                      flex: config.flex,
                                      label: config.label,
                                      onTap: config.args != null
                                          ? () => controller.addFunction(
                                                config.value,
                                                config.args!,
                                                config.suffixArgs,
                                              )
                                          : () => controller.addLeaf(config.value),
                                      asTex: config.asTex,
                                      highlightLevel: i.isOdd ? 1 : 0,
                                    )
                              ],
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  _NavigationButton(
                    flex: 2,
                    icon: Icons.backspace_outlined,
                    iconSize: 22,
                    onTap: () => controller.goBack(deleteMode: true),
                  ),
                  _NavigationButton(
                    flex: 2,
                    icon: Icons.arrow_back,
                    iconSize: 22,
                    onTap: controller.goBack,
                  ),
                  _NavigationButton(
                    flex: 2,
                    icon: Icons.arrow_forward,
                    iconSize: 22,
                    onTap: controller.goNext,
                  ),
                  Expanded(
                    flex: 2,
                    child: _BasicButton(
                      flex: 2,
                      icon: Icons.keyboard_return,
                      onTap: onSubmit,
                      highlightLevel: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Widget displaying a single keyboard button.
class _BasicButton extends StatelessWidget {
  /// Constructs a [_BasicButton].
  const _BasicButton({
    Key? key,
    required this.flex,
    this.label,
    this.icon,
    this.onTap,
    this.asTex = false,
    this.highlightLevel = 0,
  })  : assert(label != null || icon != null),
        super(key: key);

  /// The flexible flex value.
  final int? flex;

  /// The label for this button.
  final String? label;

  /// Icon for this button.
  final IconData? icon;

  /// Function to be called on tap.
  final VoidCallback? onTap;

  /// Show label as tex.
  final bool asTex;

  /// Whether this button should be highlighted.
  final int highlightLevel;

  @override
  Widget build(BuildContext context) {
    Widget result;
    if (label == null) {
      result = Icon(
        icon,
        color: Color(0xFF3B3E43),
      );
    } else if (asTex) {
      result = Math.tex(
        label!,
        options: MathOptions(
          fontSize: 22,
          color: Color(0xFF3B3E43),
        ),
      );
    } else {
      var symbol = label;
      if (label == '.') {
        // We want to display the decimal separator differently depending
        // on the current locale.
        symbol = decimalSeparator(context);
      }

      result = Text(
        symbol!,
        style: const TextStyle(
          fontSize: 22,
          color: Color(0xFF3B3E43),
        ),
      );
    }

    result = KeyboardButton(
      onTap: onTap,
      color: highlightLevel > 1
          ? Color(0xFFFFD54C)
          : highlightLevel == 1
              ? Color(0xFFF4F6FA)
              : Colors.white,
      child: result,
    );

    return SizedBox(
      height: 56,
      width: 64,
      child: result,
    );
  }
}

/// Keyboard button for navigation actions.
class _NavigationButton extends StatelessWidget {
  /// Constructs a [_NavigationButton].
  const _NavigationButton({
    Key? key,
    required this.flex,
    this.icon,
    this.iconSize = 36,
    this.onTap,
  }) : super(key: key);

  /// The flexible flex value.
  final int? flex;

  /// Icon to be shown.
  final IconData? icon;

  /// The size for the icon.
  final double iconSize;

  /// Function used when user holds the button down.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 2,
      child: KeyboardButton(
        onTap: onTap,
        onHold: onTap,
        color: Colors.grey[100]!,
        child: Icon(
          icon,
          color: Colors.black,
          size: iconSize,
        ),
      ),
    );
  }
}

/// Widget for variable keyboard buttons.
class _CategoryButton extends StatefulWidget {
  /// Constructs a [_CategoryButton] widget.
  const _CategoryButton({
    Key? key,
    required this.name,
    required this.selected,
    this.onTap,
  }) : super(key: key);

  /// The variable name.
  final String name;

  /// Whether the button is pressed.
  final bool selected;

  /// Called when the button is tapped.
  final VoidCallback? onTap;

  @override
  State<_CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<_CategoryButton> {
  var _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        widget.onTap?.call();
      },
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        height: 40,
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(left: 8),
        constraints: const BoxConstraints(minWidth: 44),
        decoration: BoxDecoration(
          color: widget.selected || _pressed ? Color(0xFFF4F6FA) : Color(0xFFE5E8F0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SvgPicture.asset(widget.name),
          ),
        ),
      ),
    );
  }
}
