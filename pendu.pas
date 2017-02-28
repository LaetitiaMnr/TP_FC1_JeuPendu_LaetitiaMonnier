program pendu; // Laetitia Monnier

uses crt;

PROCEDURE affichagePendu(vie : integer); // Procedure affichant le pendu.
VAR
	compteur : integer;
begin
	CASE vie OF
		10 : begin
				gotoxy(40, 7);
				write('_____');
			end;
		9 : begin
				FOR compteur := 3 TO 7 DO
				begin
					gotoxy(42, compteur);
					write('|');
				end;
			end;
		8 : begin
				gotoxy(42, 2);
				write('_______');
			end;
		7 : begin
				gotoxy(43, 3);
				write('/');
			end;
		6 : begin
				gotoxy(48, 3);
				write('|');
			end;
		5 : begin
				gotoxy(48, 4);
				write('O');
			end;
		4 : begin
				gotoxy(48, 5);
				write('|');
			end;
		3 : begin
				gotoxy(47, 5);
				write('/');
			end;
		2 : begin
				gotoxy(49, 5);
				write('\');
			end;
		1 : begin
				gotoxy(47, 6);
				write('/');
			end;
		0 : begin
				gotoxy(49, 6);
				write('\');
			end;
	end;
end;


FUNCTION dejaMauvaiseLettre(listeMauvaiseLettre : string; lettre : char):boolean; // Permet de ne pas recompter les lettres qui sont déjà sur la liste.
VAR
	compteur : integer;
	resultat : boolean;
begin
	resultat := FALSE;
	FOR compteur := 1 TO length(listeMauvaiseLettre) DO
		IF listeMauvaiseLettre[compteur] = lettre THEN
			resultat := TRUE;
	dejaMauvaiseLettre := resultat;
end;

PROCEDURE mauvaiseLettre(var vie : integer; var listeMauvaiseLettre : string; lettre : char); // Si la lettre n'existe pas dans le mot à deviner, on les listes.
begin
	vie := vie - 1;
	IF dejaMauvaiseLettre(listeMauvaiseLettre, lettre) = FALSE THEN
		listeMauvaiseLettre := listeMauvaiseLettre + lettre;
	gotoxy(1, 8);
	writeln('Mauvaises lettres : ', listeMauvaiseLettre);
	affichagePendu(vie);
end;

FUNCTION verifLettre(var lettresJustes : integer; longMot : integer; mot : string; var motclef : string; lettre : char):boolean; // On vérifie si la lettre fait partie du mot à deviner.
VAR
	compteur : integer;
	resultat : boolean;
begin
	resultat := FALSE;
	FOR compteur := 1 TO longMot DO
	begin
		IF mot[compteur] = lettre THEN
			IF motclef[compteur] <> lettre THEN
			begin
				lettresJustes := lettresJustes + 1;
				motclef[compteur] := lettre;
				resultat := TRUE;
			end;
	end;
	verifLettre := resultat;
end;

PROCEDURE tour(var lettresJustes : integer; longMot : integer; mot : string; var motclef : string; var vie : integer; var listeMauvaiseLettre : string); // Procedure qui gère le tour de jeu.
VAR
	lettre : char;
begin
	gotoxy(1, 4);
	write('           ');
	gotoxy(1, 4);
	readln(lettre);
	lettre := upCase(lettre);
	IF verifLettre(lettresJustes, longMot, mot, motclef, lettre) = FALSE THEN
		mauvaiseLettre(vie, listeMauvaiseLettre, lettre);
	gotoxy(1, 6);
	writeln('Mot à remplir : ', motclef);
end;

// -- Programme Principale --
VAR
	mot, motclef, listeMauvaiseLettre : string;
	longMot, lettresJustes, compteur, vie : integer;

BEGIN
	vie := 11;
	lettresJustes := 0;
	motclef := '';
	listeMauvaiseLettre := '';
	clrscr;
	writeln('-- Jeu du Pendu --');
	writeln('Entrez un mot');
	readln(mot);
	mot := upCase(mot);
	longMot := length(mot);
	FOR compteur := 1 TO longMot DO // Dans motclef, on stock '-' de la longueur du mot à deviner. Ceci est à titre esthétique.
		motclef := motclef + '-';
	clrscr;
	writeln('-- Jeu du Pendu --');
	writeln;
	writeln('Entrez une lettre');
	REPEAT
		tour(lettresJustes, longMot, mot, motclef, vie, listeMauvaiseLettre);
	UNTIL (lettresJustes = longMot) OR (vie = 0);
	gotoxy(1, 10);
	IF vie = 0 THEN
		writeln('Vous avez perdu !')
	ELSE
		writeln('Vous avez gagné !');
	readln;
END.

//ALGO : Jeu du Pendu.
//BUT : Trouver le mot caché.
//ENTREE : Une lettre.
//SORTIE : Affichage de la lettre si celle-ci est bonne, sinon, affichage du pendu.

// PROCEDURE affichagePendu(vie : ENTIER)
// VAR
// 	compteur : ENTIER
// debut
// 	CAS (vie) PARMIS
// 		10 :	gotoxy(40, 7)
// 				ECRIRE('_____')
// 		9 :		POUR compteur DE 3 A 7 FAIRE
// 					gotoxy(42, compteur)
// 					ECRIRE('|')
// 				FINPOUR
// 		8 : 	gotoxy(42, 2)
// 				ECRIRE('_______')
// 		7 : 	gotoxy(43, 3)
// 				ECRIRE('/')
// 		6 : 	gotoxy(48, 3)
// 				ECRIRE('|')
// 		5 : 	gotoxy(48, 4)
// 				ECRIRE('O')
// 		4 : 	gotoxy(48, 5)
// 				ECRIRE('|')
// 		3 : 	gotoxy(47, 5)
// 				ECRIRE('/')
// 		2 : 	gotoxy(49, 5)
// 				ECRIRE('\')
// 		1 : 	gotoxy(47, 6)
// 				ECRIRE('/')
// 		0 : 	gotoxy(49, 6)
// 				ECRIRE('\')
// 	FINCASPARMIS
// fin
//
// FONCTION dejaMauvaiseLettre(listeMauvaiseLettre : CHAINE; lettre : CHAR):BOOLEEN
// VAR
// 	compteur : ENTIER
// 	resultat : BOOLEEN
// debut
// 	resultat <-FAUX
// 	POUR compteur DE 1 A LONGUEUR(listeMauvaiseLettre) FAIRE
// 		SI listeMauvaiseLettre[compteur] = lettre ALORS
// 			resultat <- VRAIE
// 	dejaMauvaiseLettre <- resultat
// fin

// PROCEDURE mauvaiseLettre(var vie : ENTIER; var listeMauvaiseLettre : CHAINE; lettre : CHAR)
// debut
// 	vie <- vie - 1
// 	SI dejaMauvaiseLettre(listeMauvaiseLettre, lettre) = FAUX ALORS
// 		listeMauvaiseLettre <- listeMauvaiseLettre + lettre
// 	gotoxy(1, 8)
// 	ECRIRE('Mauvaises lettres : ', listeMauvaiseLettre)
// 	affichagePendu(vie)
// fin

// FONCTION verifLettre(var lettresJustes : ENTIER; longMot : ENTIER; mot : CHAINE; var motclef : CHAINE; lettre : CHAR):BOOLEEN
// VAR
// 	compteur : ENTIER
// 	resultat : BOOLEEN
// debut
// 	resultat <- FAUX
// 	POUR compteur DE 1 A longMot FAIRE
// 	begin
// 		SI mot[compteur] = lettre ALORS
// 			SI motclef[compteur] <> lettre ALORS
// 				lettresJustes <- lettresJustes + 1
// 				motclef[compteur] <- lettre
// 				resultat <- VRAIE
// 			FINSI
// 	FINPOUR
// 	verifLettre <-resultat
// fin

// PROCEDURE tour(var lettresJustes : ENTIER; longMot : ENTIER; mot : CHAINE; var motclef : CHAINE; var vie : ENTIER; var listeMauvaiseLettre : CHAINE)
// VAR
// 	lettre : CHAR
// debut
// 	gotoxy(1, 4)
// 	ECRIRE('           ')
// 	gotoxy(1, 4)
// 	LIRE(lettre)
// 	lettre <- upCase(lettre)
// 	SI verifLettre(lettresJustes, longMot, mot, motclef, lettre) = FAUX ALORS
// 		mauvaiseLettre(vie, listeMauvaiseLettre, lettre)
// 	gotoxy(1, 6)
// 	ECRIRE('Mot à remplir : ', motclef)
// fin

// VAR
// 	mot, motclef, listeMauvaiseLettre : CHAINE
// 	longMot, lettresJustes, compteur, vie : ENTIER

// BEGIN
// 	vie <- 11
// 	lettresJustes <- 0
// 	motclef <- ''
// 	listeMauvaiseLettre <- ''
// 	Mettre un clrscr ici.
// 	ECRIRE('-- Jeu du Pendu --')
// 	ECRIRE('Entrez un mot')
// 	LIRE(mot)
// 	mot <- upCase(mot)
// 	longMot <- LONGUEUR(mot);
// 	POUR compteur DE 1 A longMot FAIRE
// 		motclef <- motclef + '-'
// 	Mettre un clrscr ici.
// 	ECRIRE('-- Jeu du Pendu --')
// 	ECRIRE('Entrez une lettre')
// 	REPETER
// 		tour(lettresJustes, longMot, mot, motclef, vie, listeMauvaiseLettre)
// 	JUSQU'A (lettresJustes = longMot) OR (vie = 0)
// 	gotoxy(1, 10)
// 	SI vie = 0 ALORS
// 		writeln('Vous avez perdu !')
// 	SINON
// 		writeln('Vous avez gagné !')
// 	FINSI
// FIN.

// Déroulement de jeu :
// Entrez un mot
// mot <- licorne
// (clrscr)
// motclef <- -------
// Entrez une lettre
// lettre <- l
// lettresJustes <- l
// motclef <- L------
// Entrez une lettre
// lettre <- a
// listeMauvaiseLettre <- a
// vie <- 11 - 1
// (Affichage du pendu sur le coté droit)
// etc...