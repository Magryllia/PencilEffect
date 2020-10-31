PImage img = new PImage();
float[][] grad = new float[1600][1066];
boolean state = true;

void setup()
{
  size(1600, 1066);
  //https://www.pakutaso.com/20200714204post-27526.html
  img = loadImage("tomcat1582_TP_V.jpg");
  background(#F2F2F2);
  noStroke();
  for (int x = 1; x < width; x++) {
    for (int y = 1; y < height; y++) {
      float gradx = gray(img.get(x+1, y)) - gray(img.get(x-1, y));
      float grady = gray(img.get(x, y+1)) - gray(img.get(x, y-1));
      //println(x,y);
      grad[x][y] = sqrt(gradx*gradx + grady*grady)/255.;
    }
  }
}

void draw() {
  
  rectMode(CENTER);
  if (state) //マウスクリックで再生/停止
  {
    float len = 30; //ストローク長さ
    float border = 50; //描画領域の縁
    for (int i = 0; i<1000; i++)
    {
      int x = round(random(border, width-border));
      int y = round(random(border, height-border));
      color c = img.get(x, y);
      
      //rgbの比を算出
      float rR = red(c)/(red(c) + green(c) + blue(c));
      float rG = green(c)/(red(c) + green(c) + blue(c));
      float rB = blue(c)/(red(c) + green(c) + blue(c));
      
      float rnd = random(1);
      color f;
      //rgbの比に応じてランダムでfill色を決定
      if (rnd <= rR)
      {
        f = color(red(c),0,0);
      } else if (rnd <=(rR+rG))
      {
        f = color(0, green(c), 07);
      } else
      {
        f = color(0, 0, blue(c));
      }
      fill(f, (255-gray(c))*0.05);
      
      //輝度に応じてストロークを回転
      float rot = map(gray(c), 0, 255, PI/2, PI);
      pushMatrix();
      translate(x, y);
      rotate(rot);
      rect(0, 0, len-(grad[x][y] * len), 1);
      popMatrix();
    }
  }
}

void keyPressed()
{
  switch(key)
  {
    case 's':
      save(TimeStamp() + ".png");
  }
}

void mousePressed()
{
  state = !state;
}

//グレースケールへ変換
float gray(color c)
{
  return 0.3 * red(c) + 0.59 * green(c) + 0.11 * green(c);
}
