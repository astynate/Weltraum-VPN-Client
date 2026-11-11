import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/classes/application/premium_state.dart';
import 'package:weltraum/elements/button_content/text_button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/button.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:weltraum/screens/start/start_screen.dart';
import 'package:weltraum/widgets/header/header.dart';

const Color bgTop = Color(0xFF51407F);
const Color bgBottom = Color(0xFF20113F);
const Color panelColor = Color(0xFF403263);
const Color borderColor = Color(0xFF69578D);
const Color mutedColor = Color(0xFFC9C1DA);

class PaymentMethod {
  final String name;
  final String id;

  const PaymentMethod(this.name, this.id);
}

const methods = [
  PaymentMethod('Mastercard', 'mastercard'),
  PaymentMethod('VISA', 'visa'),
  PaymentMethod('PayPal', 'paypal'),
  PaymentMethod('МИР', 'mir'),
  PaymentMethod('Другой способ', 'other'),
];

/// Способы, которые Stripe не поддерживает.
const unsupportedMethods = {'mir'};

/// Ссылки на оплату из Stripe Dashboard -> Payment Links.
/// Ключ: длительность в месяцах (0 = подписка "Monthly").
const Map<int, String> paymentLinks = {
  0: 'https://buy.stripe.com/test_aFa3cx7Rc5iN5OVfNk0co07',
  1: 'https://buy.stripe.com/test_5kQ7sN6N84eJ6SZat00co02',
  2: 'https://buy.stripe.com/test_5kQ6oJ1sObHb9171Wu0co03',
  3: 'https://buy.stripe.com/test_bJedRbb3oh1v5OVdFc0co04',
  6: 'https://buy.stripe.com/test_00w14pb3odPj7X330y0co05',
  12: 'https://buy.stripe.com/test_eVqcN72wSeTn1yF8kS0co06',
};

const Map<String, String> methodLinks = {
  // '3_paypal': 'https://buy.stripe.com/XXXXXXXX_3m_paypal',
};

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod selected = methods[0];
  bool isLoading = false;

  void showError(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Uri? buildPaymentUri(int duration, PaymentMethod method) {
    final base = methodLinks['${duration}_${method.id}'] ?? paymentLinks[duration];
    if (base == null) return null;

    final uri = Uri.parse(base);

    return uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        // Приходит в webhook checkout.session.completed как client_reference_id.
        // Допустимы только буквы, цифры, "-" и "_".
        'client_reference_id': '${method.id}_${duration}m',
        'locale': 'auto',
        // 'prefilled_email': userEmail,
      },
    );
  }

  Future<void> pay() async {
    if (isLoading) return;

    if (unsupportedMethods.contains(selected.id)) {
      showError('${selected.name} не поддерживается. Выберите другой способ.');
      return;
    }

    final premiumState = context.read<PremiumState>();
    final uri = buildPaymentUri(premiumState.duration, selected);

    print(uri);

    if (uri == null) {
      showError('Для этого тарифа не настроена ссылка на оплату');
      return;
    }

    setState(() => isLoading = true);

    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) showError('Не удалось открыть страницу оплаты');
    } catch (e) {
      showError('Ошибка: $e');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void openPaymentSelector() {
    showModalBottomSheet<PaymentMethod>(
      context: context,
      useSafeArea: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x990B0617),
      builder: (sheetContext) {
        return PaymentSelector(
          selected: selected,
          onSelect: (method) {
            Navigator.pop(sheetContext, method);
          },
        );
      },
    ).then((method) {
      if (method != null && mounted) {
        setState(() => selected = method);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ApplicationState>();
    final premiumState = context.watch<PremiumState>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              state.theme.backgroundGradientStart,
              state.theme.backgroundGradientEnd,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Column(
              children: [
                Header(isHasPaddings: false),

                const SizedBox(height: 40),

                const Text(
                  'Payment Method',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 38,
                    height: 1.12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 3),

                const Text(
                  'Choose Your payment method.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mutedColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 30),

                // TOP CHOOSE CARD
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: openPaymentSelector,
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.035),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.035),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.035),
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: [
                              const SizedBox(width: 0),
                              PaymentLogo(id: selected.id, size: 48),
                              const SizedBox(width: 13),
                              Expanded(
                                child: Text(
                                  selected.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 31,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  height: 80,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.025),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.1),
                            borderRadius: BorderRadius.circular(27),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                premiumState.duration == 0
                                    ? 'Monthly'
                                    : '${premiumState.duration} Month Premium',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: const Color.fromRGBO(255, 255, 255, 0.2),
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.1),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Text(
                          premiumState.duration == 0
                              ? '${premiumState.currency.symbol}${premiumState.monthlyPrice} / Month'
                              : '${premiumState.currency.symbol}${(premiumState.monthlyPrice * premiumState.duration).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                MainButton(
                  onPressed: isLoading ? () {} : pay,
                  buttonStyle: AccentButtonStyle(),
                  buttonContent: TextButtonContent(
                    label: isLoading ? "Loading..." : "Pay",
                    style: AccentButtonStyle(),
                  ),
                ),

                const SizedBox(height: 8.0),

                MainButton(
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                  buttonStyle: secondaryButtonStyle,
                  buttonContent: TextButtonContent(
                    label: "Back",
                    style: secondaryButtonStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentSelector extends StatelessWidget {
  final PaymentMethod selected;
  final ValueChanged<PaymentMethod> onSelect;

  const PaymentSelector({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF261944),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          padding: EdgeInsets.fromLTRB(
            14,
            14,
            14,
            MediaQuery.of(context).padding.bottom + 10,
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(100, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 15),

                ...methods.map((method) {
                  final isSelected = method.id == selected.id;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onSelect(method),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          height: 90,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4A3A6C)
                                : const Color(0xFF40335D),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF75619C)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: PaymentLogo(
                              id: method.id,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentLogo extends StatelessWidget {
  final String id;
  final double size;

  const PaymentLogo({
    super.key,
    required this.id,
    this.size = 42,
  });

  @override
  Widget build(BuildContext context) {
    switch (id) {
      case 'mastercard':
        return SizedBox(
          width: size,
          height: size * 0.68,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: size * 0.57,
                  height: size * 0.57,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: size * 0.57,
                  height: size * 0.57,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: size * 0.28,
                  height: size * 0.57,
                  decoration: BoxDecoration(
                    color: const Color(0xFFAAA0BF).withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(size),
                  ),
                ),
              ),
            ],
          ),
        );

      case 'visa':
        return Text(
          'VISA',
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.55,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            letterSpacing: -1.4,
          ),
        );

      case 'paypal':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_balance_wallet_rounded,
              size: size * 0.68,
              color: Colors.white,
            ),
            const SizedBox(width: 5),
            Text(
              'PayPal',
              style: TextStyle(
                fontSize: size * 0.39,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        );

      case 'mir':
        return Text(
          'МИР',
          style: TextStyle(
            fontSize: size * 0.62,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.6,
          ),
        );

      default:
        return Icon(
          Icons.public_rounded,
          color: Colors.white,
          size: size * 0.72,
        );
    }
  }
}