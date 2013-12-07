
// custom drawing for JBox2D

void draw(World world) {
  
  // draw all bodies of the world
  for (Body body = world.getBodyList(); body != null; body = body.getNext()) {
    
    boolean inside = false;
    
    for(Fixture f = body.getFixtureList(); f != null; f = f.getNext()) {
      
      Shape s = f.getShape();
      
      // apply style
      Style style = (Style) body.getUserData();
      if (style!=null) style.begin();
      
      // draw polygon
      if (s.getType() == ShapeType.POLYGON) {
        
        beginShape();
        Vec2[] vlist = ((PolygonShape) s).getVertices();
        int n = ((PolygonShape) s).getVertexCount(); // make sure to check the vertex count!
        for(int i = 0; i < n; i++) {
          Vec2 v = box2d.coordWorldToPixels(body.getWorldPoint(vlist[i]));
          inside |= (v.y < height + depth & v.x > -depth & v.x < width + depth);
          vertex(v.x, v.y);
        } 
        endShape(CLOSE);  
        
        // draw 3d effect
        if((visMode & VIS_3D) > 0) {
          for(int i = 0; i < n; i++) {
            Vec2 v1 = box2d.coordWorldToPixels(body.getWorldPoint(vlist[(i+n-1)%n]));
            Vec2 v2 = box2d.coordWorldToPixels(body.getWorldPoint(vlist[i]));
            beginShape();
              vertex(v1.x, v1.y, 0);
              vertex(v2.x, v2.y, 0);
              vertex(v2.x, v2.y, -depth);
              vertex(v1.x, v1.y, -depth);
            endShape(CLOSE);
          }
        }
      }
      if (style!=null) style.end();
      // remove bodies beyond left, right and bottom border
      if(!inside) box2d.world.destroyBody(body);
    }
  }
}


// style associated with a body

class Style {
  color fillColor;
  Style(color c) {
    fillColor = c;
  }
  void begin() {
    pushStyle();
    fill(fillColor);
  }
  void end() {
    popStyle();
  }
}
