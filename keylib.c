/*
 * Library of keystroke handling routines.
 *
 * Robert W. Baldwin,  December 1984.
 */

#include	<stdio.h>
#include	"window.h"
#include	"terminal.h"
#include	"specs.h"


/* Keystroke table for default arrow key functionality.
 * Used by the windows that don't accept keystroke commands.
 */
keyer	arwktab[]	=	{
		{CGO_UP, jogup},
		{CGO_DOWN, jogdown},
		{CGO_LEFT, jogleft},
		{CGO_RIGHT, jogright},
		{0, NULL},
};



/* The following routines move the cursor.
 * If the cursor is still in the window, they update the
 * cursor location in the window's data structure.
 */
void jogup(gwindow *w, key k __attribute__((unused)))
{
	if (w->wcur_row > 1) {
		w->wcur_row--;
		}
	jogcursor(1);
}

void jogdown(gwindow *w, key k __attribute__((unused)))
{
	if (w->wcur_row < w->wheight) {
		w->wcur_row++;
		}
	jogcursor(2);
}

void jogleft(gwindow *w, key k __attribute__((unused)))
{
	if (w->wcur_col > 1) {
		w->wcur_col--;
		}
	jogcursor(3);
}

void jogright(gwindow *w, key k __attribute__((unused)))
{
	if (w->wcur_col < w->wwidth) {
		w->wcur_col++;
		}
	jogcursor(4);
}



/* ddokey is the lookup routine for interpreting keys.
 * It searches a table of keyer entries for one that matches the
 * given key.  If a match is found, it calls the corresponding
 * routine and returns TRUE.  Otherwise returns FALSE.
 * The end of the table is marked by an entry with a keychar = 0 or -1.
 * If it is -1, the proc in that entry will be called with the key,
 * and TRUE is returned.  If it is 0, the no-match status is returned.
 */
int ddokey(gwindow *w, key k, keyer *ktab)
{
	int	cmd;

	cmd = (k >> CMDSHIFT) & CMDMASK;
	for ( ; ktab->keychar != 0 ; ktab++ )  {
		if (ktab->keychar == cmd  ||  ktab->keychar == -1)  {
			(*(ktab->keyproc))(w, (k & CHARM));
			return(TRUE);
			}
		}

	return(FALSE);
}



/* Lookup and call a keyproc in the window's key handling table.
 */
int dokey(gwindow *w, key k)
{
	return(ddokey(w, k, w->wkeyprocs));
}
