import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*; 
import org.jbox2d.common.*; 
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;
ArrayList<Boundary> boundaries; 
ArrayList<Box> boxes;
float nnww;
int bw;
float box_w, box_h;
float goal_y;
float start_y;
float []goal_x = new float[3];
int state = 0; 
float rectW;
int start_index = 200;
Table a;
float []btime; 
int []btype;
int index = 0; 
float my_timer;
float falling_time;
int score;

void keyPressed(){
    if (key == 'p') {
        state = 1;
    }
}

void setup() {
    size(480, 640, P3D);
    setup_music(); 
    read_beat_data(); 
    setup_image();
    textFont(createFont("Helvetica", 16)); 
    textAlign(CENTER);
    setup_game();
    index = 0; my_timer = 0.0;
    frameRate(30); 
}
void setup_game() {
    box_w = 42;
    box_h = 20;
    bw = 84;//boundary width
    setup_box2d();
    nnww = (width - 4*bw)/3.0;
    goal_y = height - 30; start_y = 30;
    goal_x[0] = bw + nnww/2.0;
    goal_x[1] = 2*bw + nnww + nnww/2.0;

    goal_x[2] = width - bw - nnww/2.0; 
}
void draw() {
    background(0); 
    stroke(255); 
    box2d.step();
    draw_image_processing();
    draw_my_game();

    if(state == 0) {
        text("Press p-key to start a game!", width/2, height/2); 
    }
    else if(state == 1) { 
        //play game
        if(abs(my_timer - falling_time - btime[index]) < 0.01) {
            add_box(btype[index]);
            index++; 
        }
        if (index >= a.getRowCount() ) { index = 0; } 
        draw_my_game();
        song.play();
        text(my_timer, width/2, 20);
        text("score: " + score, width/1.2, 20);
        my_timer = my_timer + 1.0/60.0; 
    }
}

void draw_my_game() {
    // Display all the boundaries
    for (Boundary wall: boundaries) {
        wall.display(); 
    }
    // Display all the boxes 
    for (Box b: boxes) {
        b.display();
        b.display_goal(); 
    }
    for (int i = boxes.size()-1; i >= 0; i--) {
        Box b = boxes.get(i);
        if (b.compare()) { boxes.remove(i); }
        if (b.done()) { boxes.remove(i); } 
    }
    stroke(255, 128);
    line(0, goal_y, width, goal_y); 
    line(0, start_y, width, start_y);
    fill(255, 200);
    for(int i = 0; i < 3; i++){
        rect(goal_x[i], goal_y, box_w, box_h);
    }
}
