const http = require("http")
const {execSync} = require("child_process")

let lastSwitchTime = 0

const server = http.createServer((request, response) => {
	const timeDelta = Date.now() - lastSwitchTime

	if (timeDelta >= 500) {
		try {
			execSync("/usr/local/bin/dev.sz-coder.node-keywatcher-server-send-serial", {
				silent: true,
				timeout: 1500
			});
		} catch (e) {
			process.stderr.write(`error: ${e.message}\n`)
		}

		response.writeHead(200)
	} else {
		response.writeHead(503)
	}

	lastSwitchTime = Date.now()
	response.end()
})

server.listen(4444)
