#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <time.h>

#define ISORD(n) !((t->tm_mday - n) % 10)
#define ISDWN t->tm_hour < 6
#define ISMRN t->tm_hour < 12
#define ISAFT t->tm_hour < 18

static void
writevsep(void)
{
	struct winsize s;
	ioctl(2, TIOCGWINSZ, &s);
	for (; s.ws_col; s.ws_col--)
		printf(s.ws_col % 2 ? "%%F{1}⊼" : "%%F{3}⊵");
}

static void
writecal(struct tm *t)
{
	char *wdays[] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"},
	     *mons[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug",
			"Sep", "Oct", "Nov", "Dec"};
	printf("%%F{1}󰸗 %%f(%s) %s %d%s", wdays[t->tm_wday], mons[t->tm_mon],
	       t->tm_mday, ISORD(1) ? "st" : ISORD(2) ? "nd" : ISORD(3) ? "rd" :
	       "st");
}

static void
writeclk(struct tm *t)
{
	printf("%%F{%d}%s%%f%02dh%02dm", ISDWN ? 5 : ISMRN ? 1 : ISAFT ? 4 : 3,
	       ISDWN ? "󰭎 " : ISMRN ? "󰖨 " : ISAFT ? " " : "󰽥 ", t->tm_hour,
	       t->tm_min);
}

int
main(void)
{
	time_t e = time(NULL);
	struct tm t;
	localtime_r(&e, &t);
	writevsep();
	writecal(&t);
	writeclk(&t);
	printf("%%F{3}⤐  %%F{1}%%1~%%f ");
	return 0;
}
