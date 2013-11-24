var execFile = require('child_process').execFile;
var http = require('http');

var server = http.createServer(function (request, response) {
    if (request.method == 'POST') {
        var body = '';
        request.on('data', function (data) {
            body += data;
            // 1e6 === 1 * Math.pow(10, 6) === 1 * 1000000 ~~~ 1MB
            if (body.length > 1e6) {
                // FLOOD ATTACK OR FAULTY CLIENT, NUKE REQUEST
                request.connection.destroy();
            }
        });
        request.on('end', function () {
            if(body === 'kalxen') {
                console.log('Summon started...');
                execFile('./hook.sh', function (error, stdout, stderr) {
                    if (error) {
                        console.log(error);
                        response.writeHead(500, {"Content-Type": "text/plain"});
                        response.end("i'm not feeling very well...\n");
                    }
                    else {
                        console.log(stdout);
                        console.log(stderr);
                        console.log('Summon complete...');
                        response.writeHead(200, {"Content-Type": "text/plain"});
                        response.end("thanks\n");
                    }
                });
            }
            else {
                response.writeHead(400, {"Content-Type": "text/plain"});
                response.end("bad request\n");
            }
        });
    }
    else {
        response.writeHead(400, {"Content-Type": "text/plain"});
        response.end("bad request\n");
    }
});

server.listen(9001);

// Put a friendly message on the terminal
console.log("Kalxen running at port 9001");