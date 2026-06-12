import processing.serial.*;

Serial myPort;

String state = "SAFE";
int distance = 150;

float radarAngle = 0;

void setup() {

  fullScreen();

  smooth();

  myPort = new Serial(
    this,
    "/dev/cu.usbmodem21401",
    9600
  );

  myPort.bufferUntil('\n');
}

void draw() {

  background(8,10,15);

  drawRadar();

  drawHeader();

  drawDistance();

  drawStatus();

  drawBars();

  radarAngle += 0.02;
}

void drawHeader() {

  fill(255);

  textAlign(CENTER,CENTER);

  textSize(height*0.04);

  text("SMART BIKE SAFETY SYSTEM",
       width/2,
       height*0.08);
}

void drawRadar() {

  pushMatrix();

  translate(width/2,height*0.45);

  noFill();

  stroke(40);

  strokeWeight(2);

  ellipse(0,0,500,500);
  ellipse(0,0,400,400);
  ellipse(0,0,300,300);
  ellipse(0,0,200,200);

  stroke(50);

  line(-250,0,250,0);
  line(0,-250,0,250);

  float x = cos(radarAngle)*250;
  float y = sin(radarAngle)*250;

  stroke(0,255,180);

  strokeWeight(4);

  line(0,0,x,y);

  popMatrix();
}

void drawDistance() {

  fill(255);

  textAlign(CENTER,CENTER);

  textSize(height*0.12);

  text(distance + " cm",
       width/2,
       height*0.43);
}

void drawStatus() {

  color c;

  if(state.equals("SAFE")){

    c = color(0,255,100);

  } else if(state.equals("WARNING")){

    c = color(255,220,0);

  } else {

    c = color(255,50,50);
  }

  fill(c);

  noStroke();

  ellipse(width/2,
          height*0.62,
          80,
          80);

  fill(255);

  textSize(height*0.05);

  text(state,
       width/2,
       height*0.72);
}

void drawBars() {

  float level;

  if(distance > 100){

    level = 0.3;

  } else if(distance > 50){

    level = 0.65;

  } else {

    level = 1.0;
  }

  int bars = int(level * 10);

  float barWidth = 40;
  float spacing = 15;

  float totalWidth =
    bars * barWidth +
    (bars-1) * spacing;

  float startX =
    width/2 - totalWidth/2;

  for(int i=0;i<bars;i++){

    float h =
      map(i,
          0,
          9,
          40,
          200);

    if(state.equals("SAFE")){

      fill(0,255,100);

    } else if(state.equals("WARNING")){

      fill(255,220,0);

    } else {

      fill(255,50,50);
    }

    rect(
      startX + i*(barWidth+spacing),
      height*0.9 - h,
      barWidth,
      h,
      10
    );
  }
}

void serialEvent(Serial myPort) {

  String data =
    myPort.readStringUntil('\n');

  if(data != null){

    data = trim(data);

    println(data);

    String[] values =
      split(data, ',');

    if(values.length == 2){

      state = values[0];

      distance =
        int(values[1]);
    }
  }
}
