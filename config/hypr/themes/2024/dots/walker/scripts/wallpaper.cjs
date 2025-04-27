const fs = require('fs')
const path = require('path')
const os = require('os')
const process = require('process')

const folderPath = process.env.WALLPAPERS_PATH || path.join(os.homedir(), 'Pictures', 'Wallpapers');

const isFile = (fileName) => {
    return fs.lstatSync(fileName).isFile();
};

const res = fs
    .readdirSync(folderPath)
    .map((fileName) => {
        return path.join(folderPath, fileName);
    })
    .filter(isFile)

const entries = res.map((file) => {
    return {
        label: path.basename(file),
        categories: ["wallpaper"],
        image: file,
        exec: "wallpaper_picker " + file,
    }
});

console.log(JSON.stringify(entries));
