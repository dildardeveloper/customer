class APIConfigs {
  static String baseUrl = "http://86.48.5.110:8082";
  static String serverUrl = "http://86.48.5.110:8082";
  static String socket = "ws://86.48.5.110:8082";
  static String serverIp = "86.48.5.110:8082";
  // static String baseUrl = "http://154.38.165.94:8082";
  // static String serverUrl = "http://154.38.165.94:8082";
  // static String socket = "ws://86.48.5.110:8082";
  // static String serverIp = "154.38.165.94:8082";
  // static String baseUrl = "http://161.97.142.169:8082";
  // static String serverUrl = "http://161.97.142.169:8082";
  // static String socket = "ws://161.97.142.169:8082";
  // static String serverIp = "161.97.142.169:8082";
  static String login = "/api/session";
  static String devices = '/api/devices';
  static String positions = '/api/positions';
  static String geofences = '/api/geofences';
  static String summary = '/api/reports/summary';
  static String trips = '/api/reports/trips';
  static String route = '/api/reports/route';
  static String event = '/api/reports/events';
  static String stops = '/api/reports/stops';
  static String drivers = '/api/drivers';
  static String user = '/api/users';
  static String nearByApis =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyBuFLF_zkyFja0Ca6OLrSZKF0ZQvci_MJs&radius=5000&location=';
}
