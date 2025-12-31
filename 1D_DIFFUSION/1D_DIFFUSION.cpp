#include<iostream>
#include<iomanip>
#include<cmath>

using namespace std;

int main()
{

// DECLARATION OF VARIABLES
int i, j, NX = 101, NT = 4000;
double XLEFT, XRIGHT, ULEFT, URIGHT, DX, DT, TINI, TEND, VIS;
double X[NX], U[NX], UN[NX];

// SPACE GRID
XLEFT = 0.0;
XRIGHT = 2.0;
DX = (XRIGHT - XLEFT)/(NX - 1);

for(i=0; i<NX; i++)
{
	X[i] = XLEFT + i * DX;
	//printf("%f\n", X[i]); 
}

// TIME PARAMS
TINI = 0.0;
DT = 0.00001;
TEND = TINI + NT * DT;

// PROBLEM PARAMS
VIS = 4.0;		// VISCOSITY = -0.1, FOR EXPLOSION

// BOUNDARY CONDITIONS
ULEFT = 1.0;
URIGHT = 1.0;

// INITIAL CONDITION
for(i=0; i<NX; i++)
{
	if(X[i] >= 0.5 && X[i] <= 1.0)
	{
		U[i] = 2.0;
		UN[i] = 2.0;
	}
	else
	{
		U[i] = 1.0;
		UN[i] = 1.0;
	}
	//printf("%f \t %f \n", X[i], U[i]);
}

// FORWARD DIFF. IN TIME, CENTRAL DIFF. IN SPACE
for(j=1; j<NT+1; j++)
{
	U[0] = ULEFT;
	U[NX-1] = URIGHT;
	UN[0] = ULEFT;
	UN[NX-1] = URIGHT;

	for(i=1; i<NX-1; i++)
		U[i] = UN[i] + VIS * (DT/(DX*DX)) * (UN[i+1] - 2*UN[i] + UN[i-1]);

	for(i=1; i<NX-1; i++)
		UN[i] = U[i];
}

for(i=0; i<NX; i++)
	printf("%f \t %f \n", X[i], U[i]);

}
