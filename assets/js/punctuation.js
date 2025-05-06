// Mapping of languages to their punctuation rules
const punctuationRules = {
  // Add non-breaking space before these punctuation marks
  fr: { regex: /(\s?)([!?;:»])/g, replacement: '\u00A0$2' },
  en: { regex: /\s+([!?;:])/g, replacement: '$1' },
  de: { regex: /"(.+?)"/g, replacement: '„$1“' },
  // You can add more languages here with their own rules
}

// Detect the current document language
const lang = document.documentElement.lang?.substring(0, 2).toLowerCase() || 'en'

// If rules exist for this language, apply them
if (punctuationRules[lang]) {
  document.addEventListener("DOMContentLoaded", () => {
    const rule = punctuationRules[lang]
    const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT)

    while (walker.nextNode()) {
      const node = walker.currentNode
      if (!node.parentNode.closest("script, style, code, pre")) {
        node.textContent = node.textContent.replace(rule.regex, rule.replacement)
      }
    }
  })
}
