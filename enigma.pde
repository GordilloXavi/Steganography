public class enigma{
  
  PImage photo;//Will store the foto to operate on
  
  public enigma() {}//Default constructor. This line may be removed
 
  public enigma(String img){//img: the path to the image that will be encrypted/decrypted
    
    load_img(img);
    
  }
  
  void load_img(String img){//Loads an image 
  
    photo = loadImage(img);
    photo.loadPixels();
    
  }
  
  void print_pixels(int pix){//Prints the first 'pix' pixels of the image to the console. Use for debugging purposes.
    
    int w = photo.width;
    int h = photo.height;
    int loc =0;
    
    for(int x = 0; x<w; ++x){
      
      for(int y = 0; y<h; ++y){
        
      loc = x + y*photo.width;
      float r = red (photo.pixels [loc]);
      float g = green (photo.pixels [loc]);
      float b = blue (photo.pixels [loc]);
      
      if(loc <= pix)println("r: " + r + " g: " + g + " b: " + b);
        
      }
      
    }
    
    println(" ----------- ");

    
  }
  
  void encrypt(int start, int gap, char col, String text){
    //Encrits a text in the 'start' position of the image(may cause verflow problems when dealing with the pixels[] array)
    //Col means we can encrypt in any of the r/g/b colors. Feature to be added later.
    //The BLUE component of the encrypted pixels will be changed to an integer representing an ASCII value + 100
    //We will use this information to later reverse the process to decrypt the messages
    
    photo.loadPixels();
  
    int l = photo.pixels.length;
    int y = start/photo.width;//x,y Position where the message will be stored inside the image
    int x = start%photo.width;
    int size = text.length();
    
    for(int i = 0; i< size*gap; i+=gap){
      
      int asc = text.charAt(i) + 100;//'a' = 97+100
            
      int loc = x + y*photo.width + i;

      color c = color(red (photo.pixels[loc]), green(photo.pixels [loc]), asc);//We are changing the blue value
      
      photo.pixels[loc] = c;//Overwrites the current pixel with the modified pixel, representing an ASCII char
      
    }
        
    photo.updatePixels();
    photo.save("encryptedImage.tif");//Saves the image ot the project folder. An absolut path may be specified
    //TIFF format does not compress the image, therefore the message can be read without issues later!
  }
  
  String decrypt(int start, int gap, char col, int textSize){
    
    //We assume the picture we want to decrypt is already stored in the photo variable.
    //We could change this by adding a path parameter.
    
    photo.loadPixels();

    String text = "";//Message
    
    int l = photo.pixels.length;
    int y = start/photo.width;
    int x = start%photo.width;

      for(int i = 0; i< textSize*gap; i+=gap){//Thake spaces into account
          
          int loc = x + y*photo.width + i;

          char c = char(int(blue(photo.pixels[loc])-100));//We take the blue component -100 and store it as an ASCII char
      
          text += c;//We append the char to the message
      
    }    
    
    return text;
    
  }
  
  
  void draw_picture(){//Draws the picture to the canvas. The picture appears dimmer tha expected
    
    int w = photo.width;
    int h = photo.height;
      
    for(int i = 0; i<h; ++i){
      for(int j = 0; j<w; ++j){

        int loc = w*i +j;
        
        color c = photo.pixels[loc];
        noStroke();
        fill(c);
        
        ellipse(j,i,1,1);//I'm sure this can be done in a better way, and is the cause of the dimness in the image.
        //TODO: draw a single pixel, not an ellipse!
      
      }
    }
    
  }
  
}
