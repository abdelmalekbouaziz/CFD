#include<iostream>
#include<iomanip>
#include<cmath>

using namespace std;

int main()
{

// DECLARATION OF VARIABLES
int i, n, NX = 101, NT = 4000, NTERMS = 200;
double XLEFT, XRIGHT, DX, DT, TINI, TEND, VIS, T;
double X[NX], UA[NX], A[NTERMS];

// SPACE GRID
XLEFT = 0.0;
XRIGHT = 2.0;
DX = (XRIGHT - XLEFT)/(NX - 1);

for(i = 0; i < NX; i++)
{
	X[i] = XLEFT + i * DX;
	//printf("%f \n", X[i]);
}

// TIME PARAMS
TINI = 0.0;
DT = 1.e-5;
TEND = TINI + NT * DT;

// PROBLEM PARAMS
VIS = 4.0;

// COMPUTE FOURIER COEFFICIENTS
for(n = 0; n < NTERMS; n++)
	A[n] = (2.0 / (M_PI * (n + 1.0))) * (std::cos((n + 1.0) * M_PI/4.0) - std::cos((n + 1.0) * M_PI/2.0));

// COMPUTE THE ANALYTICAL SOLUTION
T = TEND; 

for(i = 0; i < NX; i++)
{
	UA[i] = 1.0;

	for( n = 0; n < NTERMS; n++)
	{
		UA[i] = UA[i] + A[n] * std::sin((n + 1.0)/2.0 * M_PI * X[i]) * std::exp(-std::pow(n + 1.0, 2.0)/4.0 * M_PI * M_PI  * VIS * T);
	}

	printf("%f \t %f \n", X[i], UA[i]);
}



}
