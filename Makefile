.PHONY: yahoo-auction.json

js:
	npm run build

yahoo-auction:
	/bin/rm -f yahoo-auction.json
	wget https://helpfeel.notainc.com/helpdata/yahoo-auction.json
	echo "var data =" > data.js
	jq . < yahoo-auction.json >> data.js
seven-card:
	/bin/rm -f seven-card.json
	wget https://helpfeel.notainc.com/helpdata/seven-card.json
	echo "var data =" > data.js
	jq . < seven-card.json >> data.js
edesign-sompo:
	/bin/rm -f edesign-sompo.json
	wget https://helpfeel.notainc.com/helpdata/edesign-sompo.json
	echo "var data =" > data.js
	jq . < edesign-sompo.json >> data.js

#
# Chromeエクステンション公開用のzipを作る
#
ZIPFILES=manifest.json helpfeel.js data.js jquery-2.1.4.min.js asearch.js search.js shuffle.js icons/helpfeel-48.png icons/helpfeel-96.png
zip: js
	/bin/rm -f helpfeel.zip
	zip -r helpfeel.zip ${ZIPFILES}

