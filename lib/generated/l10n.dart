// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get welcomeText {
    return Intl.message(
      'Welcome',
      name: 'welcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Total balance to spend`
  String get balanceToSpend {
    return Intl.message(
      'Total balance to spend',
      name: 'balanceToSpend',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get saudiRyal {
    return Intl.message(
      'SAR',
      name: 'saudiRyal',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Bills`
  String get monthlyBills {
    return Intl.message(
      'Monthly Bills',
      name: 'monthlyBills',
      desc: '',
      args: [],
    );
  }

  /// `Cost: `
  String get costInMonthsBubble {
    return Intl.message(
      'Cost: ',
      name: 'costInMonthsBubble',
      desc: '',
      args: [],
    );
  }

  /// `Days left`
  String get daysLeft {
    return Intl.message(
      'Days left',
      name: 'daysLeft',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get expense {
    return Intl.message(
      'Expenses',
      name: 'expense',
      desc: '',
      args: [],
    );
  }

  /// `Add Expense`
  String get addExpense {
    return Intl.message(
      'Add Expense',
      name: 'addExpense',
      desc: '',
      args: [],
    );
  }

  /// `Add Monthly Bill`
  String get addMonthlyBill {
    return Intl.message(
      'Add Monthly Bill',
      name: 'addMonthlyBill',
      desc: '',
      args: [],
    );
  }

  /// `Expense Name`
  String get expenseName {
    return Intl.message(
      'Expense Name',
      name: 'expenseName',
      desc: '',
      args: [],
    );
  }

  /// `Expense Cost`
  String get expenseCost {
    return Intl.message(
      'Expense Cost',
      name: 'expenseCost',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Bill Name`
  String get billName {
    return Intl.message(
      'Bill Name',
      name: 'billName',
      desc: '',
      args: [],
    );
  }

  /// `Bill Cost`
  String get billCost {
    return Intl.message(
      'Bill Cost',
      name: 'billCost',
      desc: '',
      args: [],
    );
  }

  /// `Select Bill Date`
  String get billDate {
    return Intl.message(
      'Select Bill Date',
      name: 'billDate',
      desc: '',
      args: [],
    );
  }

  /// `Edit Expense`
  String get editExpense {
    return Intl.message(
      'Edit Expense',
      name: 'editExpense',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Edit Monthly Bill`
  String get editMonthlyBill {
    return Intl.message(
      'Edit Monthly Bill',
      name: 'editMonthlyBill',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Masarifi Category Count`
  String get masarifiCategoryCount {
    return Intl.message(
      'Masarifi Category Count',
      name: 'masarifiCategoryCount',
      desc: '',
      args: [],
    );
  }

  /// `Most Category`
  String get mostCategory {
    return Intl.message(
      'Most Category',
      name: 'mostCategory',
      desc: '',
      args: [],
    );
  }

  /// `Lease Category`
  String get leastCategory {
    return Intl.message(
      'Lease Category',
      name: 'leastCategory',
      desc: '',
      args: [],
    );
  }

  /// `Masarifi Average Users Categories Compare To You`
  String get masaryfyAverageUsersCatefories {
    return Intl.message(
      'Masarifi Average Users Categories Compare To You',
      name: 'masaryfyAverageUsersCatefories',
      desc: '',
      args: [],
    );
  }

  /// `Avg Expense`
  String get avgExpense {
    return Intl.message(
      'Avg Expense',
      name: 'avgExpense',
      desc: '',
      args: [],
    );
  }

  /// `Your Expense`
  String get yourExpense {
    return Intl.message(
      'Your Expense',
      name: 'yourExpense',
      desc: '',
      args: [],
    );
  }

  /// `Most Average Category`
  String get mostAvgCategory {
    return Intl.message(
      'Most Average Category',
      name: 'mostAvgCategory',
      desc: '',
      args: [],
    );
  }

  /// `Your Most Category`
  String get yourMostCategory {
    return Intl.message(
      'Your Most Category',
      name: 'yourMostCategory',
      desc: '',
      args: [],
    );
  }

  /// `Masarifi Users Daily Expense Count`
  String get masarifiUserDaily {
    return Intl.message(
      'Masarifi Users Daily Expense Count',
      name: 'masarifiUserDaily',
      desc: '',
      args: [],
    );
  }

  /// `Daily Expense`
  String get dailyExpense {
    return Intl.message(
      'Daily Expense',
      name: 'dailyExpense',
      desc: '',
      args: [],
    );
  }

  /// `Lowest Day of Purchase`
  String get lowestDay {
    return Intl.message(
      'Lowest Day of Purchase',
      name: 'lowestDay',
      desc: '',
      args: [],
    );
  }

  /// `Best Day of Purchase`
  String get bestDay {
    return Intl.message(
      'Best Day of Purchase',
      name: 'bestDay',
      desc: '',
      args: [],
    );
  }

  /// `Masarifi Users Monthly Expense Count`
  String get masarifiMonthly {
    return Intl.message(
      'Masarifi Users Monthly Expense Count',
      name: 'masarifiMonthly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Expense`
  String get monthlyExpense {
    return Intl.message(
      'Monthly Expense',
      name: 'monthlyExpense',
      desc: '',
      args: [],
    );
  }

  /// `Lowest Month Of Purchase`
  String get lowestMonth {
    return Intl.message(
      'Lowest Month Of Purchase',
      name: 'lowestMonth',
      desc: '',
      args: [],
    );
  }

  /// `Best Month Of Purchase`
  String get bestMonth {
    return Intl.message(
      'Best Month Of Purchase',
      name: 'bestMonth',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}