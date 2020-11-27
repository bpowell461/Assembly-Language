TARGET = fibs

$(TARGET).o: $(TARGET).asm
	nasm -f elf32 -o $(TARGET).o $(TARGET).asm
	ld -e _main -melf_i386 -o $(TARGET) $(TARGET).o

# Removes .o files and executable files
# clean:
# 	rm *.o
# 		rm $(TARGET)
#
