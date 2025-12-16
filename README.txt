# PUISSANCE 4 – Projet Prolog

Projet de Puissance 4 réalisé en SWI-Prolog.
Il comprend le moteur de jeu, plusieurs intelligences artificielles,
une interface graphique et une suite complète de tests unitaires.

## Structure du projet

PROJET-PROLOG/
- src/
  - board.pl        : gestion du plateau (état du jeu)
  - rules.pl        : règles du jeu (coups, gravité, joueur suivant)
  - winner.pl       : détection des victoires et du match nul
  - ai.pl           : IA (random, coups gagnants, blocage)
  - minimax.pl      : IA avancée avec Minimax
  - game.pl         : boucle de jeu
  - display.pl      : affichage texte du plateau
  - interface.pl    : interface graphique (XPCE)
  - main.pl         : point d’entrée du programme
- tests/
  - test_board.pl
  - test_rules.pl
  - test_winner.pl
  - test_ai.pl
  - test_minimax.pl
  - test_game.pl
  - test_display.pl
- run_tests.pl      : lanceur de tous les tests

## Fonctionnalités

- Plateau 7x6 avec gravité
- Alternance automatique des joueurs (x / o)
- Détection des victoires :
  - verticale
  - horizontale
  - diagonale
- IA :
  - IA aléatoire
  - IA avec coups gagnants et blocage
  - IA Minimax
- Interface graphique cliquable
- Tests unitaires avec PLUnit

## Lancer le projet

1. Ouvrir SWI-Prolog à la racine du projet :
   swipl

2. Charger le programme :
   ?- [src/main].

3. Lancer l’interface graphique :
   ?- start_interface.

## Lancer les tests

Depuis la racine du projet :
swipl run_tests.pl

Résultat attendu :
All tests passed

## Tests

Les tests vérifient :
- l’initialisation et la mise à jour du plateau
- les règles du jeu
- la détection des victoires
- le comportement des IA
- le fonctionnement du minimax
- la boucle de jeu
- l’affichage

## Technologies utilisées

- SWI-Prolog
- PLUnit (tests unitaires)
- XPCE (interface graphique)

## Remarque

Le projet est modulaire, testé et extensible.
Chaque partie du jeu est isolée dans un module dédié.
