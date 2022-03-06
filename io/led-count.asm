<<<<<<< HEAD:io/led-count.asm
; Program that counts to 8 on LEDs connected to PORTB each time a switch on PORTA is pressed   
			
			list 	P=18F452		
			include <p18f452.inc>	
=======
; === Program that implements light bar on LEDs that grows with each switch press ===

            list 	P=18F452		
            include <p18f452.inc>	
>>>>>>> a4760fc0c9aef589db74152ace7726e7c1ae1531:io/led-light-bar.asm

DelayCount1	equ		0x00			; Extra variables for use in the program
DelayCount2	equ		0x01			; See memory map on Data Sheet, page 16
DisplayVal	equ		0x02

<<<<<<< HEAD:io/led-count.asm
			org		0x0000			; Reset/Start Vector of the microcontroller
			goto	Start
			
			org		0x0028			; Place the assembly code in memory here
			
Start:		
            clrf	PORTA			; Clear PORTA file register
			clrf	PORTB			; Clear PORTB file register

			movlw	0xFF			; Set PORTA to be all inputs
			movwf 	TRISA			
			movlw	0x00			; Set PORTB RB0:RB7 as outputs for LEDs
			movwf	TRISB			
	
WaitStart:	
            btfsc	PORTA,4			; S2 pressed? 
			goto 	WaitStart		; No, wait and check again
			
			movlw	0x00			; Yes, reset the count
			movwf	DisplayVal		

CountLoop:	
            movf	DisplayVal,W	; Get the current display value
			movwf	PORTB			; Output value on LEDs

			call 	SoftDelay		; Delay to slow down the PIC
			
			incf	DisplayVal,F	; Increment the display value
			movf	DisplayVal,W	; Get the new value
			sublw	0x10			; Has it reached its max value?
			bnz		CountLoop		; No, continue incrementing			
			bra		WaitStart		; Yes, wait for S2 to start again		



SoftDelay:	
            clrf	DelayCount1		; Implements nested loops to slow down PIC
			movlw	0xC0
			movwf	DelayCount2

DelayLoop:	
            decf	DelayCount1,F	; Outer Loop of Delay Loop
			bnz		SmallDelay
			bra 	ExitDelay

SmallDelay:	
            decf	DelayCount2,F	; Inner Loop of Delay Loop
			bnz		SmallDelay
			bra 	DelayLoop
=======
            org		0x0000			; Reset/Start Vector of the microcontroller
            goto	Start
            
            org		0x0028			; Place the assembly code in memory here
            
Start:		clrf	PORTA			; Clear PORTA file register
            clrf	PORTB			; Clear PORTB file register

            movlw	0xFF			; Set PORTA to be all inputs
            movwf 	TRISA			; see page 29
            movlw	0x00			; Set PORTB RB0:RB7 as outputs for LEDs
            movwf	TRISB			; see page 31
    
WaitStart:	btfsc	PORTA,4			; S2 pressed? 
            goto 	WaitStart		; No, wait and check again
            
            movlw	0x00			; Yes, reset the count
            movwf	DisplayVal		

CountLoop:	movf	DisplayVal,W	; Get the current display value
            movwf	PORTB			; Output value on LEDs

            call 	SoftDelay		; Delay to slow down the PIC
            
            incf	DisplayVal,F	; Increment the display value
            movf	DisplayVal,W	; Get the new value
            sublw	0x10			; Has it reached max value?
            bnz		CountLoop		; No, continue incrementing			
            bra		WaitStart		; Yes, wait for S2 to start again		




SoftDelay:	clrf	DelayCount1		; Implements nested loops to slow down PIC
            movlw	0xC0
            movwf	DelayCount2

DelayLoop:	decf	DelayCount1,F	; Outer Loop of Delay Loop
            bnz		SmallDelay
            bra 	ExitDelay

SmallDelay:	decf	DelayCount2,F	; Inner Loop of Delay Loop
            bnz		SmallDelay
            bra 	DelayLoop
>>>>>>> a4760fc0c9aef589db74152ace7726e7c1ae1531:io/led-light-bar.asm

ExitDelay:	return

            END
 