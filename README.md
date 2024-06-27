# Vilath - Password manager
CLI password manager to organize and keep your passwords safe.<br>
Uses GnuPG for encryption and generates strong, 32-character length passwords.<br>

---

### Update
> Added dmenu for quick copying passwords.

<details>
Download and install dmenu: <a href="https://tools.suckless.org/dmenu/" target="_blank">https://tools.suckless.org/dmenu/</a>

```
$ vilath menu
```
</details>

---

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

```sh
$ vilath generate web/mail
$ vilath list
# view hides password by default
# use -a to view entire password file
# or -c to copy password to clipboard
# f.ex: vilath view web/mail -a
$ vilath view web/mail
$ vilath edit web/mail
```

### Help
To view more examples and flags etc.

```
$ vilath --help
```
