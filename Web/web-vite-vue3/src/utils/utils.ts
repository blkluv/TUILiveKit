
/**
 * Get the value of the specified key from window.location.href
 * @param {*} key key to get
 * @returns Get the value of the specified key from window.location.href
 * @example
 * const value = getUrlParam(key);
 */
export function getUrlParam(key: string) {
  const url = window?.location.href.replace(/^[^?]*\?/, '');
  const regexp = new RegExp(`(^|&)${key}=([^&#]*)(&|$|)`, 'i');
  const paramMatch = url?.match(regexp);

  return paramMatch ? paramMatch[2] : null;
}

/**
 * Get language
 * @returns language
 */
export function getLanguage() {
  let language = getUrlParam('lang')
    || localStorage.getItem('tuiLive-language')
    || navigator.language
    || 'en-US';
  language = language.replace(/_/, '-').toLowerCase();
  const isZh = language.startsWith('zh');
  language = isZh ? 'zh-CN' : 'en-US';

  return language;
}

/**
 * Get Theme
 * @returns Theme
 */
export function getTheme() {
  let storedTheme = localStorage.getItem('tuiLive-currentTheme') || 'LIGHT';

  if (storedTheme === 'white') {
    storedTheme = 'LIGHT';
  } else if (storedTheme === 'black') {
    storedTheme = 'DARK';
  }

  return storedTheme;
}
