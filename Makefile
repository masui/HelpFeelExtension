.PHONY: yahoo-auction.json

js:
	npm run build

yahoo-auction.json:
	/bin/rm -f yahoo-auction.json
	wget https://helpfeel.notainc.com/helpdata/yahoo-auction.json
yahoo-auction.js: yahoo-auction.json
	echo "var data =" > yahoo-auction.js
	jq . < yahoo-auction.json >> yahoo-auction.js


#
# Chromeエクステンション公開用のzipを作る
#
ZIPFILES=manifest.json helpfeel.js jquery-2.1.4.min.js asearch.js search.js shuffle.js icons/helpfeel-48.png icons/helpfeel-96.png
zip: js
	/bin/rm -f helpfeel.zip
	zip -r helpfeel.zip ${ZIPFILES}

