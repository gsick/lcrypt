require("lcrypt")

local txt = "0123456789abcdef0123456789abcdef"
key = lcrypt.key("aes", "ecb", "0123456789abcdef")
out = key:encrypt(txt)
check = key:decrypt(out)

assert(check == txt)

my_key = "dsdkmkPOJ64JG546dfsgsd=mlk12vvcccccccbcv"

local pwd = "my_big_password"

hash = lcrypt.hash("sha512", "hmac", pwd, my_key)
pwd_hashed = hash:done()

hash2 = lcrypt.hash("sha512", "hmac", pwd, my_key)
pwd_hashed2 = hash2:done()

assert(pwd_hashed == pwd_hashed2)
