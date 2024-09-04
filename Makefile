CPP = $(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as
LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld

SRC=main.c feature.c
OBJS=$(patsubst %.c,%.o,$(SRC))

.PHONY: clean all

all: firmware.elf

firmware.elf: $(OBJS)
	$(LD) -o $@ $^

%.i: %.c
	$(CPP) $< > $@

%.s: %.i
	$(CC) -S $<

%.o: %.s
	$(AS) $< -o $@

hello.txt:
	echo "hello world!" > hello.txt

clean:
	rm -f *.i *.elf *.o *.s hello.txt