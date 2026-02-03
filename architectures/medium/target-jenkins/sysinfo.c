#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

int main() {
    // On demande les droits Root (parce que le fichier aura le bit SUID)
    setuid(0);
    setgid(0);

    printf("--- System Date Info ---\n");
    // FAILLE : On appelle "date" sans le chemin absolu (/usr/bin/date)
    // Si l'attaquant change son PATH, il peut exécuter son propre virus à la place
    system("date"); 

    return 0;
}
