module HTML

	WHITELIST = {
    :html =>
      ['a', 'abbr', 'acronym', 'address', 'aside', 'audio',
        'b', 'bdi', 'bdo', 'blockquote', 'canvas', 'caption',
        'cite', 'code', 'col', 'colgroup', 'datalist', 'dd',
        'del', 'dfn', 'dialog', 'dir', 'dl', 'dt', 'em',
        'figcaption', 'figure', 'footer', 'h1', 'header',
        'hgroup', 'hr', 'i', 'img', 'ins', 'kbd', 'li', 'mark',
        'meter', 'nav', 'noscript', 'ol', 'p', 'pre', 'q', 'rp',
        'rt', 'ruby', 's', 'samp', 'section', 'small', 'source',
        'span', 'strike', 'strong', 'sub', 'sup', 'tbody', 'td',
        'textarea', 'tfoot', 'th', 'thead', 'time', 'tr', 'track',
        'tt', 'u', 'ul', 'var', 'video', 'wbr'],
      :attrs => {
        'a' => ['href', 'title'],
        'abbr' => ['title'],
        'bdo' => ['dir'],
        'blockquote' => ['cite'],
        'img' => ['alt', 'height', 'src', 'width'],
        'ins' => ['cite', 'datetime'],
        'li' => ['value'],
        'meter' => ['high', 'low', 'max', 'min', 'optimum', 'value'],
        'ol' => ['reversed', 'start'],
        'q' => ['cite'],
        'source' => ['media', 'src', 'type'],
        'time' => ['datetime'],
        'track' => ['default', 'kind', 'label', 'src', 'srclang'],
        'video' => ['height', 'poster', 'src', 'width']},
      :strip => ['datalist','style']
    }

end