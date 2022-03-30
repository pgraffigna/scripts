#!/bin/bash
# rutina web

# URLs
YOUTUBE="https://www.youtube.com/"
GMAIL="https://gmail.com"
WHAT="https://web.whatsapp.com"
KEEP="https://keep.google.com/"
NAGIOS="http://alv-nagios-01/nagios/"
ST="https://st.cultura.gob.ar/scp/login.php"

brave-browser --new-tab -url "$YOUTUBE" --new-tab -url "$GMAIL" \
	      --new-tab -url "$WHAT" --new-tab -url "$KEEP" --new-tab -url "$NAGIOS" --new-tab -url "$ST" 2>/dev/null &
