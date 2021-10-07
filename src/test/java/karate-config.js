function fn() {
  var env = karate.env;
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    url: 'http://localhost:'
  }
  if (env == 'perf') {
    config.url = 'http://localhost:8095/car'
  }
  return config;
}