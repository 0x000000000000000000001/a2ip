import { isNode } from '../Util.Env/index.js'

const textArea = !isNode ? document.createElement('textarea') : null;

export const decodeHtmlEntities = function(str) {
    // Browser
    if (textArea) {
        textArea.innerHTML = str;
        return textArea.value;
    }
    
    // Node
    try {
        const he = require('he');
        return he.decode(str);
    } catch (e) {
        return str;
    }
};

export const encodeHtmlEntities = function(str) {
    // Browser
    if (textArea) {
        textArea.textContent = str;
        return textArea.innerHTML;
    }
    
    // Node
    try {
        const he = require('he');
        return he.encode(str);
    } catch (e) {
        return str;
    }
};