import gab.opencv.*;
import processing.video.*;
PImage src;
OpenCV opencv;
Capture video;
void setup_image()
{
    video = new Capture(this, 640, 480);
    video.start();

    colorMode(RGB, 255, 255, 255, 100);
    opencv = new OpenCV(this, 640, 480);
}
void draw_image_processing()
{
    if (video.available()) {
        video.read();
    }
}

void show_snapshot() {
    opencv.loadImage(video);
    opencv.useColor();
    src = opencv.getSnapshot();
    image(src, 0, 0, src.width/2, src.height/2);
}

 // Load the new frame of our camera in to OpenCV


