class Star {

  PVector pos, vel, acc;
  color couleur;
  float size;
  float mass;
  PVector path[];
  int pathIndex;

  // initialisation du modèle pour une étoile
  Star(int x, int y, color coul, float size, float m, float velo) {

    this.size = size;
    this.couleur = coul;
    this.vel = new PVector(velo, 0);
    this.acc = new PVector(0, 0);
    this.pos = new PVector(x, y);
    this.mass = m;
    this.path = new PVector[600];
    this.pathIndex = 0;
    for (int i = 0; i<path.length; i++) {
      path[i] = pos;
    }
  }
  
  // ajout de l'accélération dû à la gravitation à l'accélération de l'étoile
  void applyForce(PVector force) {
    this.acc.add(force);
  }

  // calcul de la force de gravitation pour la formule de Newton
  void calculateGravity(Star other) {
    PVector force = other.pos.copy().sub(this.pos);
    force.setMag((G * this.mass * other.mass)/(pow(force.mag(), 2)));
    applyForce(force);
  }

  // changement des valeurs d'accélération, de vitesse et de position avec la nouvelle force de gravitation
  void tick() {

    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

  // dessin des "trainées" de trajectoire des étoiles, puis des étoiles elles-mêmes
  void show() {
    stroke(255, 255, 255, 10);
    for (int i = 0; i<path.length; i++) {
      point(path[i].x, path[i].y);
    }
    path[pathIndex] = pos.copy();
    pathIndex = (pathIndex + 1) % path.length;
    noStroke();
    fill(couleur);
    circle(pos.x, pos.y, size);
    
  }
}