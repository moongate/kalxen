// Listen on port 9001
var gith = require('gith').create(9001);
// Import execFile, to run our bash script
var execFile = require('child_process').execFile;

gith({
    repo: 'moongate/laere'
}).on('all', function (payload) {
    if (payload.branch === 'master') {
        // Exec a shell script
        execFile('./hook.sh', function (error, stdout, stderr) {
            if (error) {
                throw error;
            }
                            console.log(stdout);
                            console.log(stderr);
            // Log success in some manner
            console.log('Summon complete...');
        });
    }
});
