import he from 'he';

export const _decodeHtmlEntities = function(str) {
    return he.decode(str);
};

export const _encodeHtmlEntities = function(str) {
    return he.encode(str);
};