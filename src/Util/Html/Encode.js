import he from 'he';

export const decodeHtmlEntities = function(str) {
    return he.decode(str);
};

export const encodeHtmlEntities = function(str) {
    return he.encode(str);
};