import ssl
import urllib

list_url = {
    'Test': 'https://cardtest.sacombank.com.vn:9443/epay/stb',
    'Live': 'https://card.sacombank.com.vn/epay/stb',
}

protocol = {
    'TLS1': ssl.PROTOCOL_TLSv1,
    'TLS1.1': ssl.PROTOCOL_TLSv1_1,
    'TLS1.2': ssl.PROTOCOL_TLSv1_2,
}

for env, url in list_url.items():
    print(env)
    for p_key, p_val in protocol.items():
        try:
            ctx = ssl.SSLContext(p_val)
            response = urllib.request.urlopen(url, context=ctx).read()            
            print('\t' + p_key + ': Success')
        except:
            print('\t' + p_key + ': Fail')
