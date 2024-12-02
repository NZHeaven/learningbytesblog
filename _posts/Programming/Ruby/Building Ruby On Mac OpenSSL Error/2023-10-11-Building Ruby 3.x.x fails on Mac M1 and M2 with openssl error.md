---
title: "Building ruby 3.x.x fails on Mac M1/M2 with openSSL error"
date: 2023-10-11 8:25:00 +1200
categories: [Programming, Ruby]
tags: [ruby, programming, mac]
---

When attempting to build Ruby on a Mac M1/M2, you may encounter an openSSL error that is caused by a conflict with OpenSSH.

```ruby
ruby-install ruby 3.x.x
```

```bash
./openssl_missing.h:195:11: warning: 'TS_VERIFY_CTS_set_certs' macro redefined [-Wmacro-redefined]
#  define TS_VERIFY_CTS_set_certs(ctx, crts) ((ctx)->certs=(crts))
          ^
/opt/homebrew/Cellar/openssl@3/3.1.3/include/openssl/ts.h:426:11: note: previous definition is here
#  define TS_VERIFY_CTS_set_certs(ctx, cert) TS_VERIFY_CTX_set_certs(ctx,cert)
          ^
ossl_ts.c:829:5: error: incomplete definition of type 'struct TS_verify_ctx'
    TS_VERIFY_CTX_set_certs(ctx, x509inter);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./openssl_missing.h:215:46: note: expanded from macro 'TS_VERIFY_CTX_set_certs'
#  define TS_VERIFY_CTX_set_certs(ctx, crts) TS_VERIFY_CTS_set_certs(ctx, crts)
                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./openssl_missing.h:195:52: note: expanded from macro 'TS_VERIFY_CTS_set_certs'
#  define TS_VERIFY_CTS_set_certs(ctx, crts) ((ctx)->certs=(crts))
                                              ~~~~~^
/opt/homebrew/Cellar/openssl@3/3.1.3/include/openssl/ts.h:407:16: note: forward declaration of 'struct TS_verify_ctx'
typedef struct TS_verify_ctx TS_VERIFY_CTX;
               ^
1 warning and 1 error generated. 
make[2]: *** [ossl_ts.o] Error 1
make[1]: *** [ext/openssl/all] Error 2
make: *** [build-ext] Error 2
!!! Compiling ruby 3.1.3 failed!
```

To resolve this issue, you can run the following command to update your environmental variables that are referenced when building Ruby.

```bash
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
```

**NOTE:** This assumes that OpenSSL@1.1 is installed via homebrew. If you don't already have it installed, you can use the below command to install it with homebrew, alternatively you can modify the paths above to match your installed version of openSSL.

```bash
brew install openssl@1.1
```