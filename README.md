# Projet jeu Puissance 4 en  Prolog
## Hexanome 04 du groupe 2
Membres de l'hexanome :
- YOU Sylvanie
- BENAOUF Kawther Maria
- DUONG Ashley
- LE TOUZE Liam
- CHIHAB EDDINE Rim
- BINDECH Rida

## Les règles du jeu 
Règles du jeu (Puissance 4)
* Le jeu se joue sur une grille de 6 lignes et 7 colonnes
* Deux joueurs s’affrontent :
    * Joueur 1 : X
    * Joueur 2 : O
* À chaque tour, un joueur :
    * choisit une colonne
    * le pion tombe dans la case libre la plus basse
    * Un joueur gagne s’il aligne 4 pions consécutifs :
        * horizontalement
        * verticalement
        * en diagonale
* La partie se termine :
    * par une victoire
    * ou par un match nul si la grille est pleine

## Objectif du projet
L’objectif de ce projet est de concevoir un jeu Puissance 4 en Prolog, intégrant :
* une interface textuelle / graphique simple,
* différents modes de jeu,
* une ou plusieurs intelligences artificielles,
* une gestion complète des règles du jeu.

## Le jeu Puissance 4 est entièrement implémenté en Prolog
Les règles officielles du jeu sont correctement gérées :
* gravité des pions
* alternance des joueurs
* fin de partie

Plusieurs modes de jeu fonctionnels sont disponibles :
* Humain vs Humain
* Humain vs IA
* IA vs IA, avec possibilité d’utiliser :
    * deux IA du même type
    * deux IA de types différents

Plusieurs intelligences artificielles ont été implémentées :
* IA aléatoire (a1) : joue un coup valide au hasard
* IA randomPlus (a2) : amélioration de l’IA aléatoire avec une logique de choix plus pertinente
* IA Minimax : IA plus avancée utilisant un algorithme de recherche pour optimiser ses décisions

Le plateau de jeu est correctement affiché après chaque coup

Le programme détecte automatiquement :
* les coups invalides
* les conditions de victoire (horizontale, verticale et diagonale)
* les matchs nuls lorsque la grille est pleine
        
## Compilation et exécution
### Prérequis

Avoir SWI-Prolog installé
 https://www.swi-prolog.org/

### Lancer le projet
Se placer dans le dossier du projet, puis lancer SWI-Prolog .

Ce projet a deux mode (un mode console et IHM),pour lancer un des deux il faut aller dans le fichier `main.pl`
et décommenter le mode désiré et commenter l'autre.
* mode console :
    `:- initialization(start).`
* mode ui :
    `:- initialization(ui:start_menu).`

Ensuite, pour lancer l'interpreteur il faut écrire en ligne de commande : 
    `$ swipl`
puis, dans l'interpreteur on peut compiler et laner le jeu :
```
    ?- make.
    ?- [main].
```

Si  vous êtes en mode console, un menu s'affiche :
```
Choisissez le mode de jeu :
1 - Humain vs IA
2 - IA vs IA (IA Random)
3 - IA vs IA (minimax vs random)
```

Cela correspond aux différentes fonctionnalitées implémentées et décrites plus haut. Choisissez en écrivant, par exemple : `1.`, il ne faut pas oublier le point pour que Prolog comprenne la commande.

De même lorsque vous jouez une partie contre une IA, ajoutez un point après le numéro de commande.

Si vous lancez le programme en mode IHM, 2 boutons s'affichent, pour soit humain vs humain, soit humain vs ia. Par défaut c'est actuellement l'ia minimax qui est utilisée.

