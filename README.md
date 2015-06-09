LUA cryptography
lcrypt

lcrypt is a basic cryptographic toolset for Lua. It is written in C and should be reasonable cross-platform. It was written to provide the basis for ssh capabilities for lua.
Dependencies

    Lua
    libTomCrypt and libTomMath available at http://libtom.org/

Download

lcrypt.tgz
API:

See rsa.lua for an example implementing RSA.

lcrypt =
{
  function tohex(binary_data, spacer, prepend)
    if not spacer then spacer = '' end
    if not prepend then prepend = '' end
    --[[
      This function returns a hexadecimal representation of binary data.
      spacer is text inserted between each octet.
      prepend is text inserted before the first octet.
      lcrypt.tohex('jello', ', 0x', '0x') returns "0x6A, 0x65, 0x6C, 0x6C, 0x6F".
    ]]
  end,
  function fromhex(hex_string)
    --[[
      This function decodes hex data and returns binary data.
      Non-hex digits are ignored.  Be careful of 0x encoded hex, as 0 is a hex digit, but x is not.
    ]]
  end,
  function compress(data)
    --[[
      This function compress data with zlib.
    ]]
  end,
  function uncompress(data)
    --[[
      This function uncompress data with zlib.
    ]]
  end,
  function base64_encode(data)
    --[[
      This function base 64 encodes data.
    ]]
  end,
  function base64_decode(data)
    --[[
      This function base 64 decodes data.
    ]]
  end,
  function sleep(seconds)
    --[[
      This function sleeps.
      seconds is the seconds to sleep.  This is a floating point value, thus you can sleep for .5 seconds.
    ]]
  end,
  function time()
    --[[
      This function returns the time in seconds from the start of the unix epoch with fractional seconds.
    ]]
  end,
  function random(bytes)
    --[[
      This function returns bytes bytes of random data.
      This should be based on /dev/urandom, /dev/random, or some hardware random source.
    ]]
  end,
  function xor(a, b)
    --[[
      This function returns a xor b.
      a and b are strings.
    ]]
  end,
  function tcsetattr(file, iflag, oflag, cflag, lflag)
    --[[
      See manpage for tcsetattr.
      This function is likely to be replaced with something more cross-platform.
    ]]
  end,
  iflag =
  {
    IGNBRK=IGNBRK, BRKINT=BRKINT, IGNPAR=IGNPAR, PARMRK=PARMRK, INPCK=INPCK, ISTRIP=ISTRIP,
    INLCR=INLCR, IGNCR=IGNCR, ICRNL=ICRNL, IXON=IXON, IXANY=IXANY, IXOFF=IXOFF
  },
  oflag =
  {
    OLCUC=OLCUC, OFILL=OFILL, OFDEL=OFDEL, NLDLY=NLDLY, CRDLY=CRDLY, TABDLY=TABDLY,
    BSDLY=BSDLY, VTDLY=VTDLY, FFDLY=FFDLY, OPOST=OPOST, ONLCR=ONLCR, OCRNL=OCRNL,
    ONOCR=ONOCR, ONLRET=ONLRET
  },
  cflag =
  {
    CS5=CS5, CS6=CS6, CS7=CS7, CS8=CS8, CSTOPB=CSTOPB, CREAD=CREAD, PARENB=PARENB,
    PARODD=PARODD, HUPCL=HUPCL, CLOCAL=CLOCAL
  },
  lflag =
  {
    ISIG=ISIG, ICANON=ICANON, ECHO=ECHO, ECHOE=ECHOE, ECHOK=ECHOK, ECHONL=ECHONL, NOFLSH=NOFLSH,
    TOSTOP=TOSTOP, IEXTEN=IEXTEN
  },
  function flag_add(flags, flag)
    --[[
      This function adds the flag to the existing flags.
      return flags | flag
    ]]
  end,
  function flag_remove(flags, flag)
    --[[
      This function removes the flag to the existing flags.
      return flags & ~flag
    ]]
  end,
  function spawn(command)
    --[[
      This function swawns command and returns a read/write handle.
    ]]
  end,
  function bget(binary_data, bits_to_skip, ...)
    --[[
      This function unpacks data from a binary string.
      ... represents zero or more type,length pairs.
      type may be BSKIP, BSTR, BMSB, BLSB, BLE, BSMSB, BSLSB, BLE, BMO, or BSMO.
      length is in bits.
      All types except BSKIP return a value, depending on its type.
    ]]
  end,
  function bput(...)
    --[[
      This function packs data into a binary string.
      ... represents length, type, value triples.
      type may be BSKIP, BSTR, BMSB, BLSB, BLE, BSMSB, BSLSB, BLE, BMO, or BSMO.
      length is in bits.
      value depends on type.
    ]]
  end,
  BSKIP=BSKIP, -- skip bits, no value returned.
  BSTR=BSTR,   -- string type.
  BMSB=BMSB,   -- unsigned integer most significant bit first.
  BLSB=BLSB,   -- unsigned integer least significant bit first.
  BLE=BLE,     -- unsigned integer little endian, length must be a multiple of 8 bits.
  BSMSB=BSMSB, -- signed integer most significant bit first.
  BSLSB=BSLSB, -- signed integer least significant bit first.
  BSLE=BSLE,   -- signed integer little endian, length must be a multiple of 8 bits.
  BMO=BMO,     -- unsigned integer, machine order, length must be a multiple of 8 bits.
  BSMO=BSMO,   -- signed integer, machine order, length must be a multiple of 8 bits.
  ciphers =
  {
    AES=AES, ANUBIS=ANUBIS, BLOWFISH=BLOWFISH, CAST5=CAST5, DES=DES, DES3=DES3, KASUMI=KASUMI,
    KHAZAD=KHAZAD, KSEED=KSEED, NOEKEON=NOEKEON, RC2=RC2, RC5=RC5, RC6=RC6, SAFERP=SAFERP,
    SKIPJACK=SKIPJACK, TWOFISH=TWOFISH, XTEA=XTEA
  },
  cipher_modes =
  {
    ECB=ECB, CBC=CBC, CFB=CFB, CTR=CTR, F8=F8, LRW=LRW, OFB=OFB
  },
  function key(cipher, mode, key, extra)
    --[[
      This function returns a key type.
      cipher is a value from lcrypt.ciphers.
      mode is a value from lcrypt.cipher_modes.
      key is truncated to the nearest key size equal to or smaller than the length of key.
      extra is any extra parameters the cipher mode may need, for example IV.

      The key type has the following attributes:
        block_size
        key_size
        cipher
        mode
      The key type has the following functions:
        encrypt(data)
        decrypt(data)
      The key type supports the following operators:
        #key returns the key_size of the key
    ]]
  end,
  hashes =
  {
    md2=MD2, md4=MD4, md5=MD5, rmd128=RMD128, rmd160=RMD160, rmd256=RMD256, rmd320=RMD320,
    sha1=SHA1, sha224=SHA224, sha256=SHA256, sha384=SHA384, sha512=SHA512, tiger=TIGER,
    whirlpool=WHIRLPOOL
  },
  hash_modes =
  {
    hash=HASH, hmac=HMAC, omac=OMAC
  },
  function hash(hash, mode, data, extra)
    --[[
      This function returns a hash type.
      hash is a value from lcrypt.hashes, or a value from lcrypt.ciphers if mode is lcrypt.hash_modes.omac.
        The name of the hash or cipher may be used in place of the value.
      mode is a value from lcrypt.hash_modes.
        The name of the mode may be used in place of the value.
      extra is any extra parameters the hash mode may need, for example key.
      The hash type has the following attributes:
        size
        hash
        mode
      The hash type has the following functions:
        add(data)
        done(data)
      The hash type supports the following operators:
        #hash
    ]]
  end,
  function bigint(value)
    --[[
      This function returns a bigint type.
      The bigint type has the following attributes:
        bits
      The bigint type has the following functions:
        a:isprime()
        c = a:add(b)
        c = a:sub(b)
        c = a:mul(b)
        c = a:div(b)
        c = a:mod(b)
        c = a:gcd(b)
        c = a:lcm(b)
        c = a:invmod(n)
        c = a:exptmod(b, n)
      The bigint type has the following operators defined:
        a + b
        a - b
        a * b
        a / b
        a + -b
        a == b
        a < b
        a <= b
        a > b
        a >= b
        #a
      tostring(a) is also supported.
    ]]
  end
}
