<<<<<<< HEAD
; A-to-D conversion with interrupt control 
; The ADC is used to read in a voltage from a potentiometer (AN0) and the resulting number is output to PORTB 

		list 		P=18F452		
		include 	<P18F452.inc>	

DlyPar	equ			0x00			; Variable for Tacq delay routine

		org			0x0000			
		goto 		Main
		
		org 		0x0008			
		goto 		ADCisr

		org			0x0028			
		
Main:	
        clrf		PORTA			; configure i/o ports
		setf		TRISA							
		
		clrf		PORTB
		clrf		TRISB							
									

		movlw		0xC1			; configure ADC module
		movwf		ADCON0			
		movlw		0x4E			
		movwf		ADCON1			
=======
; A to D conversion with interrupt control 
; The ADC is used to read in a voltage from a pot and the resulting 10-bit number is output to PORTB 
;===========================================================================================

        list 		P=18F452		; 
        include 	<P18F452.inc>	; 

DlyPar	equ			0x00			; Variable for Tacq delay routine

        org			0x0000			; 
        goto 		Main
        
        org 		0x0008			; 
        goto 		ADCisr

        org			0x0028			; 
        
Main:	clrf		PORTA			; configure i/o ports
        setf		TRISA							
        
        clrf		PORTB
        clrf		TRISB							
                                    

        movlw		0xC1			; configure ADC module
        movwf		ADCON0			; 
        movlw		0x4E			; 
        movwf		ADCON1			; 
>>>>>>> a4760fc0c9aef589db74152ace7726e7c1ae1531

        bsf			PIR1,ADIF		; enable the A/D interrupt
        bsf			INTCON,PEIE		; enable peripheral interrupts
        bsf			INTCON,GIE		; enable global interrupts

        bsf			ADCON0,GO		; start first A/D conversion process
                
Idle:	bra			Idle			; repeat indefinitely

;------------------------------------------------------------------------------------------

<<<<<<< HEAD
ADCisr:	
        btfss		PIR1,ADIF		; is interrupt from A/D unit?
		bra			XitIsr			; no, false interrupt, abort
		movf		ADRESH,W		; yes, get MSW of A/D result
		movwf		PORTB			; display 4 LSBs on LEDs
		call 		Tacq			; yes, wait acquisition time period
		bcf			PIR1,ADIF		; reset A/D intrpt flag
		bsf			ADCON0,GO		; begin a new A/D conversion process
XitIsr:	
        retfie						; return to main prog

;------------------------------------------------------------------------------------------

Tacq:	
        movlw		0x04			; set delay to allow for
		movwf		DlyPar			; proper signal acquisition
Delay:	
        decfsz		DlyPar,F		; by allowing C_hold to 
		bra			Delay			; charge up fully before A/D conversion
		return						; return to caller	
			
;==========================================================================================
		end
=======
ADCisr:	btfss		PIR1,ADIF		; is interrupt from A/D unit?
        bra			XitIsr			; no, false interrupt, abort
        movf		ADRESH,W		; yes, get MSW of A/D result
        movwf		PORTB			; display 4 LSBs on LEDs
        call 		Tacq			; yes, wait acquisition time period
        bcf			PIR1,ADIF		; reset A/D intrpt flag
        bsf			ADCON0,GO		; begin a new A/D conversion process
XitIsr:	retfie						; return to main prog

;------------------------------------------------------------------------------------------

Tacq:	movlw		0x04			; set delay to allow for
        movwf		DlyPar			; proper signal acquisition
Delay:	decfsz		DlyPar,F		; by allowing C_hold to 
        bra			Delay			; charge up fully before A/D conversion
        return						; return to caller	
            
;===========================================================================================
        end
>>>>>>> a4760fc0c9aef589db74152ace7726e7c1ae1531
