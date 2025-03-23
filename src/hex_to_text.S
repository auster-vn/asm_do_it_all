.section .text
.global hex_to_text

hex_to_text:
    li t0, 0          
loop:
    lbu t1, (a0)      
    beqz t1, done     

    call hex_char_to_byte
    slli t2, t2, 4    

    lbu t1, 1(a0)     
    call hex_char_to_byte
    or t2, t2, t3     

    sb t2, (a1)       

    addi a0, a0, 2    
    addi a1, a1, 1    
    j loop

done:
    sb zero, (a1)     
    ret

hex_char_to_byte:
    li t3, 0
    blt t1, 'A', digit
    addi t1, t1, -'A' + 10
    j return

digit:
    addi t1, t1, -'0'
return:
    mv t2, t1
    ret

