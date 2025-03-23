.section .text
.global _start

_start:
    li a0, 2      
    li a1, 1      
    li a2, 0
    li a7, 198    
    ecall
    mv s0, a0     

    li a1, 16     
    li a7, 200    
    ecall

    li a1, 5      
    li a7, 201    
    ecall

accept_loop:
    li a7, 202    
    ecall
    mv s1, a0     

    li a1, request_buffer
    li a2, 1024
    li a7, 63     
    ecall

    la a0, request_buffer
    la a1, hex_param
    call find_substring
    beqz a0, send_

    addi a0, a0, 4
    la a1, hex_buffer
    call copy_hex_value

    la a0, hex_buffer
    la a1, text_buffer
    call hex_to_text

send_response:
    li a0, s1
    la a1, html_response
    li a2, html_size
    li a7, 64     
    ecall

    li a7, 57     
    mv a0, s1
    ecall

    j accept_loop

.data
request_buffer: .space 1024
hex_buffer: .space 256
text_buffer: .space 128

hex_param: .asciz "hex="

html_response:
    .asciz "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n"
           "<!DOCTYPE html><html><head><title>Hex to Text</title></head>"
           "<body><h2>Hex to Text Converter</h2>"
           "<form method='GET'>"
           "<input type='text' name='hex'>"
           "<button type='submit'>Convert</button>"
           "</form>"
           "<h3>Kết quả: "
text_output: .space 128
           "</h3></body></html>"

html_size = . - html_response

