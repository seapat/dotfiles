# TODO

# rename file extensions
#ls *.png | get name | path parse | each {|$it| mv ($it.stem + . + $it.extension) ($it.stem + ".jpg") }