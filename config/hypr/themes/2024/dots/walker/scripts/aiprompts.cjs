const fs = require('fs')
const path = require('path')
const os = require('os')

const cachePromptPath = path.join(os.homedir(), '.cache', 'walker', 'aiprompts.csv');

async function downloadcachePrompts() {
    const https = require('https');
    return new Promise((resolve, reject) => {
        https.get('https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/refs/heads/main/prompts.csv', (response) => {
            const fileStream = fs.createWriteStream(cachePromptPath);
            response.pipe(fileStream);
            fileStream.on('finish', () => {
                fileStream.close();
                resolve();
            });
        }).on('error', (err) => {
            reject(err);
        });
    });
}

async function run() {
    if (!fs.existsSync(cachePromptPath) || fs.statSync(cachePromptPath).lastModifiedDate < new Date(Date.now() - 48 * 60 * 60 * 1000)) {
        await downloadcachePrompts();
    }

    // Read the prompts from the cached CSV file
    const res = fs
        .readFileSync(cachePromptPath, 'utf8')
        .split('\n')
        .map((line) => {
            let res = line.match(/^"(.*)","(.*)",(.*)/)
            if (!res) {
                return;
            }
            return {
                title: res[1],
                prompt: res[2],
                forDev: res[3] === 'TRUE'
            }
        })
        .filter((line) => line?.title && line?.prompt);

    const entries = res.map((p) => {
        if (p.forDev) {
            return {
                label: p.title,
                categories: ["aiprompt"],
                exec: "xdg-open https://github.com/copilot?prompt=" + encodeURIComponent(p.prompt),
            }
        }
        return {
            label: p.title,
            categories: ["aiprompt"],
            exec: "xdg-open https://chatgpt.com/?prompt=" + encodeURIComponent(p.prompt),
        }
    });

    console.log(JSON.stringify(entries));
}

run()
