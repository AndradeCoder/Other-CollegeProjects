class Test {
	
	//Testar as funções da classe Poster
	
	static void test1(){
		ColorImage img1 = new ColorImage("rainbow.jpg");
		ColorImage img2 = new ColorImage("objc1(1).png");
		ColorImage img3 = new ColorImage("Cogumelo.png");
		Layer l1 = new Layer(img1,50,50);
		Layer l2 = new Layer(img2,0,0);
		Layer l3 = new Layer(img3,0,0);
		Poster p = new Poster(500,500);

		p.addFirstLayer(img1);
		p.addLastLayer(l2);
		p.insertNewLayer(1,l3);
		p.remove(1);
		p.substitute(1,2);
		p.posterFinal();

	}
}