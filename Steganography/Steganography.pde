//Video I used for inspiration: 
//https://www.youtube.com/watch?v=TWEXCYQKyDc

//TODO: include text area and save/decrypt button to manually introduce finle name and save encrypted images

String message = "this is an example message";
//This is the message we want to encrypt!!!

enigma st;

void setup(){
  
  size(600,600);//Adjust canvas size to make the image fit
  background(0);//Make it 255 if you want to display a white image
  
  st = new enigma("example.png");//Instantiates the encryption object in the picture
  st.print_pixels(message.length());//Prints the first n pixels in the picture, before altering them
  st.encrypt(0,1,'B', message);//Encrypts a given message in the picture
  st.print_pixels(message.length());//Prints the first n pixels in the picture, after encrypting the message in the picture

  String phrase = st.decrypt(0,1,'B', message.length());//Stores the decrypted sentence
  st.draw_picture();//Draws the MODIFIED picture
  
  println("The message to encrypt is: " + phrase);//Prints the 
    
  st.load_img("encryptedImage.tif");//tif does not compress the image, therefore the message can be written flawlessly!
  phrase = st.decrypt(0,1,'B', message.length());//the message from our image
  println("The deciphered message is: " + phrase);//Prints the message to the console.
  
  textSize(20);
  text(phrase, 50, height/2);  
  
}
