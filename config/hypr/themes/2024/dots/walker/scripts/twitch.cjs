const { exec } = require('child_process');
const os = require('os');

let entries = [];
const homeDir = os.homedir();
const live_channels = exec(homeDir + "/go/bin/livestream-ctl list", (error, stdout, stderr) => {
    if (error || stderr) {
        console.log(JSON.stringify(entries));
        return
    }
    const streams = JSON.parse(stdout);
    for (const stream of streams) {
        entry = {
            label: stream.title.substring(0, 80),
            sub: stream.channel,
            categories: stream.tags,
            image: stream.thumbnail,
            exec: homeDir + "/go/bin/livestream-ctl launch " + stream.channel,
            weight: stream.viewer_count,
        }
        entries.push(entry);
    }
    console.log(JSON.stringify(entries));
});
