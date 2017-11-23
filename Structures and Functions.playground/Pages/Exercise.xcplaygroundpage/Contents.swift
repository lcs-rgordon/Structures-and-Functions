/*:
 [Previous](@previous)
 
 The following statement is required to make the playground run.
 
 
 Please do not remove.
 */
import Foundation
/*:
 ## Exercise
 
 Write a function named **shortestDistance** that determines the shortest distance from a point on a Cartesian plane to a line on a Cartesian plane.
 
 The function header should look like this:
 
  ![example](example1.png "example")
 
 You can re-use the **Point** structure and the *distance* function.
 
 You should declare a new **Line** structure.
 
 Recall that a line is defined by it's *slope* and it's *vertical intercept*. What stored properties would you create for a **Line** structure?
 
 Recall that slope, in turn, is defined by it's *rise* and *run*. Could you create a **Slope** structure? What stored properties might it define?
 
 Recall that the shortest distance from a point to a line is the *perpendicular* distance from that point to the line.
 
 Here is a [complete example showing how to find the shortest distance from a point to a line](http://russellgordon.ca/lcs/shortest-distance-example.pdf), using symbolic algebra.
 
 Your job is to implement a solution in code that carries out the necessary mathematics. The beautiful part of this effort is that, once you've "taught" the computer how to do this correctly, you will never need to do this type of work manually again. 👍🏽😅🎉

*/

// Define the Point struct
struct Point {
    var x : Double = 0.0
    var y : Double = 0.0
}

// Define the Slope struct
struct Slope {
    var rise : Double = 1.0
    var run : Double = 1.0
}

// Define the Line struct
struct Line {
    var slope : Slope = Slope()
    var verticalIntercept : Double = 5.0
}

/// Returns the negative perpendicular slope when given a line.
///
/// - Parameter from: The line that we are starting from.
/// - Returns: The slope of a line that would be perpendicular to the given line.
func getSlopeOfPerpendicularLine(from givenLine: Line) -> Slope {
    
    return Slope(rise: givenLine.slope.run, run: givenLine.slope.rise * -1)
    
}

/// Get the vertical intercept for a line given a point on the line and it's slope
///
/// - Parameters:
///   - p: a point on the line
///   - m: the slope of the line
/// - Returns: the vertical intercept of the line
func getVerticalIntercept(from p: Point, onLineWith m: Slope) -> Double {
    
    let b = p.y + (m.rise / m.run) * p.x * -1       // b = y - m * x
    return b
    
}

/// Get the point where two lines intersect on a Cartesian plane
///
/// - Parameters:
///   - between: the first line
///   - and: the second line
/// - Returns: the point of intersection
func getPointOfIntersection(between first: Line, and second: Line) -> Point {
    
    // Get the sum of the co-efficients of the variable terms (the sum of the slopes)
    let variableTermSum = second.slope.rise / second.slope.run + first.slope.rise / first.slope.run * -1
    
    // Get the sum of the vertical intercepts
    let constantTermSum = first.verticalIntercept + second.verticalIntercept * -1
    
    // Get the abscissa (x-value)
    let abscissa = constantTermSum / variableTermSum
    
    // Now get the ordinate (y-value) by "substituting" into the second equation
    let ordinate = second.slope.rise / second.slope.run * abscissa + second.verticalIntercept
    
    // Return the point
    return Point(x: abscissa, y: ordinate)
}

/// Finds the distance between two points on a Cartesian plane
///
/// - Parameters:
///   - from: The first point
///   - to: The second point
/// - Returns: The distance between these two points
func distance(from: Point, to: Point) -> Double {
    
    return sqrt(pow(from.x - to.x,2) + pow(from.y - to.y, 2))
    
}

// Create a line instance (representing the road in this example)
let m = Slope(rise: -1, run: 2)
let existingRoad = Line(slope: m, verticalIntercept: 9.5)

// Create a point (the cabin site in this example)
let cabinSite = Point(x: 6.0, y: 1.5)

// Get the slope of a line perpendicular to the road
let perpendicularM = getSlopeOfPerpendicularLine(from: existingRoad)

// Get the vertical intercept of a line perpendicular to the existing road
let perpendicularB = getVerticalIntercept(from: cabinSite, onLineWith: perpendicularM)

// Define the line perpendicular to the existing road
let newRoad = Line(slope: perpendicularM, verticalIntercept: perpendicularB)

// Find the point of intersection between the two roads
let intersectionOfRoads = getPointOfIntersection(between: existingRoad, and: newRoad)

// Now use the distance function to find the shortest route
let shortestDistance = distance(from: cabinSite, to: intersectionOfRoads)
