
point.x;
point.x = 10;
// Objective-C instance methods become functions.
point.description();
// Objective-C initializers can be called with constructor syntax.
var p = MyPoint(1, 2);
// Objective-C class methods become functions on the constructor object.
var q = MyPoint.makePointWithXY(0, 0);
