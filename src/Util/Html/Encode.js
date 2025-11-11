export const decodeHtmlEntities = function(str) {
    const txt = document.createElement("textarea");
    txt.innerHTML = str;
    const result = txt.value;
    txt.remove();
    return result;
};

export const encodeHtmlEntities = function(str) {
    const txt = document.createElement("textarea");
    txt.textContent = str;
    const result = txt.innerHTML;
    txt.remove();
    return result;
};