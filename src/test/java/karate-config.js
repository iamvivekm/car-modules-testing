function fn() {
  var env = karate.env;
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    url: 'http://localhost:'
  }
  if (env == 'dev') {
       //todo
  } else if (env == 'e2e') {
    //todo
  }
  return config;
}