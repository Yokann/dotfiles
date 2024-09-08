const { exec } = require('child_process');

let entries = [];
const live_channels = exec("~/.dotfiles/config/hypr/scripts/twitch_live_channels", (error, stdout, stderr) => {
    if (error || stderr) {
        console.log(JSON.stringify(entries));
        return
    }
    const streams = JSON.parse(stdout);
    for (const stream of streams) {
        entry = {
            label: stream.title.substring(0, 80),
            sub: stream.user_name,
            categories: stream.tags,
            image:  "/tmp/twitch/"+stream.user_id+".jpg",
            exec: "stream "+stream.user_name,
            weight: stream.viewer_count,
        }
        entries.push(entry);
    }
    console.log(JSON.stringify(entries));
});
