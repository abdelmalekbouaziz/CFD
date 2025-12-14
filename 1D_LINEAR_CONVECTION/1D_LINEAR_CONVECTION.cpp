#include<iostream>
#include<iomanip>

using namespace std;

int main()
{
    // Declaration
    int Nx = 21, Nt = 51, i, j;
    double c, dx, dt, XLeft, XRight, Tini, Tend, ULeft, URight;
    double x[Nx], u[Nx], un[Nx]; 

    // Initialization
    c = 1.0;
    XLeft = 0.0;
    XRight = 2.0;
    ULeft = 1.0;
    URight = 1.0;
    Tini = 0.0;
    dx = (XRight - XLeft)/(Nx - 1);
    dt = 0.01;
    Tend = dt * Nt;

    // Velocity Initialization
    for(i = 0; i < Nx; i++)
    {
        x[i] = i * dx;
        // printf("%f\n", x[i]);
    }

    for(i = 0; i < Nx; i++)
    {
        if(x[i] >= 0.5 && x[i] <= 1.0)
        {
            u[i] = 2.0;
        }
        else
        {
            u[i] = 1.0;
        }
        // printf("%f\n", u[i]);
    }

    //Forward in Time | Backward in Space Scheme
    for(j = 1; j < Nt+1; j++)
    {	
	u[0] = ULeft;
        u[Nx-1] = URight;
	un[0] = ULeft;
	un[Nx-1] =URight;

        for(i = 1; i < Nx-1; i++)
        {
	    un[i] = u[i];		
            u[i] = un[i] - c * (dt/dx) * (un[i] - un[i-1]);
        }
    }

    for(i = 0; i < Nx; i++)
        {
           printf("%f\n", u[i]);
	   //std::cout << u[i];
        }
}
