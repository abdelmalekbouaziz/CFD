PROGRAM BURGERS_1D

        IMPLICIT NONE

        !DECLARATIONS OF VARIABLES!
        INTEGER :: i, j
        INTEGER, PARAMETER :: NX = 101, NT = 800, WP = 4
        INTEGER :: IM1(NX), IP1(NX)
        REAL, PARAMETER :: PI = 4.0 * ATAN(1.0)
        REAL :: XLEFT, XRIGHT, TINI, DX, TEND, T, DT
        REAL :: VIS, PHI, DPHI
        REAL :: X(NX), UINI(NX), U(NX), UN(NX), UA(NX)

        !SPACE GRID!
        XLEFT = 0.0
        XRIGHT = 2.0 * PI
        DX = (XRIGHT - XLEFT)/(NX - 1)

        DO i = 1, NX
                X(i) = XLEFT + (i - 1) * DX
                !WRITE(*, '(F8.4)') X(i)
        END DO
        
        !TIME PARAMS.!
        TINI = 0.0
        DT = 0.001
        TEND = TINI + DT * NT
        
        !PROBLRM PARAMS.!
        VIS = 0.1
        
        !AUXILIARY VARIABLES!
        DO i = 1, NX
                IM1(i) = i - 1
                IP1(i) = i + 1
        END DO

        IM1(1) = NX
        IP1(NX) = 1
        
        !INITIAL CONDITION!
        DO i = 1, NX
                PHI = EXP(-X(i)**2/(4.0 * VIS)) + &
                      EXP((-(X(i) - 2.0 * PI)**2)/(4.0 * VIS))

                DPHI = -0.5/VIS * X(i) * EXP(-X(i)**2/(4.0 * VIS)) - &
                        0.5/VIS * (X(i) - 2.0 * PI) * EXP((-(X(i) - 2.0 * PI)**2)/(4.0 * VIS))
               
                UINI(i) = -2.0 * VIS * DPHI/PHI + 4.0
                U(i) = UINI(i)
                !WRITE(*, '(F8.4)') U(i) 
        END DO
        
        !FORWARD IN TIME | BACKWARD IN SPACE du/dx | CENTRAL IN SPACE d^2u/dx^2!
        DO j = 1, NT
                T = (j - 1) * DT

                DO i = 1, NX
                PHI = EXP(-(X(i) - 4.0 * T)**2/(4.0 * VIS * (T + 1.0))) + &
                      EXP((-(X(i) - 4.0 * T - 2.0 * PI)**2)/(4.0 * VIS * (T + 1.0)))
                
                DPHI = -0.5/VIS/(T + 1.0) * (X(i) - 4.0 * T) * &
                       EXP(-(X(i) - 4.0 * T)**2/(4.0 * VIS * (T + 1.0))) - &
                       0.5/VIS/(T + 1.0) * (X(i) - 4.0 * T - 2.0 * PI) * &
                       EXP((-(X(i) - 4.0 * T - 2.0 * PI)**2)/(4.0 * VIS * (T + 1.0)))
                
                UA(i) = -2.0 * VIS * DPHI/PHI + 4.0
                END DO

                DO i = 1, NX
                        UN(i) = U(i)
                END DO

                DO i = 1, NX
                        U(i) = UN(i) - UN(i) * (DT/DX) * (UN(i) - UN(IM1(i))) + &
                               VIS * (DT/DX**2) * (UN(IP1(i)) + UN(IM1(i)) - 2 * UN(i)) 
                END DO

        END DO

        WRITE(*, '(A15, A15, A15)') "X:", "UA:", "U:"

        DO i = 1, NX
                WRITE(*, '(F15.6, F15.6, F15.6)') X(i), UA(i), U(i)
        END DO

END PROGRAM BURGERS_1D
