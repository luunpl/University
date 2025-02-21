// Simple Scilab Script
clc;        // Clear the console
clear;      // Clear variables
disp("Welcome to Scilab!");

// Define variables
a = 5;
b = 10;
c = a + b;
disp("Sum of a and b is: " + string(c));

// Define a matrix
A = [1 2 3; 4 5 6; 7 8 9];
disp("Matrix A:");
disp(A);

// Perform matrix operations
B = A';
disp("Transpose of A:");
disp(B);

// Plot a simple sine wave
// Data for plotting
x = linspace(0, 2*%pi, 100);
y = sin(x);

// Generate plot
plot2d(x, y);  // This will still work in -nogui mode, but no window will show up

// Save the plot as an image
xs2png(0, "plot_output.png");  // Save the plot as a PNG file

// Notify user that the plot is saved
disp("Plot saved as plot_output.png");

// Simple loop
disp("Loop Example:");
for i = 1:5
    disp("Iteration: " + string(i));
end
