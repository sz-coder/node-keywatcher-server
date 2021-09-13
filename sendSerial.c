#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
	setuid(0);
	system("/usr/bin/stty 9600 -F /dev/ttyACM0");
	system("printf \"switch\\n\" > /dev/ttyACM0");

	return EXIT_SUCCESS;
}
