
# The Screen Capture toolkit

With this project, you can take screenshots of LameStation games! (epic!)

Included in this project is a test game that is already configured to take a screen capture (requires the LameStation SDK to build).

## Usage

### Prepare the LameStation project

Drop the `ScreenCapture` and `FullDuplexSerial` objects into your project.

        OBJ
            cap     : "ScreenCapture"

Get access to the screen buffer.

        VAR
            word    buffer
        PUB Main
            buffer := gfx.Start
            lcd.Start(buffer)

Pass the screen buffer address to the `Capture` method when you wish to take a picture.

        cap.Capture(buffer)

    It's a good idea to find a way to control it, otherwise your
    application will run very slowly and taking pictures will be
    inconvenient. I usually put it behind a button.

        if ctrl.A
            cap.Capture(buffer)}}

### Capture the image

#### Capture using `lscapture`

The easiest way is to use the `lscapture` python tool. Here's how to use it.

Get a list of available ports with `-l`.

    $ lscapture -l
    /dev/ttyUSB0
    /dev/ttyUSB1

Now run `lscapture` with the full port name to start the screen capture server.

    $ lscapture /dev/ttyUSB0
    Listening for capture input on port '/dev/ttyUSB0'...
    Receiving image download!
    Generating pic6.png...

`lscapture` will wait until it receives an image, then quit. You can also quit with `CTRL+C`. It will generate PNG images with the name `pic#.png`, where `#` is an incrementing number, unless you use the `-o` option to specify the output file name.

You can display the image after download with `-d`. It'll look awesome like this!

![](images/pic7.png)

The `-s` option will scale the resulting image to different sizes. The default is `4x`.

    lscapture /dev/ttyUSB0 -s 8

![](images/pic8.png)

For a full help, pass `-h`.

    $ lscapture -h
    usage: lscapture [-h] [-s FACTOR] [-o FILE] [-l] [-d] [PORT]

    Take screenshots of LameStation games! (epic!)

    positional arguments:
      PORT                  Port to capture image

    optional arguments:
      -h, --help            show this help message and exit
      -s FACTOR, --scale FACTOR
                            Integer factor by which to scale the output image
                            (default: 4)
      -o FILE, --out FILE   Specify output file name
      -l, --list            List ports available to capture from
      -d, --display         Show resulting image

#### Capture From Serial Terminal

If, for whatever reason, you don't have access to Python, or maybe you're too cool to use the included `lscapture` tool to capture the images, you can still capture the images by hand using a serial terminal and a little internet.

Capture the BASE64-encoded output from the serial terminal (it's 78 lines long)

![](images/16089172.png)

Copy the output to [this tool](http://www.motobit.com/util/base64-decoder-encoder.asp) .

![](images/16089169.png)

Select " **decode** the data **from a Base64** string (base64 decoding)"

![](images/16089170.png)

Select "export to a binary file" with a `.bmp` extension.

![](images/16089167.png)

Click ![](images/16089168.png) to export the image to

bitmap. It will be very small.

![](images/16089171.bmp)

Apply the following shell script to the saved images to enlarge and convert to `PNG` . You will need the **[convert](http://www.imagemagick.org/script/convert.php)** program from [ImageMagick](http://www.imagemagick.org/) installed.

    for f in *.bmp; do g=`echo $f | cut -d'.' -f 1`; convert $f -scale 512x256 $g.png ; done

Now your image should be awesomely awesome, and big enough for alias-free display on a website.

![](images/16089173.png)

