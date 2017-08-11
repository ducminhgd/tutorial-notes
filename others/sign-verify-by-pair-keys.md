# Python

```python
# Python 2

from Crypto.Signature import PKCS1_v1_5
from Crypto.PublicKey import RSA
from Crypto.Hash import SHA
import base64

def import_rsa_key(key_file):
    content = open(key_file).read()
    return RSA.importKey(content)

def sign(rsa_pri_key_file, data):
    rsa_pri_key = import_rsa_key(rsa_pri_key_file)
    sig_maker = PKCS1_v1_5.new(rsa_pri_key)
    h = SHA.new(data)
    sign = sig_maker.sign(h)
    
    return base64.b64encode(sign)
        
def verify(rsa_pub_key_file, data, sig):
    rsa_pub_key = import_rsa_key(rsa_pub_key_file)
    verifier = PKCS1_v1_5.new(rsa_pub_key)
    h = SHA.new(data)
    sig = sig.decode('base64')
    if verifier.verify(h, sig):
        return True
    else:
        return False
    
if __name__ == '__main__':
    private_key = import_rsa_key('private.pem')
    public_key = import_rsa_key('public.pem')
    data = 'Python'
    signed_data = sign(private_key, data)
    print(signed_data)
    print(verify(public_key, data, signed_data))
```

# PHP

```php
<?php
// fetch private key from file and ready it
$pkeyid = openssl_pkey_get_private("private_key.pem");

$data = 'PHP';

// compute signature
$success = openssl_sign($data, $signature, $pkeyid);
if ($success) {
    echo 'Sign success';
} else {
    echo 'Sign failed'
}

// free the key from memory
openssl_free_key($pkeyid);

$pubkeyid = openssl_pkey_get_public("public_key.pem");

// state whether signature is okay or not
$ok = openssl_verify($data, $signature, $pubkeyid);
if ($ok == 1) {
    echo "good";
} elseif ($ok == 0) {
    echo "bad";
} else {
    echo "ugly, error checking signature";
}
// free the key from memory
openssl_free_key($pubkeyid);
```

# Java

# C#