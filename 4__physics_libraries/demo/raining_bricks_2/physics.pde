
Body createPolygon(float... coords) {
  
    // number of points
    int n = coords.length / 2;

    // find the center point
    Vec2 center = new Vec2(0, 0);
    for(int i = 0; i < n; i++) {
      center.x += coords[i*2];
      center.y += coords[i*2+1];
    }
    center.mul(1.0/n);
    
    // position vertices, relative to center
    Vec2[] vertices = new Vec2[n];
    for(int i = 0; i < n; i++) {
      vertices[i] = box2d.vectorPixelsToWorld(new Vec2(coords[i*2] - center.x, coords[i*2+1] - center.y));
    }
    
    // Define the polygon shape
    PolygonShape sd = new PolygonShape();
    sd.set(vertices, vertices.length);    

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    
    // create new body from the body definition
    Body body = box2d.createBody(bd);
    
    // fixture definition
    FixtureDef fdef = new FixtureDef();
    fdef.density = 100;
    fdef.friction = 0.5;
    fdef.restitution = 0.5;
    fdef.shape = sd;

    //body.createFixture(sd, 100);
    body.createFixture(fdef);

    return body;
  
}

Body createRect(float x1, float y1, float x2, float y2) {
  return createPolygon(x1, y1, x2, y1, x2, y2, x1, y2);
}
