# jeff-arch
## Create Arch ISO or Use Image

Download ArchISO from <https://archlinux.org/download/> and use these to flash to usb drive [Etcher](https://www.balena.io/etcher/), [Ventoy](https://www.ventoy.net/en/index.html), or [Rufus](https://rufus.ie/en/)



## Boot Arch ISO

```
pacman -Sy git
git clone https://github.com/Jeffrey2081/jeff-arch
cd jeff-arch
chmod +x ./install.sh
./install.sh
```


### Connecting to wifi In the post
Launch the terminal
And type
```
 nmcli device wifi connect <AP name> password <password>
 `````
