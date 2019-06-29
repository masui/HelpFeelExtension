//
// 配列をランダムに並べかえる
//
function shuffle(array) {
    let n = array.length
    while (n) {
	const i = Math.floor(Math.random() * n--);
	[array[i], array[n]] = [array[n], array[i]]
    }
    return array
}
