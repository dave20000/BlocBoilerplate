enum Flavor {
  dev,
  staging,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'BlocBoilerplate Dev';
      case Flavor.staging:
        return 'BlocBoilerplate Staging';
      case Flavor.prod:
        return 'BlocBoilerplate Prod';
      default:
        return 'title';
    }
  }
}
