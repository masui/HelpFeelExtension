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
ZIPFILES=manifest.json realurl.js jquery-2.1.4.min.js md5.js crypt.js settings.js settings.html icons/realurl-48.png icons/realurl-96.png
zip: js
	/bin/rm -f realurl.zip
	zip -r realurl.zip ${ZIPFILES}

