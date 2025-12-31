PROGRAM DIFFUSION_1D

        IMPLICIT NONE

        !DECLARATIONS OF VARIABLES
        INTEGER :: i, j
        INTEGER, PARAMETER :: NX = 101, NT = 4000, WP = 4
        REAL :: DX, DT, XLEFT, XRIGHT, TINI, TEND, ULEFT, URIGHT, VIS
        REAL :: X(NX), U(NX), UN(NX)

        !SPACE GRID
        XLEFT = 0.0
        XRIGHT = 2.0
        DX = (XRIGHT - XLEFT)/(NX - 1)

        DO i = 1, NX
                X(i) = XLEFT + DX * (i - 1)
                !WRITE (*, '(F8.4)') X(i)
        END DO

        !TIME PARAMS
        TINI = 0.0
        DT = 0.00001
        TEND = TINI + DT * NT

        !PROBLEM PARAMS
        VIS = 4.0       !VISCOSITY = -0.1, FOR EXPLOSION

        !BOUNDARY CONDITIONS
        ULEFT = 1.0
        URIGHT = 1.0

        !INITIAL CONDITION
        DO i = 1, NX
               IF (X(i) >= 0.5_WP .AND. X(i) <= 1.0_WP) THEN
                        U(i) = 2.0_WP
                        UN(i) = 2.0_WP
               ELSE
                        U(i) = 1.0_WP
                        UN(i) = 1.0_WP
               END IF
               !WRITE (*, '(F8.4, A1, F8.4)') X(i), char(9), U(i)
        END DO
        
        !FORWARD DIFF. IN TIME, CENTRAL DIFF. IN SPACE
        DO j = 1, NT
                U(1) = ULEFT
                U(NX) = URIGHT
                UN(1) = ULEFT
                UN(NX) = URIGHT

                DO i = 2, NX-1
                        U(i) = UN(i) + VIS * (DT/(DX*DX)) * (UN(i+1) - 2*UN(i) + UN(i-1))
                END DO

                DO i = 2, NX-1
                        UN(i) = U(i)
                END DO
        END DO

        DO i = 1, NX
                WRITE (*, "(F8.4, A, F8.4)") X(i), char(9), U(i)
        END DO

END PROGRAM DIFFUSION_1D
