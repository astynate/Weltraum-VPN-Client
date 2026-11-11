import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SubscriptionType {
  free,
  premium,
  pro,
}

enum Currency {
  eur,
  usd,
  rub,
}

extension CurrencyExtension on Currency {
  String get symbol {
    switch (this) {
      case Currency.eur:
        return '€';
      case Currency.usd:
        return r'$';
      case Currency.rub:
        return '₽';
    }
  }
}

extension SubscriptionTypeExtension on SubscriptionType {
  String get title {
    switch (this) {
      case SubscriptionType.free:
        return 'Free';
      case SubscriptionType.premium:
        return 'Premium';
      case SubscriptionType.pro:
        return 'Pro';
    }
  }

  double price(Currency currency) {
    switch (this) {
      case SubscriptionType.free:
        return 0;

      case SubscriptionType.premium:
        switch (currency) {
          case Currency.eur:
            return 2.99;
          case Currency.usd:
            return 3.15;
          case Currency.rub:
            return 299;
        }

      case SubscriptionType.pro:
        switch (currency) {
          case Currency.eur:
            return 9.99;
          case Currency.usd:
            return 11.99;
          case Currency.rub:
            return 599;
        }
    }
  }

  String formattedPrice(Currency currency) {
    final value = price(currency);
    final amount = value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(2);

    return '$amount${currency.symbol}/мес.';
  }
}

class PremiumState extends ChangeNotifier {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  SubscriptionType subscription = SubscriptionType.premium;
  Currency currency = Currency.eur;
  int duration = 0;

  bool get isPremium =>
      subscription == SubscriptionType.premium ||
      subscription == SubscriptionType.pro;

  bool get isPro => subscription == SubscriptionType.pro;

  double get monthlyPrice => subscription.price(currency);

  String get formattedMonthlyPrice => subscription.formattedPrice(currency);

  Future<void> setSubscription(
    SubscriptionType type, {
    int duration = 0,
  }) async {
    print(this.duration);

    subscription = type;
    this.duration = duration;

    await storage.write(
      key: 'subscription',
      value: type.name,
    );

    await storage.write(
      key: 'subscription_duration',
      value: duration.toString(),
    );

    notifyListeners();
  }

  Future<void> setCurrency(Currency value) async {
    currency = value;

    await storage.write(
      key: 'subscription_currency',
      value: value.name,
    );

    notifyListeners();
  }

  Future<void> loadSubscription() async {
    final savedSubscription = await storage.read(key: 'subscription');
    final savedDuration = await storage.read(
      key: 'subscription_duration',
    );
    final savedCurrency = await storage.read(
      key: 'subscription_currency',
    );

    subscription = SubscriptionType.values.firstWhere(
      (e) => e.name == savedSubscription,
      orElse: () => SubscriptionType.free,
    );

    currency = Currency.values.firstWhere(
      (e) => e.name == savedCurrency,
      orElse: () => Currency.eur,
    );

    duration = int.tryParse(savedDuration ?? '') ?? 0;

    notifyListeners();
  }

  Future<void> clear() async {
    subscription = SubscriptionType.free;
    duration = 0;

    await storage.delete(key: 'subscription');
    await storage.delete(key: 'subscription_duration');

    notifyListeners();
  }
}