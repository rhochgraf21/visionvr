import ketai.camera.*;

KetaiCamera cam;
PImage procc;
int dim;
color cp, ch;

void setup()
{
  fullScreen();
  orientation(LANDSCAPE);
  colorMode(HSB, 360, 100, 100);
  cam = new KetaiCamera(this, 640, 480, 19);
  dim = cam.width * cam.height;
  imageMode(CORNER);
  cam.manualSettings();
  
  cp = color(0, 0, 100);
  ch = color(0, 0, 0);
}

void draw()
{
  background(250);
  procc = cam.get();
  
  if(cam.isStarted())
  {
    procc.loadPixels();
    for(int i = 0; i < dim; i++)
    {
      if((brightness(procc.pixels[i]) > 40) && (saturation(procc.pixels[i]) > 50) && ((hue(procc.pixels[i]) > 330) || (hue(procc.pixels[i]) < 15) ))
       {
         procc.pixels[i] = cp; // putih
       }   else
       {
         procc.pixels[i] = ch;
       }
    }
    procc.updatePixels();
  }
  image(procc, width / 2, 150);
  textSize(50);
  fill(0);
  text(frameRate, 0, 50);
}

void onCameraPreviewEvent()
{
  cam.read();
}

void mousePressed()
{
  if (cam.isStarted())
  {
    cam.stop();
  } else
    cam.start();
}
