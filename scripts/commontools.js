
function viewportWidth() {
    if (typeof window.innerWidth != 'undefined') {
        return (window.innerWidth);
    }
    else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientWidth != 'undefined' && document.documentElement.clientWidth != 0) {
        return (document.documentElement.clientWidth);
    }
    else {
        return (document.getElementsByTagName('body')[0].clientWidth);
    }
}

function viewportHeight() {
    if (typeof window.innerWidth != 'undefined') {
        return (window.innerHeight);
    }
    else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientWidth != 'undefined' && document.documentElement.clientWidth != 0) {
        return (document.documentElement.clientHeight);
    }
    else {
        return (document.getElementsByTagName('body')[0].clientHeight);
    }
}