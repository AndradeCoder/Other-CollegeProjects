class Poster {

	private Layer[] collection;
	private int width;
	private int height;
	private ColorImage img;

	static final int FinalSize = 5;
	static final Color White = new Color(255,255,255);

	// Criar um objeto Poster

	Poster(int width, int height){
		this.collection = new Layer[FinalSize];
		this.width = width;
		this.height = height;
		this.img = new ColorImage(width,height);
	}

	// 1. Substituir a Layer[0] dada a imagem com o padr�o de preenchimento

	void addFirstLayer(ColorImage img){
		this.img = Imagens.imagePattern(img,width,height);
		Layer first = new Layer(img);
		collection[0] = first;
	}

	// 2. Adicionar no fim da cole��o um novo Layer

	void addLastLayer(Layer last){
		collection[collection.length-1] = last;
	}

	// 3. Remover uma layer da cole��o numa posi��o dada, deslocando as restantes

	void remove(int position){

		Layer[] smaller = new Layer[collection.length-1]; // criar um novo vetor com menos 1 de comprimento
		if(position >= collection.length){
			throw new IllegalStateException("O �ndice est� fora dos limites");
		}		
		for (int i = position; i < collection.length-1; i++) {			
			collection[i] = collection[i+1];
		}
		collection[collection.length-1] = null;

		for (int i = 0; i < smaller.length; i++) {
			smaller[i] = collection[i]; 
		}
		collection = smaller;
	}

	// 4. Inserir uma layer na cole��o numa dada posi��o, deslocando as restantes

	void insertNewLayer(int position,Layer nova){

		if(position >= collection.length){
			throw new IllegalStateException("O �ndice est� fora dos limites");
		}
		Layer[] bigger = new Layer[collection.length+1]; // criar um novo vetor com mais 1 de comprimento
		for (int i = 0; i < collection.length; i++) {    	
			bigger[i] = collection[i];						
		}
		collection = bigger;

		for (int i = position; i < collection.length-1; i++) {
			collection[i+1] = collection[i];
		}
		collection[position] = nova;
	}	

	// 5. Trocar as posi��es de duas layers na cole��o

	void substitute(int firstL, int secondL){
		Layer aux = collection[firstL];
		collection[firstL] = collection[secondL];
		collection[secondL] = aux;
	}

	/* 6. Obter a imagem final do poster, com a sobreposi��o de todas as layers ativas obedecendo
	      � transpar�ncia  */

	ColorImage posterFinal(){		

		ColorImage fundo = new ColorImage(this.width,this.height);

		for (int i = 0; i < collection.length; i++) {			
			if(collection[i] == null)
				continue;

			if(collection[i].getIsActive()){
				Imagens.copyTransparent(collection[i].returnImage(),fundo,0,0);
			}
		}
		return fundo;
	}





}