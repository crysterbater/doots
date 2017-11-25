DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -a IMAGES=(
    "https://vignette1.wikia.nocookie.net/glee/images/b/bf/-Mahou-Shoujo-Madoka-Magica-Kaname-Madoka-Anime-Akemi-Homura-Simple-Background-Anime-Girls-Fresh-New-Hd-Wallpaper--.jpg/revision/latest?cb=20131221162943"
    "https://static.zerochan.net/Akuma.Homura.full.1868960.jpg"
    "https://i.pinimg.com/originals/3b/5a/1a/3b5a1a5ea086ec3eb245fba4303bc884.jpg"
    "http://www.wallpaperup.com/wallpaper/download/187313"
    "https://orig15.deviantart.net/a195/f/2011/145/d/f/homura_wallpaper_revisited_by_ch1zuruu-d3h6znz.jpg"
    "https://images2.alphacoders.com/110/thumb-1920-110030.jpg"
    "https://images7.alphacoders.com/332/332329.jpg"
    "http://www.wallpaperup.com/wallpaper/download/55301"
    "http://i.imgur.com/N9sq9.jpg"
)

FILECOUNT=$(ls -l "$DIR/backgrounds/"* | wc -l)

if [ $FILECOUNT -eq ${#IMAGES[@]} ]; then
    #The number of files equals the number of URLs
    #So chances are all the backgrounds are there and downloaded
    #So get outta here
    exit
fi

#Redownload everything
mkdir -p "$DIR/backgrounds"
rm "$DIR/backgrounds/"*

i=0
for url in "${IMAGES[@]}"; do
    notify-send "Downloading background $((i + 1))/${#IMAGES[@]}"
    echo "Downloading: " $url
    curl "$url" -o "$DIR/backgrounds/$i.jpg"

    ((i++))
done

notify-send "Finished downloading backgrounds"

