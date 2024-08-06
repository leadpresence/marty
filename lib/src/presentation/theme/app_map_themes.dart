import '../../core/utils/utils.dart';

class AppMapThemes {
  AppMapThemes._();

  static List mapTheme({bool? isDarkMode}) =>
      (isDarkMode ?? LocalStorage.instance.getAppThemeMode())
          ? mapDarkTheme
          : mapLightTheme;

  static const mapDarkTheme = [
    {
      "elementType": "geometry",
      "stylers": [
        {"color": "#242f3e"}
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#746855"}
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {"color": "#242f3e"}
      ]
    },
    {
      "featureType": "administrative.locality",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#d59563"}
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#d59563"}
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {"color": "#263c3f"}
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#6b9a76"}
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        {"color": "#38414e"}
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry.stroke",
      "stylers": [
        {"color": "#212a37"}
      ]
    },
    {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#9ca5b3"}
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {"color": "#746855"}
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry.stroke",
      "stylers": [
        {"color": "#1f2835"}
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#f3d19c"}
      ]
    },
    {
      "featureType": "transit",
      "elementType": "geometry",
      "stylers": [
        {"color": "#2f3948"}
      ]
    },
    {
      "featureType": "transit.station",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#d59563"}
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {"color": "#17263c"}
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#515c6d"}
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.stroke",
      "stylers": [
        {"color": "#17263c"}
      ]
    }
  ];

  static const mapLightTheme = [
    {
      "featureType": "administrative.province",
      "elementType": "all",
      "stylers": [
        {"visibility": "off"}
      ]
    },
    {
      "featureType": "landscape",
      "elementType": "all",
      "stylers": [
        {"saturation": -100},
        {"lightness": "66"},
        {"visibility": "on"},
        {"color": "#fffff7"}
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry.fill",
      "stylers": [
        {"color": "#fcf3da"},
        {"lightness": 40},
        {"saturation": -40}
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry.fill",
      "stylers": [
        {"color": "#ef8c25"},
        {"lightness": 40}
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry.stroke",
      "stylers": [
        {"visibility": "on"}
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "all",
      "stylers": [
        {"saturation": -100},
        {"lightness": 40},
        {"visibility": "on"}
      ]
    },
    {
      "featureType": "transit",
      "elementType": "all",
      "stylers": [
        {"saturation": -100},
        {"visibility": "simplified"}
      ]
    },
    {
      "featureType": "water",
      "elementType": "all",
      "stylers": [
        {"visibility": "on"},
        {"lightness": 30},
        {"weight": "1.32"}
      ]
    }
  ];
}
