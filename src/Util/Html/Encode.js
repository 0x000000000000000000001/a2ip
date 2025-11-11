const textArea = document.createElement('textarea');

export const decodeHtmlEntities = function(str) {
    textArea.innerHTML = str;
    return textArea.value;
};

export const encodeHtmlEntities = function(str) {
    textArea.textContent = str;
    return textArea.innerHTML;
};