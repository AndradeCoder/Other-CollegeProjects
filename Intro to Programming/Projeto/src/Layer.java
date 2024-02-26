class Layer {

	private ColorImage image;
	private double scale;
	private int x;
	private int y;
	private String name;
	private boolean active;

	Color White = new Color(255,255,255);

	// Criar um objeto Layer fornecendo (i) uma imagem, fator de escala, coordenadas da posição e 
	// um nome identificador

	Layer(ColorImage img, double scale, int x, int y, String name){
		this.image = img;
		this.scale = scale;
		this.x = x;
		this.y = y;
		this.name = name;
		this.active = true;
	}

	// Criar um objeto Layer fornecendo (ii) uma imagem e posição (o fator é unitário e o nome vazio)

	Layer(ColorImage img, int x, int y){
		this.image = img;
		this.scale = 1;
		this.x = x;
		this.y = y;
		this.name = "";
		this.active = true;
	}

	// Criar um objeto Layer fornecendo (iii) apenas uma imagem

	Layer(ColorImage img){
		this.image = img;
		this.scale = 1;
		this.x = 0;
		this.y = 0;
		this.name = "";
		this.active = true;
	}

	// 1. Modificar o nome da imagem

	String getName(){
		return this.name;
	}

	void nameChanger(String name){
		this.name = name;
	}

	// 2. Modificar a escala e o posicionamento

	double getScale(){
		return this.scale;
	}

	int getPositionX(){
		return this.x;
	}

	int getPositionY(){
		return this.y;
	}

	void scaleAndPositionChanger(double scale, int x, int y){
		this.scale = scale;
		this.x = x;
		this.y = y;
	}

	// 3. Definir a imagem como ativa ou inativa

	boolean getIsActive(){
		return this.active;
	}

	void imageActivity(boolean newState){
		this.active = newState;
	}

	/* 4. Devolver a imagem completa da camada, com a imagem original escalada e posicionada,
	      e com a transparência dada pela cor branca */

	ColorImage returnImage(){

		ColorImage finalImage = Imagens.scaledImage(this.image,this.scale);
		ColorImage fundo = new ColorImage((int)(this.x+finalImage.getWidth()*this.scale),
				(int)(this.y+finalImage.getHeight()*this.scale));
		Color White = new Color(255,255,255);

		for (int i = 0; i < fundo.getWidth(); i++) {
			for (int j = 0; j < fundo.getHeight(); j++) {
				fundo.setColor(i,j,White);
			}
		}
		fundo = Imagens.copyTransparent(finalImage,fundo,this.x,this.y);
		return fundo;		
	}

	// Função teste para todos os métodos

	static void tests(){
		ColorImage image = new ColorImage("Cogumelo.png");
		Layer layer = new Layer(image);
		layer.nameChanger("Primeira layer");
		layer.scaleAndPositionChanger(4.20,50,50);
		layer.returnImage();

		System.out.print(layer.getIsActive());
		System.out.print(layer.getScale());
		System.out.print(layer.getName());
		System.out.print(layer.getPositionX());
		System.out.print(layer.getPositionY());
	}









}