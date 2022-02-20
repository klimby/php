const stringifyPackage = require('stringify-package');
const detectIndent = require('detect-indent');
const detectNewline = require('detect-newline');

module.exports.readVersion = function (contents) {
    result = contents.match(/\[Version\sv(\d{1,4}\.\d{1,4}\.\d{1,4})]/);
    return result ? result[1] : undefined;
};

module.exports.writeVersion = function (contents, version) {

    contents = contents.replace(/\[Version\sv\d{1,4}\.\d{1,4}\.\d{1,4}]/, `[Version v${version}]`);
    contents = contents.replace(/"Version\sv\d{1,4}\.\d{1,4}\.\d{1,4}"/, `"Version v${version}"`);
    contents = contents.replace(/badge\/version-v\d{1,4}\.\d{1,4}\.\d{1,4}-/, `badge/version-v${version}-`);

    return contents
};
