// Simplified example of a scout file
(function () {

  // The async script injection fanfare
  var script = document.createElement('script');
  var fScript = document.getElementsByTagName('script')[0];

  var baseUrl = '/script/blueApp.js';

  // Set the URL on the script
  script.src = baseUrl;

  // Inject the script
  fScript.parentNode.insertBefore(script, fScript);


  document.createStyleSheet('/style/application.css');

})();
