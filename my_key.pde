import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioPlayer song;
BeatDetect beat;
float bww;
float bhh;
float eRadius = 20;
void setup_music()
{
    minim = new Minim(this);
    song = minim.loadFile("tw014b.mp3");
    beat = new BeatDetect();
    rectMode(CENTER);
    bww = box_w;
    bhh = box_h;
}
