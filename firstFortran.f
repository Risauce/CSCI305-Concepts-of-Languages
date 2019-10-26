      program looneyTown
      IMPLICIT NONE
	
	!--------------------------------------
	!This program takes in user input on how much change they need to 
	!convert to Looney money. Then it quickly converts the change and 
	!writes it back out to screen in two different ways (non/advancing)
	!--------------------------------------

      integer, parameter:: lunker= 30, loonter= 15, little=5, pooney=1
	Integer :: totalChange, totalLunker, totalLoon, totalLittle
	Integer :: totalPooney

	CALL DateTime()
	CALL GetNumbers()

	CONTAINS
	SUBROUTINE GetNumbers()!Gets user input for the program. 
		! If that input is wrong, it outputs an error message and terminates. 
		Implicit None
		integer:: iostat, ios

		print *, "How much change to convert (1-99)?"
		read (*,*, iostat=ios) totalChange !number from 1-99 that we need to convert
		! if char is entered it errors out
		if(ios/=0) then
			print*, "Incorrect Entry!"
		else if(totalChange <= 0 .or. totalChange >99) then
			print*, "Incorrect Entry!"
		else
			CALL ChangeCalc()
			CALL Printer()
			CALL SpecialPrinter()
			
		end if
	END SUBROUTINE GetNumbers

	SUBROUTINE ChangeCalc() !Calculates all the change! 
		Implicit None
		totalLunker = totalChange / lunker
		totalChange = mod(totalChange, lunker) !Have to make sure the total change goes down too.
		totalLoon = totalChange / loonter
		totalChange = mod(totalChange, loonter)
		totalLittle = totalChange / little
		totalChange = mod(totalChange, little)
		totalPooney = totalChange / pooney
	END Subroutine ChangeCalc
	
	SUBROUTINE Printer()!Normally Prints out the values
		Implicit None
		if(totalLunker > 0) Then
			write(*,*) totalLunker, "Lunker"
		end if
		if(totalLoon > 0) Then
			write(*,*) totalLoon, "Loonter"
		end if
		if(totalLittle > 0) Then
			write(*,*) totalLittle, "Little"
		end if
		if(totalPooney > 0) Then
			write(*,*) totalPooney, "Pooney"
		end if
	end subroutine Printer

	SUBROUTINE SpecialPrinter()!Prints all the values on one line (non advancing)
		Implicit None
		if(totalLunker > 0) Then
			write(*, fmt="(i0,1x,a)", ADVANCE ='NO') totalLunker, "Lunker, "
		end if

		if(totalLoon > 0) Then
			write(*, "(i0,1x,a)", ADVANCE ='NO') totalLoon, "Loonter, "
		end if

		if(totalLittle > 0) Then
			write(*, "(i0,1x,a)", ADVANCE ='NO') totalLittle, "Little, "
		end if

		if(totalPooney > 0) Then
			write(*,"(i0,1x, a)") totalPooney, "Pooney"
		end if
		print*,""
	END SUBROUTINE SpecialPrinter

	SUBROUTINE DateTime() !This subroutine just prints out the date in the best way.
		Implicit None
		character(len = 8) :: DateINFO !ccyymmdd
		character(len =4) :: Year, Month*2, Day*2
		character(len = 10) :: TimeINFO, PrettyTime*12 !hhmmss.sss
		character(len =2) :: Hour, Minute, Second*6
		CALL Date_and_time(DateINFO, TimeINFO) 
		Year = DateINFO(1:4)
		Month = DateINFO(5:6)
		Day = DateINFO(7:8)
		Hour = TimeINFO(1:2)
		Minute = TimeINFO(3:4)

		write(*,*) Month, "-", Day, "-", Year, ", ", Hour, ":",Minute

	END SUBROUTINE DateTime
	
      end program looneyTown