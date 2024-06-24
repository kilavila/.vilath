# Vilath - Password manager
CLI password manager to organize and keep your passwords safe.

### Getting started
Clone this directory and move script into bin, set up GnuPG RSA private and public keys, then initialize the password store.
```
$ cd ~
$ git clone https://github.com/kilavila/.vilath.git
$ sudo cp ~/.vilath/.bin/vilath /usr/bin/vilath
$ gpg --full-generate-key
$ vilath init my-gpg-id@example.com
```

### Usage
Generate, list, view and edit password store.

```
$ vilath generate web/mail
$ vilath list
$ vilath view web/mail
$ vilath edit web/mail
```

### Help
To view more examples and flags etc.

```
$ vilath --help
```
