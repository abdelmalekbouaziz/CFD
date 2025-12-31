PROGRAM LINEAR_CONVECTION_1D
        IMPLICIT NONE

        !DECLARATIONS
        INTEGER :: i, j
        INTEGER, PARAMETER :: Nx = 201, Nt = 51*2, WP = 4
        REAL :: c, dt, dx, TINI, TEND, XLEFT, XRIGHT, ULEFT, URIGHT
        REAL :: x(Nx), un(Nx), u(Nx)

        !INITIALIZATIONS
        c = 1.0       ! c < 1.0 for artificial viscosity effects ~ 0.5
        dt = 0.01
        TINI = 0.0
        XLEFT = 0.0
        XRIGHT = 2.0
        ULEFT = 1.0
        URIGHT = 1.0
        TEND = dt * Nt
        dx = (XRIGHT - XLEFT)/(Nx - 1)

        !SPACE GRID
        DO i = 1, Nx
                x(i) = XLEFT + (i - 1) * dx
                !PRINT *, x(i)
                !WRITE (*, '(F8.4)') x(i)
        END DO
        
        !VELOCITY INIT
        DO i = 1, Nx
                IF (x(i) >= 0.5_WP .AND. x(i) <= 1.0_WP) THEN
                        u(i) = 2.0_WP
                ELSE 
                        u(i) = 1.0_WP
                END IF        
                !WRITE (*, '(F8.4)') u(i)
        END DO

        !FORWARD IN TIME | BACKWARD IN SPACE SCHEME
        DO j =1 , Nt
                u(1) = ULEFT
                u(Nx) = URIGHT
                un(1) = ULEFT
                un(Nx) = URIGHT
                
                DO i = 2, Nx-1
                un(i) = u(i)
                u(i) = un(i) - c * (dt/dx) * (un(i) - un(i - 1))
                !WRITE (*, '(F8.4)') un(i)
                END DO
        END DO

        DO i = 1, Nx
                WRITE (*, '(F15.6)') u(i)
        END DO

END PROGRAM LINEAR_CONVECTION_1D
