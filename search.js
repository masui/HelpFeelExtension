// 以下のものを若干修正したもの (masui 2019/6/29)
// https://github.com/nota/helpfeel/blob/master/src/client/js/lib/search.js

// よみからマッチするキーワードを見つける
const findKeywordFromYomi = (query) => {
    //const { keywords } = //QuestionStore
    const keywords = data['keywords']

    // マッチしたもののうち、短いほうを採用する
    const matchKeywords = keywords.filter(({ yomi }) => yomi.indexOf(query) > -1)
    if (matchKeywords.length < 1) return
    
    matchKeywords.sort((a, b) => a.original.length - b.original.length)
    return matchKeywords[0].original
}

// remove faq that has duplicated url
const filterDuplicatedUrl = (faqList) => {
    const urlListed = {}
    return faqList.filter(faq => {
	const url = faq.url || faq.faq.url
	const exist = urlListed[url]
	urlListed[url] = true
	return !exist
    })
}

//
// queryにマッチするFAQエントリをすべてリストし、
// その中のものをランダムに表示する
//
const searchFAQ = (query) => {
    //const { faqs } = QuestionStore
    const faqs = data['faqs']
    if (!query || !query.trim()) return []
    const words = query.trim().split(/\s+/, 4)
    if (words.length < 1) return []
    
    shuffle(faqs)
    
    // AND検索する
    if (words.length > 1) {
	let faqList = searchByAnd(words)
	if (faqList.length > 0) return faqList
    }
    
    // OR検索する
    return searchByOr(words)
}

const compareByPriority = (a, b) => {
    return a.priority === b.priority ? 0 : (a.priority < b.priority ? -1 : 1)
}

const searchByAnd = (words) => {
    // const { faqs } = QuestionStore
    const faqs = data['faqs']
    const faqList = []
    const asearches = words.map(word => new Asearch(' ' + word + ' '))
    const ambig = 0
    for (const faq of faqs) {
	const matchCount = asearches.filter(a => a.match(faq.title, ambig)).length
	if (matchCount === words.length) {
	    faqList.push({ faq, hits: words, priority: 1 })
	} else if (words.length > 2 && matchCount > 1) {
	    // 3つ以上の単語のANDの場合は、2つのマッチでも候補に加える
	    faqList.push({ faq, hits: words, priority: 2 })
	}
    }
    faqList.sort(compareByPriority)
    return filterDuplicatedUrl(faqList)
}

const searchByOr = (words) => {
    // const { faqs } = QuestionStore
    const faqs = data['faqs']
    const faqList = []
    const asearches = words.map(word => new Asearch(' ' + word + ' '))
    const regexps = words.map(word => new RegExp(word, 'i'))
    const ambig = 0 // 曖昧レベル
    for (const faq of faqs) {
	if (regexps.some(r => r.test(faq.title))) { // 完全一致
	    faqList.push({ faq, hits: words, priority: 1 })
	} else if (asearches.some(a => a.match(faq.title, ambig))) { // 曖昧検索
	    faqList.push({ faq, hits: words, priority: 2 })
	}
    }
    
    // keywordが読みにマッチしないか確認する
    if (faqList.length < 30) {
	const wordsFromYomi = words.map(word => findKeywordFromYomi(word)).filter(word => !!word)
	if (wordsFromYomi.length > 0) {
	    console.log('found from yomi', words, wordsFromYomi)
	    const asearches = wordsFromYomi.map(word => new Asearch(' ' + word + ' '))
	    for (const faq of faqs) {
		if (asearches.some(a => a.match(faq.title, ambig))) {
		    faqList.push({ faq, hits: wordsFromYomi, priority: 3 })
		}
	    }
	}
    }
    
    // さらに曖昧検索する
    if (words.every(word => word.length > 1) && faqList.length < 3) {
	for (const ambig of [1, 2]) { // 曖昧レベル
	    for (const faq of faqs) {
		if (asearches.some(a => a.match(faq.title, ambig))) {
		    faqList.push({ faq, hits: words, priority: 3 + ambig })
		}
	    }
	    if (faqList.length > 0) break
	}
    }
    
    faqList.sort(compareByPriority)
    return filterDuplicatedUrl(faqList)
}

//console.log(findKeywordFromYomi('にち'))


