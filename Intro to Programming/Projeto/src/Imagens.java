class Imagens {

	// representação das cores enquanto constantes

	static final Color White = new Color(255,255,255);
	static final Color Black = new Color(0,0,0);
	static final Color Red = new Color(255,0,0);
	static final Color Green = new Color(0,255,0);
	static final Color Blue = new Color(0,0,255);

	// 1. Copiar a parte não transparente de uma imagem para cima de outra

	static ColorImage copyTransparent(ColorImage origem, ColorImage destino, int width, int height){			
		if(width < 0 || height < 0){
			throw new IllegalArgumentException("Os Argumentos não podem ser negativos");
		}
		for (int i = 0; i < origem.getWidth() && i+width < destino.getWidth(); i++) {
			for (int j = 0; j < origem.getHeight() && j+height < destino.getHeight(); j++) {
				Color cor = origem.getColor(i,j);
				if(!(cor.getR()==255 && cor.getG()==255 && cor.getB()==255)) {
					destino.setColor(i+width,j+height,cor);
				}
			}
		}
		return destino;
	}

	static void testCopyTransparent(){
		ColorImage origem = new ColorImage("Cogumelo.png");
		ColorImage destino = new ColorImage("objc1(1).png");
		copyTransparent(origem,destino,0,0);
	}

	// 2. Função que devolve imagem de fundo do poster através de uma imagem padrão que vai ser replicada

	static ColorImage imagePattern(ColorImage padrao, int width, int height){

		ColorImage imgFundo = new ColorImage(width,height);

		//calcular os rácios que dão o número de vezes que a imagem padrão cabe na imagem de 
		// fundo na horizontal e na vertical

		int xfotos = (int)(width/padrao.getWidth())+1;  
		int yfotos = (int)(height/padrao.getHeight())+1;   
		for (int i = 0; i < xfotos*padrao.getWidth(); i+=padrao.getWidth()) {
			for (int j = 0; j < yfotos*padrao.getHeight(); j+=padrao.getHeight()) {
				copyTransparent(padrao,imgFundo,i,j);
			}
		}
		return imgFundo;
	}

	static void testImagePattern(){
		ColorImage padrao = new ColorImage("objc1(1).png");
		imagePattern(padrao,600,600);
	}

	// 3. Função que cria uma cópia escalada de uma imagem dada através de um fator

	static ColorImage scaledImage(ColorImage img, double fatorial){

		ColorImage scaled = new ColorImage((int)(img.getWidth()*fatorial),(int)(img.getHeight()*fatorial));

		//percorrer a imagem escalada nos ciclos

		for (int i = 0; i < scaled.getWidth(); i++) {
			for (int j = 0; j < scaled.getHeight(); j++) { 
				int x = (int)(i/fatorial);
				int y = (int)(j/fatorial);
				Color cor = img.getColor(x,y);
				scaled.setColor(i,j,cor);
			}
		}
		return scaled;
	}			

	static void testScaledImage(){
		ColorImage img = new ColorImage("objc1(1).png");
		scaledImage(img,2);
	}

	// 4. Função que cria uma imagem quadrada correspondente a uma seleção circular de uma imagem original

	static ColorImage selectedImage(ColorImage img, int xCentro, int yCentro, int raio){

		ColorImage img2 = new ColorImage(2*raio,2*raio);
		for (int i = 0; i < img2.getWidth(); i++) {
			for (int j = 0; j < img2.getHeight(); j++) {

				int countx = (int)Math.pow(i-img2.getWidth()/2,2);
				int county = (int)Math.pow(j-img2.getHeight()/2,2);
				int distancia = (int)Math.sqrt(countx+county);
				if(distancia <= raio){
					Color c = img.getColor(i+xCentro,j+yCentro);
					img2.setColor(i,j,c);					
				} else{
					img2.setColor(i,j,White);	
				}
			}
		}
		return img2;
	}

	static void testSelected(){
		ColorImage img = new ColorImage("objc1(1).png");
		selectedImage(img,75,75,50);
	}

	// 5. Função que cria uma cópia em tons cinzentos de uma imagem dada

	static ColorImage greyTone(ColorImage img){

		ColorImage img2 = new ColorImage(img.getWidth(),img.getHeight());
		for (int i = 0; i < img.getWidth(); i++) {
			for (int j = 0; j < img.getHeight(); j++) {
				Color c = img.getColor(i,j);
				int cinzento = (int)(c.getR()*0.3)+(int)(c.getG()*0.59)+(int)(c.getB()*0.11);
				Color cor = new Color(cinzento,cinzento,cinzento);
				img2.setColor(i,j,cor);
			}
		}
		return img2;
	}

	static void testGrey(){
		ColorImage img = new ColorImage("objc1(1).png");
		greyTone(img);
	}





}