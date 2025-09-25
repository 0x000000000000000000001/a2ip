"use strict";

import fs from "fs";
import path from "path";

export const detectTestModuleNamePrefix = function() {
    return function() {
        const filePath = path.join(__dirname, 'Module.purs');

        const fileContent = fs.readFileSync(filePath, 'utf8');

        const match = fileContent.match(/module\s+([^\s.]+)\./);

        if (match && match[1]) {
            return match[1] + ".";
        }

        return '';
    };
};
