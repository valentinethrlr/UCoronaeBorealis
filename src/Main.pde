Star stars[] = new Star[2];
PVector centerMass;
float zoom = 10;

// initialisation de la constante de la gravitation en masses et rayons solaires
float G = 3.93* pow(10, -7);

// initialisation du nombre de calculs faits avant l'affichage d'un dessin
float tickPerDraw = 100;

void setup() {

  size(1000, 1000);
  strokeWeight(0.3);
  // initialistion des deux étoiles en masses et rayons solaires
  stars[0] = new Star(0, 17, color(61, 82, 213, 200), 2.53, 4.03, 8.62*pow(10, -5));
  stars[1] = new Star(0, 0, color(240, 138, 75, 200), 4.43, 1.31, -2.66*pow(10, -4));
  // calcul du centre de masses des deux étoiles
  centerMass = new PVector((stars[0].pos.x * stars[0].mass + stars[1].pos.x * stars[1].mass)/(stars[0].mass +  stars[1].mass), (stars[0].pos.y * stars[0].mass + stars[1].pos.y * stars[1].mass)/(stars[0].mass +  stars[1].mass));
}

void draw() {
  // translation pour être au centre du dessin
  translate(width/2, height/2);

  scale(zoom);

  // translation pour suivre le centre de masses
  translate(-centerMass.x, -centerMass.y);
  point(0, 0);
  
  // permet de sauvgarder les images obtenues grâce au code
  //saveFrame();
  
  // calcul de la force de gravité agissant entre chaque étoile, tickPerDraw fois
  for (int a = 0; a<tickPerDraw; a++) {
    for (int i = 0; i<stars.length; i++) {
      for (int j = 0; j<stars.length; j++) {
        if (j == i) {
          continue;
        }
        stars[i].calculateGravity(stars[j]);
      }
    }
    // mise à jour des propriétés d'accélération, de vitesse et de position des étoiles par rapport à la force de gravité calculée
    for (int i = 0; i<stars.length; i++) {
      stars[i].tick();
    }
  }
  // calcul de la position du centre de masse
  centerMass = new PVector((stars[0].pos.x * stars[0].mass + stars[1].pos.x * stars[1].mass)/(stars[0].mass +  stars[1].mass), (stars[0].pos.y * stars[0].mass + stars[1].pos.y * stars[1].mass)/(stars[0].mass +  stars[1].mass));
  // création d'un fond noir
  background(0);
  
  // dessin de chaque étoile
  for (int i = 0; i<stars.length; i++) {

    stars[i].show();
  }
}