# Testplan voor CLI Game

## Testomgevingen
- Besturingssystemen: Windows, Linux, MacOS
- CLI-omgevingen: Windows Terminal, Bash
- Programmeertaal: Lua

## Testgevallen

### 1. Algemene functionaliteit

| Testgeval | Beschrijving | Verwacht resultaat |
|-----------|--------------|--------------------|
| 1.1 Start spel | Start de game via de CLI | Saving werkt correct |
| 1.2 Begin verhaal | Speler begint het verhaal | Eerste dialoog verschijnt correct |
| 1.3 Quit game | Speler kiest om het spel te verlaten | Het spel wordt correct afgesloten |

### 2. Verhaallijnen en keuzes

| Testgeval | Beschrijving | Verwacht resultaat |
|-----------|--------------|--------------------|
| 2.1 Ontsnap poging | Speler kiest om te ontsnappen | Juiste dialoog en opties verschijnen |
| 2.2 Blijf gevangen | Speler kiest om in de gevangenis te blijven | Ending "gevangen blijven" verschijnt correct |
| 2.3 Slot kraken | Speler kiest om het slot te kraken | Ending "gepakt slot" verschijnt correct |
| 2.4 Gat graven | Speler kiest om een gat te graven | Juiste dialoog en opties verschijnen |
| 2.5 Ontmoet medegevangene | Speler kiest om een medegevangene te ontmoeten | Speler ontvangt item "bacon" |
| 2.6 Keuken doorzoeken | Speler kiest om naar de keuken te gaan | Speler ontvangt item "sleutelbos" |
| 2.7 Slaapkamer doorzoeken | Speler kiest om naar de slaapkamer te gaan | Ending "gepakt slapende pork" verschijnt correct |
| 2.8 Deur openen | Speler kiest hoe de deur te openen | Juiste dialoog en opties verschijnen |
| 2.9 Bewakers afleiden | Speler kiest hoe de bewakers af te leiden | Juiste dialoog en opties verschijnen |
| 2.10 Sleutel pakken | Speler kiest om de verdachte sleutel te pakken | Speler ontvangt item "boatkey" |
| 2.11 Boot gebruiken | Speler kiest om de boot te gebruiken | Juiste dialoog en opties verschijnen |
| 2.12 Extra pork meenemen | Speler kiest om extra pork producten mee te nemen | Speler ontvangt item "bacon" |
| 2.13 Onderhandelen met John Pork | Speler kiest om te onderhandelen met John Pork | Juiste dialoog en opties verschijnen |
| 2.14 Boot varen | Speler kiest hoe de boot te varen | Juiste dialoog en opties verschijnen |
| 2.15 Ham gebruiken | Speler kiest hoe de ham te gebruiken | Juiste dialoog en opties verschijnen |

### 3. Eindes en uitkomsten

| Testgeval | Beschrijving | Verwacht resultaat |
|-----------|--------------|--------------------|
| 3.1 Succesvolle ontsnapping | Speler ontsnapt succesvol | Ending "Je bent succesvol ontsnapt" verschijnt correct |
| 3.2 Gevangen genomen | Speler wordt gevangen genomen | Ending "gevangen in villa" verschijnt correct |
| 3.3 Vervloekt door JP | Speler eet de ham | Ending "cursed" verschijnt correct |
| 3.4 Rijk geworden | Speler verkoopt de ham | Ending "Je leeft gelukkig" verschijnt correct |
| 3.5 Gedood door John Pork | Speler wordt gedood door John Pork | Ending "Je bent gedood door John Pork" verschijnt correct |
