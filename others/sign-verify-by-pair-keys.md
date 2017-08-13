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

## Sign

```csharp
public static string SignData(string message, RSAParameters privateKey)
{
    //// The array to store the signed message in bytes
    byte[] signedBytes;
    using (var rsa = new RSACryptoServiceProvider())
    {
        //// Write the message to a byte array using UTF8 as the encoding.
        var encoder = new UTF8Encoding();
        byte[] originalData = encoder.GetBytes(message);

        try
        {
            //// Import the private key used for signing the message
            rsa.ImportParameters(privateKey);

            //// Sign the data, using SHA512 as the hashing algorithm 
            signedBytes = rsa.SignData(originalData, CryptoConfig.MapNameToOID("SHA512"));
        }
        catch (CryptographicException e)
        {
            Console.WriteLine(e.Message);
            return null;
        }
        finally
        {
            //// Set the keycontainer to be cleared when rsa is garbage collected.
            rsa.PersistKeyInCsp = false;
        }
    }
    //// Convert the a base64 string before returning
    return Convert.ToBase64String(signedBytes);
}
```


```csharp
public static byte[] HashAndSignBytes(byte[] DataToSign, RSAParameters Key)
{
    try
    {   
        // Create a new instance of RSACryptoServiceProvider using the 
        // key from RSAParameters.  
        RSACryptoServiceProvider RSAalg = new RSACryptoServiceProvider();

        RSAalg.ImportParameters(Key);

        // Hash and sign the data. Pass a new instance of SHA1CryptoServiceProvider
        // to specify the use of SHA1 for hashing.
        return RSAalg.SignData(DataToSign, new SHA1CryptoServiceProvider());
    }
    catch(CryptographicException e)
    {
        Console.WriteLine(e.Message);

        return null;
    }
}
```

## Verify

```csharp
public static bool VerifyData(string originalMessage, string signedMessage, RSAParameters publicKey)
{
    bool success = false;
    using (var rsa = new RSACryptoServiceProvider())
    {
        var encoder = new UTF8Encoding();
        byte[] bytesToVerify = encoder.GetBytes(originalMessage);
        byte[] signedBytes = Convert.FromBase64String(signedMessage);
        try
        {
            rsa.ImportParameters(publicKey);

            SHA512Managed Hash = new SHA512Managed();

            byte[] hashedData = Hash.ComputeHash(signedBytes);

            success = rsa.VerifyData(bytesToVerify, CryptoConfig.MapNameToOID("SHA512"), signedBytes);
        }
        catch (CryptographicException e)
        {
            Console.WriteLine(e.Message);
        }
        finally
        {
            rsa.PersistKeyInCsp = false;
        }
    }
    return success;
}
```

```csharp
public static bool VerifySignedHash(byte[] DataToVerify, byte[] SignedData, RSAParameters Key)
{
    try
    {
        // Create a new instance of RSACryptoServiceProvider using the 
        // key from RSAParameters.
        RSACryptoServiceProvider RSAalg = new RSACryptoServiceProvider();

        RSAalg.ImportParameters(Key);

        // Verify the data using the signature.  Pass a new instance of SHA1CryptoServiceProvider
        // to specify the use of SHA1 for hashing.
        return RSAalg.VerifyData(DataToVerify, new SHA1CryptoServiceProvider(), SignedData); 

    }
    catch(CryptographicException e)
    {
        Console.WriteLine(e.Message);

        return false;
    }
}
```

```csharp
void VerifyData(byte[] signature)
{
     byte[] str = ASCIIEncoding.Unicode.GetBytes(plaintext);

     // read the public key 
     public_key = File.ReadAllText("publickey.xml");            

     // compute the hash again, also we can pass it as a parameter
     SHA1Managed sha1hash = new SHA1Managed();
     byte[] hashdata = sha1hash.ComputeHash(str);

     RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
     rsa.FromXmlString(public_key);

     if (rsa.VerifyHash(hashdata, "SHA1", signature))
     {
          MessageBox.Show("Verified");
     }
     else
     {
          MessageBox.Show("Invalid Input");
     }
}
```

## Full program

```csharp
using System;
using System.Security.Cryptography;
using System.Text;
using System.IO;

class RSACSPSample
{
    static void Main()
    {
        try
        {
            ASCIIEncoding ByteConverter = new ASCIIEncoding();

            // Create some bytes to be signed.
            byte[] dataBytes = ByteConverter.GetBytes("Here is some data to sign!");

            // Create a buffer for the memory stream.
            byte[] buffer = new byte[dataBytes.Length];

            // Create a MemoryStream.
            MemoryStream mStream = new MemoryStream(buffer);

            // Write the bytes to the stream and flush it.
            mStream.Write(dataBytes, 0, dataBytes.Length);

            mStream.Flush();

            // Create a new instance of the RSACryptoServiceProvider class 
            // and automatically create a new key-pair.
            RSACryptoServiceProvider RSAalg = new RSACryptoServiceProvider();

            // Export the key information to an RSAParameters object.
            // You must pass true to export the private key for signing.
            // However, you do not need to export the private key
            // for verification.
            RSAParameters Key = RSAalg.ExportParameters(true);

            // Hash and sign the data.
            byte[] signedData = HashAndSignBytes(mStream, Key);


            // Verify the data and display the result to the 
            // console.
            if(VerifySignedHash(dataBytes, signedData, Key))
            {
                Console.WriteLine("The data was verified.");
            }
            else
            {
                Console.WriteLine("The data does not match the signature.");
            } 

            // Close the MemoryStream.
            mStream.Close();

        }
        catch(ArgumentNullException)
        {
            Console.WriteLine("The data was not signed or verified");

        }
    }
    public static byte[] HashAndSignBytes(Stream DataStream, RSAParameters Key)
    {
        try
        { 
            // Reset the current position in the stream to 
            // the beginning of the stream (0). RSACryptoServiceProvider
            // can't verify the data unless the the stream position
            // is set to the starting position of the data.
            DataStream.Position = 0;

            // Create a new instance of RSACryptoServiceProvider using the 
            // key from RSAParameters.  
            RSACryptoServiceProvider RSAalg = new RSACryptoServiceProvider();

            RSAalg.ImportParameters(Key);

            // Hash and sign the data. Pass a new instance of SHA1CryptoServiceProvider
            // to specify the use of SHA1 for hashing.
            return RSAalg.SignData(DataStream, new SHA1CryptoServiceProvider());
        }
        catch(CryptographicException e)
        {
            Console.WriteLine(e.Message);

            return null;
        }
    }

    public static bool VerifySignedHash(byte[] DataToVerify, byte[] SignedData, RSAParameters Key)
    {
        try
        {
            // Create a new instance of RSACryptoServiceProvider using the 
            // key from RSAParameters.
            RSACryptoServiceProvider RSAalg = new RSACryptoServiceProvider();

            RSAalg.ImportParameters(Key);

            // Verify the data using the signature.  Pass a new instance of SHA1CryptoServiceProvider
            // to specify the use of SHA1 for hashing.
            return RSAalg.VerifyData(DataToVerify, new SHA1CryptoServiceProvider(), SignedData); 

        }
        catch(CryptographicException e)
        {
            Console.WriteLine(e.Message);

            return false;
        }
    }
}
```