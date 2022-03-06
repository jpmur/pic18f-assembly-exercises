; === Program that counts to 8 in binary on 4 LEDs ===

            list	p=18f452
            include <p18f452.inc>

DelayCount1 equ 	0x00
DelayCount2	equ		0x01 
DisplayVal	equ		0x02
TempValue	equ		0x03
            
            org		0x0000
            goto	Start
            
            org		0x0028
Start:		clrf	PORTA
            clrf	PORTB
            
            movlw	0xFF
            movwf	TRISA
            
            movlw	0x00
            movwf	TRISB
            
WaitStart:
            btfsc	PORTA,4
            goto	WaitStart
            
            movlw	0x00
            movwf	DisplayVal




CountLoop:
            movf	DisplayVal,W	
            movwf	PORTB
            
            call	SoftDelay
            call	SoftDelay
            
            movf	DisplayVal,W
            decf	DisplayVal,F
            sublw	0x10
            bz		WaitStart
            bra 	CountLoop
            
SoftDelay:	clrf	DelayCount1
            movlw	0xC0
            movwf	DelayCount2
            
DelayLoop:	decf	DelayCount1,F
            bnz		SmallDelay
            
            bra		ExitDelay
            
SmallDelay:	decf	DelayCount2,F
            bnz		SmallDelay
            bra		DelayLoop
            
ExitDelay:	Return

            END