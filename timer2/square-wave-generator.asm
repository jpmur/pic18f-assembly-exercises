; Square wave generator using Timer1	
; Timer2 is used to generate interrupts to toggle a digital output to generate a square wave of specified frequency
            
            list 	P=18F452			;
            include	<P18F452.inc>		;
        
             org 	0x0000				;
            goto 	Main				;

            org 	0x0008				;
            goto 	Tmr2isr				;

<<<<<<< HEAD
			org		0x0028				;
			
Main:		
            clrf	PORTB				; Config I/O port
			movlw	0xF7
			movwf	TRISB
										; to control LED, D5
			movlw	0x08				; Configure Timer2 - turned off initially 
			movwf	T2CON				; with prescale and postscale of 1:1
=======
            org		0x0028				;
            
Main:		clrf	PORTB				; Config I/O port
            movlw	0xF7
            movwf	TRISB
                                        ; to control LED, D5
            movlw	0x08				; Configure Timer2 - turned off initially 
            movwf	T2CON				; with prescale and postscale of 1:1
>>>>>>> a4760fc0c9aef589db74152ace7726e7c1ae1531

            movlw	0x1F4				; Set Timer2 period register 
            movwf	PR2					; for delay of ______
                     
            bsf		PIE1,TMR2IE			; Enable Timer2 interrupts
            bsf		INTCON,PEIE			; Enable peripheral interrupts
            bsf		INTCON,GIE			; Enable global interrupts
            bcf		PIR1,TMR2IF			; Reset Timer2 interrupt flag initially

<<<<<<< HEAD
			bsf		T2CON,TMR2ON		; Turn on Timer2
Idle:		
            bra		Idle				; Do nothing – in practice there would 
										; be useful stuff here 		
;----------------------------------------------------------------------------------

Tmr2isr:	
            btfss	PIR1,TMR2IF			; Is this interrupt from Timer 2? 
			bra		Xitisr				; No, false interrupt, abort ISR
			btg		PORTB,RB3			; Yes, _____________	   (30 kHz on D5!!)
			bcf		PIR1,TMR2IF			; Reset Timer 2 interrupt flag
Xitisr:		
            retfie						; Exit ISR and resume main prog
=======
            bsf		T2CON,TMR2ON		; Turn on Timer2
Idle:		bra		Idle				; Do nothing ï¿½ in practice there would 
                                        ; be useful stuff here 		
;----------------------------------------------------------------------------------

Tmr2isr:	btfss	PIR1,TMR2IF			; Is this interrupt from Timer 2? 
            bra		Xitisr				; No, false interrupt, abort ISR
            btg		PORTB,RB3			; Yes, _____________	   (30 kHz on D5!!)
            bcf		PIR1,TMR2IF			; Reset Timer 2 interrupt flag
Xitisr:		retfie						; Exit ISR and resume main prog
>>>>>>> a4760fc0c9aef589db74152ace7726e7c1ae1531

;==================================================================================

            end