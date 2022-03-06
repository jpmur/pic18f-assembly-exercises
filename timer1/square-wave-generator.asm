; Square wave generator using Timer1 
; Timer1 is used to implement delays to toggle a digital output to generate a square wave of specified frequency

            list 	p=18f452		
            include <p18f452.inc>	
    
            org 	0x0000
            goto 	Main
    
            org		0x0028
            
Main:		clrf	PORTB		
            movlw	0xFE			
            movwf	TRISB			
    
            movlw	0x30			; Configure Timer1 for
            movwf	T1CON			; internal clock, prescalar 1:8
    
            movlw	0x0B			; Preload 0x0BDC into TMR1
            movwf	TMR1H			; for 1Hz frequency
            movlw	0xDC
            movwf	TMR1L		
        
            bsf		T1CON,TMR1ON	

WaitLow:	btfss 	PIR1,TMR1IF		
            bra 	WaitLow			
        
            bcf		PIR1,TMR1IF		; Reset Timer1 flag
            bcf		PORTB,RB0		
            
            movlw	0x0B			
            movwf	TMR1H
            movlw	0xDC
            movwf	TMR1L		

WaitHigh:	btfss 	PIR1,TMR1IF		
            bra 	WaitHigh		
        
            bcf		PIR1,TMR1IF		
            bsf		PORTB,RB0		
            
            movlw	0x0B
            movwf	TMR1H			
            movlw	0xDC
            movwf	TMR1L		
        
            bra		WaitLow			
        
            end