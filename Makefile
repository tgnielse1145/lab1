#hello.txt:
#	echo "hello world!" > hello.txt

CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as
LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ls

SRC=main.c second.c
OBJS=$(patsubst %.c,%.o,$(SRC))

all: firmware.elf

clean:
	rm -f *.i *.s *.o *.elf *.img

#clean:
#	rm -f main.i hello.txt

#main.s: main.i
#	$(CC) -S main.i

#main.o: main.s
#	$(AS) main.s -o main.o

hello.txt:
	echo "hello world!" > hello.txt

%.i: %.c
	$(CPP) $< > $@

%.s: %.i
	$(CC) -S $<

%.o: %.s
	$(AS) $< -o $@

%.elf: %.o
	$(LD) $< -o $@

OBJS=main.o

#main.i: main.c
#	$(CPP) main.c > main.i

firmware.elf: $(OBJS)
	$(LD) -o $@ $^

%.img: %.elf
	$(OBJCOPY) $< -O binary $@

#clean:
#	rm -f main.i hello.txt

.PHONY: all clean