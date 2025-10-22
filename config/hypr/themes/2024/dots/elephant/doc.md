# Elephant
A service providing various datasources which can be triggered to perform actions.

Run `elephant -h` to get an overview of the available commandline flags and actions.
## Elephant Configuration
`~/.config/elephant/Elephant.toml`
#### ElephantConfig
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|argument_delimiter|string|#|global delimiter for arguments|
|auto_detect_launch_prefix|bool|true|automatically detects uwsm, app2unit or systemd-run|
|overload_local_env|bool|false|overloads the local env|

## Provider Configuration
### Elephant Archlinux Packages

Find, install and delete packages. Including AUR.

#### Features

- find official packages
- find AUR packages
- install packages
- list all exclusively installed packages
- remove packages
- clear all done items

#### Requirements

- `yay` or `paru` for AUR

#### Usage

In order to only display installed packages, prefix your query with `i:` (default).


`~/.config/elephant/archlinuxpkgs.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|refresh_interval|int|60|refresh database every X minutes. 0 disables the automatic refresh and refreshing requires an elephant restart.|
|installed_prefix|string|i:|prefix to use to show only explicitly installed packages|

### Elephant Clipboard

Store clipboard history.

#### Features

- saves images and text history
- filter to show images only
- edit saved content

#### Requirements

- `wl-clipboard`


`~/.config/elephant/clipboard.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|max_items|int|100|max amount of clipboard history items|
|image_editor_cmd|string||editor to use for images. use '%FILE%' as placeholder for file path.|
|text_editor_cmd|string||editor to use for text, otherwise default for mimetype. use '%FILE%' as placeholder for file path.|

### Elephant Desktop Applications

Run installed desktop applications.

#### Features

- history
- pin items
- alias items
- auto-detect `uwsm`/`app2unit`


`~/.config/elephant/desktopapplications.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|launch_prefix|string||overrides the default app2unit or uwsm prefix, if set.|
|locale|string||to override systems locale|
|action_min_score|int|20|min score for actions to be shown|
|show_actions|bool|false|include application actions, f.e. 'New Private Window' for Firefox|
|show_generic|bool|true|include generic info when show_actions is true|
|show_actions_without_query|bool|false|show application actions, if the search query is empty|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|
|only_search_title|bool|false|ignore keywords, comments etc from desktop file when searching|
|icon_placeholder|string|applications-other|placeholder icon for apps without icon|
|aliases|map[string]string||setup aliases for applications. Matched aliases will always be placed on top of the list. Example: 'ffp' => '<identifier>'. Check elephant log output when activating an item to get its identifier.|

### Elephant Menus

Create custom menus.

#### Features

- seamless menus
- use dmenu's as submenus
- drag&drop files into other programs
- copy file/path

#### How to create a menu

Default location for menu definitions is `~/.config/elephant/menus/`. Simply place a file in there, see examples below.

#### Examples

```toml
name = "other"
name_pretty = "Other"
icon = "applications-other"
global_search = true

[[entries]]
text = "Volume"
async = "echo $(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
icon = "audio-volume-high"
action = "wpctl set-volume @DEFAULT_AUDIO_SINK@ %RESULT%"

[[entries]]
text = "System"
async = """echo $(echo "Memory: $(free -h | awk '/^Mem:/ {printf "%s/%s", $3, $2}') | CPU: $(top -bn1 | grep 'Cpu(s)' | awk '{printf "%.1f%%", 100 - $8}')")"""
icon = "computer"
action = ""

[[entries]]
text = "Today"
async = """echo $(date "+%H:%M - %d.%m. %A - KW %V")"""
icon = "clock"
action = ""
```

```toml
name = "screenshots"
name_pretty = "Screenshots"
icon = "camera-photo"
global_search = true

[[entries]]
text = "View"
action = "vimiv ~/Pictures/"

[[entries]]
text = "Annotate"
action = "wl-paste | satty -f -"

[[entries]]
text = "Toggle Record"
action = "record"

[[entries]]
text = "Screenshot Region"
action = "wayfreeze --after-freeze-cmd 'IMG=~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png && grim -g \"$(slurp)\" $IMG && wl-copy < $IMG; killall wayfreeze'"

[[entries]]
text = "Screenshot Window"
action = "wayfreeze --after-freeze-cmd 'IMG=~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png && grim $IMG && wl-copy < $IMG; killall wayfreeze'"

[[entries]]
text = "other menu"
submenu = "other"
```


`~/.config/elephant/menus.toml`
#### MenuConfig
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|paths|[]string||additional paths to check for menu definitions.|

`~/.config/elephant/menus.toml`
#### Menu
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|name|string||name of the menu|
|name_pretty|string||prettier name you usually want to display to the user.|
|description|string||used as a subtext|
|icon|string||default icon|
|action|string||default action|
|global_search|bool||sets if entries in this menu should be searchable globally without being in the menu|
|entries|[]common.Entry||menu items|
|terminal|bool||execute action in terminal or not|
|keywords|[]string||searchable keywords|
|fixed_order|bool||don't sort entries alphabetically|
|history|bool||make use of history for sorting|
|history_when_empty|bool||consider history when query is empty|
|min_score|int32|depends on provider|minimum score for items to be displayed|
#### Entry
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|text|string||text for entry|
|async|string||if the text should be updated asynchronously based on the action|
|subtext|string||sub text for entry|
|value|string||value to be used for the action, defaults to the text if empty|
|action|string||action to run|
|terminal|bool||runs action in terminal if true|
|icon|string||icon for entry|
|submenu|string||submenu to open, if has prefix 'dmenu:' it'll launch that dmenu|
|preview|string||filepath for the preview|
|keywords|[]string||searchable keywords|


### Elephant Providerlist

Lists all installed providers and configured menus.


`~/.config/elephant/providerlist.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hidden|[]string|<empty>|hidden providers|

### Elephant Runner

Execute everything installed in your $PATH.

#### Features

- finds all executables items in $PATH
- ... or define an explicit list yourself


`~/.config/elephant/runner.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|
|explicits|[]main.ExplicitItem||use this explicit list, instead of searching $PATH|
#### ExplicitItem
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|exec|string||executable/command to run|
|alias|string||alias|


### Elephant Symbols

Search for emojis and symbols

#### Requirements

- `wl-clipboard`


#### Possible locales
af,ak,am,ar,ar_SA,as,ast,az,be,bew,bg,bgn,blo,bn,br,bs,ca,ca_ES,ca_ES_VALENCIA,ccp,ceb,chr,ckb,cs,cv,cy,da,de,de_CH,doi,dsb,el,en,en_001,en_AU,en_CA,en_GB,en_IN,es,es_419,es_MX,es_US,et,eu,fa,ff,ff_Adlm,fi,fil,fo,fr,fr_CA,frr,ga,gd,gl,gu,ha,ha_NE,he,hi,hi_Latn,hr,hsb,hu,hy,ia,id,ig,is,it,ja,jv,ka,kab,kk,kk_Arab,kl,km,kn,ko,kok,ku,ky,lb,lij,lo,lt,lv,mai,mi,mk,ml,mn,mni,mr,ms,mt,my,ne,nl,nn,no,nso,oc,om,or,pa,pa_Arab,pap,pcm,pl,ps,pt,pt_PT,qu,quc,rhg,rm,ro,root,ru,rw,sa,sat,sc,sd,si,sk,sl,so,sq,sr,sr_Cyrl,sr_Cyrl_BA,sr_Latn,sr_Latn_BA,su,sv,sw,sw_KE,ta,te,tg,th,ti,tk,tn,to,tr,tt,ug,uk,ur,uz,vec,vi,wo,xh,yo,yo_BJ,yue,yue_Hans,zh,zh_Hant,zh_Hant_HK,zu,

`~/.config/elephant/symbols.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|locale|string|en|locale to use for symbols|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|

### Elephant Unicode

Search for unicode symbols

#### Requirements

- `wl-clipboard`


`~/.config/elephant/unicode.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|locale|string|en|locale to use for symbols|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|

### Elephant Websearch

Search the web with custom defined search engines.

#### Example entry

```toml
[[entries]]
default = true
name = "Google"
url = "https://www.google.com/search?q=%TERM%"
```


`~/.config/elephant/websearch.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|entries|[]main.Entry||entries|
|max_global_items_to_display|int|1|will only show the global websearch entry if there are at most X results.|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|
#### Entry
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|name|string||name of the entry|
|default|bool||entry to display when querying multiple providers|
|prefix|string||prefix to actively trigger this entry|
|url|string||url, example: 'https://www.google.com/search?q=%TERM%'|
|icon|string||icon to display, fallsback to global|


