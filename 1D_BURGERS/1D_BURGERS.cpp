#include<iostream>
#include<iomanip>
#include<cmath>

using namespace std;

int main()
{
	//~ DECLARATIONS OF VARIABLES ~//
	int i, j, NX = 101, NT = 800;
	double XLEFT, XRIGHT, TINI, TEND, T, DX, DT;
	double VIS = 0.1, DPHI, PHI, PI = M_PI;
	double X[NX], U[NX], UINI[NX], UN[NX], UA[NX];
	int IP1[NX], IM1[NX];

	//~ SPACE GRID ~//
	XLEFT = 0.0;
	XRIGHT = 2.0 * PI;
	DX = (XRIGHT - XLEFT)/(NX - 1);
	
	for(i = 0; i < NX; i++)
	{
		X[i] = XLEFT + i * DX;
		//printf("%f\n", X[i]); 
	}	
	
	//~ TIME GRID ~//
	TINI = 0.0;
	DT = 0.001;
	TEND = TINI + DT * NT;

	//~ PROBLEM PARAMS. ~//
	VIS = 0.1;

	//~ AUXILIARY VARIABLES ~//
	for(i = 0; i < NX; i++)
	{
		IP1[i] = i + 1;
		IM1[i] = i - 1;
	}
	
	IP1[NX - 1] = 0;
	IM1[0] = NX - 1;

	//~ INITIAL CONDITION ~//
	for(i = 0; i < NX; i++)
	{
		PHI = std::exp(-std::pow(X[i], 2)/(4.0 * VIS)) + std::exp(-std::pow(X[i] - 2.0 * PI, 2)/(4.0 * VIS));
	       	DPHI = -0.5/VIS * X[i] * std::exp(-std::pow(X[i], 2)/(4.0 * VIS)) - \
		       0.5/VIS * (X[i] - 2.0 * PI) * std::exp(-std::pow(X[i] - 2.0 * PI, 2)/(4.0 * VIS));
		UINI[i] = -2.0 * VIS * DPHI/PHI + 4.0;
		U[i] = UINI[i];
		//printf("%f \n", UINI[i]);
	
	}

	//~ FORWARD IN TIME | BACKWARD IN SPACE du/dx | CENTRAL IN SPACE d^2u/dx^2 ~//
	for(j = 0; j < NT; j++)
	{
		T = j * DT;
		
		for(i = 0; i < NX; i++)
                {
                        PHI = std::exp(-std::pow(X[i] - 4.0 * T, 2)/(4.0 * VIS * (T + 1.0))) + \
					std::exp(-std::pow(X[i] - 4.0 * T - 2.0 * PI, 2)/(4.0 * VIS * (T + 1.0)));				
			DPHI = -0.5/VIS/(T + 1.0) * (X[i] - 4.0 * T) * std::exp(-std::pow(X[i] - 4.0 * T, 2)/(4.0 * VIS * (T + 1.0))) - \
				0.5/VIS/(T + 1.0) * (X[i] - 4.0 * T - 2.0 * PI) * std::exp(-std::pow(X[i] - 4.0 * T - 2.0 * PI, 2)/(4.0 * VIS * (T + 1.0)));	
			UA[i] = -2.0 * VIS * DPHI/PHI + 4.0;
                }

		
		for(i = 0; i < NX; i++)
		{
			UN[i] = U[i];
		}

		for(i = 0; i < NX; i++)
                {
                        U[i] = UN[i] - UN[i] * (DT/DX) * (UN[i] - UN[IM1[i]]) + VIS * DT/(DX*DX) * (UN[IP1[i]] + UN[IM1[i]] - 2.0 * UN[i]);
                }
	
	}
	
	printf("%-15s %-15s %-15s\n", "X:", "UA:", "U:");
	
	for(i = 0; i < NX; i++)
    		printf("%-15.6f %-15.6f %-15.6f\n", X[i], UA[i], U[i]);
}
