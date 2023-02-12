# RaceCar - Theis Østergaard Hove, Oliver Svanholm Kliim og Frederik Benjamin Kliim
Banen er bygget op så der er to linjer. Den grønne som er den primære, og den blå som er sekundær. Den grønne er den hvor laptimes måles udfra (bortset 
fra første omgang rundt), men der skal der dog skiftes mellem at køre over en grøn og blå linje, således at bilerne ikke begynder at køre frem og tilbage 
over den grønne linje og derfor ikke får kørt en omgang rundt. Der skelnes dog ikke mellem hvilken retning bilerne kører omgangen, da dette ikke blev set
som en nødvendighed ift. opgavens problemstilling.

Bilerne er udstyret med 9 sensorer, i stedet for 3, og disse er også kortere og gør at bilerne kan køre skarpere i svingene. 
Bilernes fitness måles ud fra deres hurtigste laptime. Hvis en bil kører uden for banen, fjernes den både fra banen og muligheden for at give gener videre.

De to bedste (hurtigste) biler i en generation får deres gener blandet sammen og 100 nye biler dannes. Her muteres 85 % med en meget lav mutationsændring. 
Dette medfører at langt de fleste biler kører omtrent den samme laptime, men en høj mutationsrate gør at bilerne kan forbedre sig hurtigere.

Alt tid i programmet måles i frames så programmet virker ens på alle computere. Dette gælder både laptimes og længden af en generation som er 2000 frames, så de har noget tid til at køre banen rundt.
