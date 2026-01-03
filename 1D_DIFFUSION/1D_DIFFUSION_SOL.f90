PROGRAM DIFFUSION_1D_ANALYTICAL_SOLUTION
        
        IMPLICIT NONE

        !DECLARATIONS OF VARIABLES
        INTEGER :: i, n
        INTEGER, PARAMETER :: NX = 101, NT = 4000, NTERMS = 200, WP = 4
        REAL*8 :: XLEFT, XRIGHT, TINI, TEND, DX, DT, VIS, T
        REAL*8 :: X(NX), UA(NX), A(NTERMS)
        REAL*8, PARAMETER :: PI = 4.0_WP * ATAN(1.0) 

        !SPACE GRID
        XLEFT = 0.0_WP
        XRIGHT = 2.0_WP
        DX = (XRIGHT - XLEFT)/(NX - 1)

        DO i = 1, NX
                X(i) = XLEFT + (i - 1) * DX
                !WRITE(*, '(F8.4)') X(i)
        END DO

        !TIME PARAMS
        TINI = 0.0_WP
        DT = 1.E-05
        TEND = TINI + DT * NT

        !PROBLEM PARAMS
        VIS = 4.0_WP

        !COMPUTE FOURIER COEFFICIENTS
        DO n = 1, NTERMS
                A(n) = 2.0_WP/n/PI * (DCOS(n * PI/4.0) -DCOS(n * PI/2.0))
        END DO

        !COMPUTE THE ANALYTICAL SOLUTION
        T = TEND
        
        DO i = 1, NX
                UA(i) = 1.0_WP

                DO n = 1, NTERMS
                        UA(i) = UA(i) + A(n) * DSIN(n * PI/2.0_WP * X(i)) * DEXP(-n**2 * PI**2/4.0_WP * T * VIS) 
                END DO

                WRITE(*, '(F8.4, A, F16.8)') X(i), char(9), UA(i)
                
        END DO



END PROGRAM DIFFUSION_1D_ANALYTICAL_SOLUTION
