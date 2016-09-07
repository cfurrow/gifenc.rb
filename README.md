# gifenc.rb
A ruby version of the gifenc shell script created by [pkh.me](http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html#usage)

## Setup
- Be sure to have ffmpeg installed (>2.6). The easiest way to do that on OSX is via `brew install ffmpeg` if you have homebrew installed.

## How to install
Copy the gifenc.rb file to your scripts directory, or create a new one in your HOME directory: `~/scripts`.

Once there, make sure your scripts directory is in your path by editing `~/.bashrc` or `~/.zshrc` (or whatever shell rc file you are using) and add this:

`export PATH="~/scripts:$PATH"`

This will add your scripts directory as the first searchable directory in your PATH environment variable.

## How to use

`$ gifenc.rb -i input.mov -o output.gif -s=640`

This will take input.mov and convert it to a gif called output.gif and set its width to 640px. It will scale the height based on the aspect ratio of the input movie.

If you want to see all the options for `gifenc.rb`, just type `gifenc.rb` into your terminal to see the help screen.

```
$ gifenc.rb
Usage: gifenc.rb [options]
    -i, --input=MOVIE                Input movie
    -o, --output=GIF                 Output gif
    -s, --start_time=START_TIME      Start time (in seconds, or hh:mm:ss)
    -t, --time=DURATION              Duration (in seconds, or hh:mm:ss)
        --scale=SCALE                Scale in pixels (default is 320)
        --fps=FPS                    FPS (defaults to 15fps)
    -h, -?, --help                   This message
```