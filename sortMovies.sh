ENG4KMOVIEDIR="/expanse/Media/Movies4keng"
ENGHDMOVIEDIR="/expanse/Media/MoviesHDeng"
GER4KMOVIEDIR="/expanse/Media/Movies4kger"
GERHDMOVIEDIR="/expanse/Media/MoviesHDger"

ENGMOVIEDIR="/expanse/Media/Movies-English"
GERMOVIEDIR="/expanse/Media/Movies-German"

find "$ENG4KMOVIEDIR" -type f -name '*.mp4' -o -iname '*.mkv' -o -iname '*.avi' | while read -r filename; do
  if ffprobe -v quiet -of csv -select_streams a -show_entries stream_tags=language "$filename" | grep -q "ger"; then
    newfilename=${filename/#${ENG4KMOVIEDIR}/${GER4KMOVIEDIR}}
    mkdir -p "$(dirname "$newfilename")"
    cp -l "$filename" "$newfilename"
  fi
done

find "$ENGHDMOVIEDIR" -type f -name '*.mp4' -o -iname '*.mkv' -o -iname '*.avi' | while read -r filename; do
  if ffprobe -v quiet -of csv -select_streams a -show_entries stream_tags=language "$filename" | grep -q "ger"; then
    newfilename=${filename/#${ENGHDMOVIEDIR}/${GERHDMOVIEDIR}}
    mkdir -p "$(dirname "$newfilename")"
    cp -l "$filename" "$newfilename"
  fi
done

cp -lr "$ENG4KMOVIEDIR"/* "$ENGMOVIEDIR"
cp -lr "$ENGHDMOVIEDIR"/* "$ENGMOVIEDIR"
cp -lr "$GER4KMOVIEDIR"/* "$GERMOVIEDIR"
cp -lr "$GERHDMOVIEDIR"/* "$GERMOVIEDIR"
