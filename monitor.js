exports.action = function(data, callback, config, SARAH) {
  var exec = require('child_process').exec;
  var process = 'plugins/monitor/script.sh';

  var child = exec(process,
  function (error, stdout, stderr) {
    if (error !== null) {
	  callback({'tts': "Il y a eu une erreur."});
    } else {
	  callback({'tts': stdout});
	}
  });
}