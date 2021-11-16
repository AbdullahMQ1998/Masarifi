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

  /// `Needs`
  String get needs {
    return Intl.message(
      'Needs',
      name: 'needs',
      desc: '',
      args: [],
    );
  }

  /// `Wants`
  String get wants {
    return Intl.message(
      'Wants',
      name: 'wants',
      desc: '',
      args: [],
    );
  }

  /// `Saving`
  String get saving {
    return Intl.message(
      'Saving',
      name: 'saving',
      desc: '',
      args: [],
    );
  }

  /// `Needs are expenses that you can’t avoid, payments for all the essentials that would be difficult to live without.`
  String get needsDefinition {
    return Intl.message(
      'Needs are expenses that you can’t avoid, payments for all the essentials that would be difficult to live without.',
      name: 'needsDefinition',
      desc: '',
      args: [],
    );
  }

  /// `50% of your monthly income should cover your most necessary costs.`
  String get needsPercentage {
    return Intl.message(
      '50% of your monthly income should cover your most necessary costs.',
      name: 'needsPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Based on your monthly income`
  String get basedOn {
    return Intl.message(
      'Based on your monthly income',
      name: 'basedOn',
      desc: '',
      args: [],
    );
  }

  /// `your budget on needs is`
  String get yourBudgetNeeds {
    return Intl.message(
      'your budget on needs is',
      name: 'yourBudgetNeeds',
      desc: '',
      args: [],
    );
  }

  /// `your budget on wants is`
  String get yourBudgetWants {
    return Intl.message(
      'your budget on wants is',
      name: 'yourBudgetWants',
      desc: '',
      args: [],
    );
  }

  /// `Wants are defined as non-essential expenses—things that you choose to spend your money on, although you could live without them if you had to.`
  String get wantsDefinition {
    return Intl.message(
      'Wants are defined as non-essential expenses—things that you choose to spend your money on, although you could live without them if you had to.',
      name: 'wantsDefinition',
      desc: '',
      args: [],
    );
  }

  /// `30% of your monthly income can be used to cover your wants`
  String get wantsPercentage {
    return Intl.message(
      '30% of your monthly income can be used to cover your wants',
      name: 'wantsPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Consistently putting aside 20% of your pay each month can help you build a better, more durable savings plan.`
  String get savingDefinition {
    return Intl.message(
      'Consistently putting aside 20% of your pay each month can help you build a better, more durable savings plan.',
      name: 'savingDefinition',
      desc: '',
      args: [],
    );
  }

  /// `the remaining 20% can be put towards achieving your savings goals`
  String get savingPercentage {
    return Intl.message(
      'the remaining 20% can be put towards achieving your savings goals',
      name: 'savingPercentage',
      desc: '',
      args: [],
    );
  }

  /// `If you manged to save`
  String get managedToSave {
    return Intl.message(
      'If you manged to save',
      name: 'managedToSave',
      desc: '',
      args: [],
    );
  }

  /// `every month and invest with 5% interest rate, you will ended up having`
  String get investWith {
    return Intl.message(
      'every month and invest with 5% interest rate, you will ended up having',
      name: 'investWith',
      desc: '',
      args: [],
    );
  }

  /// `years based on your retirement date`
  String get yearsBasedOnRetireDay {
    return Intl.message(
      'years based on your retirement date',
      name: 'yearsBasedOnRetireDay',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `PREFERENCES`
  String get preferences {
    return Intl.message(
      'PREFERENCES',
      name: 'preferences',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Income`
  String get monthlyIncome {
    return Intl.message(
      'Monthly Income',
      name: 'monthlyIncome',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Delete Bill`
  String get deleteBill {
    return Intl.message(
      'Delete Bill',
      name: 'deleteBill',
      desc: '',
      args: [],
    );
  }

  /// `Delete  Expense`
  String get deleteExpense {
    return Intl.message(
      'Delete  Expense',
      name: 'deleteExpense',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to delete the current monthly bill?`
  String get wouldYouLikeDeleteMonthly {
    return Intl.message(
      'Would you like to delete the current monthly bill?',
      name: 'wouldYouLikeDeleteMonthly',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to delete the current expense?`
  String get wouldYouLikeDeleteExpense {
    return Intl.message(
      'Would you like to delete the current expense?',
      name: 'wouldYouLikeDeleteExpense',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
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