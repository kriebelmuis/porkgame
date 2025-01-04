return {
    "onbekende stem: 'word wakker, %s...'",
    "*je wordt wakker*",
    "waar ben ik? ik kan me niks herinneren...",
    ". . .",
    "het lijkt erop dat ik in een gevangeniscel zit",
    "ik zie een celdeur, een raam en een bed om mij heen",
    {
        dialog = "hoe ga ik ontsnappen?",
        options = {
            ["probeer de celdeur te openen"] = {
                required = "cel sleutel",
                messages = {
                    {
                        "*je probeert de celdeur te openen*",
                        ". . .",
                        "de celdeur zit op slot",
                        "je kunt de celdeur niet openen",
                    },
                    {
                        "*je gebruikt de celsleutel*",
                        ". . .",
                        "*de metalen celdeur piept luid*",
                        "de celdeur gaat open!",
                    }
                }
            },
            ["kijk door het raam"] = {
                "*je kijkt door het raam*",
                ". . .",
                "je ziet een paar bewakers lopen",
                "ze hebben een opvallende sleutelbos bij zich, misschien moet ik dat onthouden",
            },
            ["ga op het bed liggen"] = {
                item = "cel sleutel",
                cannotSkip = true,
                messages = {
                    {
                        "*je gaat op het bed liggen*",
                        ". . .",
                        "je voelt iets onder het kussen",
                        "*je vindt een envelop*",
                        ". . .",
                        "er zit een sleutel in!",
                    },
                    {
                        "*je gaat op het bed liggen*",
                        ". . .",
                        "er is niets bijzonders te vinden",
                    }
                }
            }
        }
    },
    "je ontsnapte uit de cel, je zit in een soort kelder",
    "je neem de trap naar boven",
    "de hoofddeur naar buiten is verassend genoeg niet op slot",
    "*doet de deur open*",
    ". . .",
    "opeens ben je in een grote gang terecht",
    "je wandel rustig door de gangen, er zijn allemaal vasen op tafeltjes te vinden",
    "en schilderijen aan de muur",
    "je hoort stemmen in de verte, mogelijk bewakers",
    "*je verstopt je achter een tafeltje met vasen*",
    "relaxde bewaker: 'ey heb je laatst die nieuwe serie bekeken?'",
    "bewaker met bril: 'nee, ik kijk eigenlijk een series. ik lees alleen boeken'",
    "relaxde bewaker: 'boeken? wat ben jij? een fucking nerd? *slaat bewaker met bril op rug*'",
    "*een sleutelbos valt op de grond*",
    "het lijkt alsof de bewakers niet door hadden dat ze hun sleutelbos lieten vallen",
    "zou ik de sleutelbos op pakken? of is dat te gevaarlijk?",
    {
        dialog = "pak je de sleutelbos op?",
        options = {
            ["laat de sleutelbos liggen"] = {
                ending = "gepakt door camera",
                messages = {
                    "je loopt verder door de gang",
                    ". . .",
                    "*piep* *piep* *piep*",
                    "wat hoor ik piepen?",
                    "*je kijkt achter je*",
                    "een camera heeft je door!"
                }
            },
            ["pak de sleutelbos op"] = {
                item = "sleutelbos",
                messages = {
                    "*je pakt de sleutelbos op*",
                    ". . .",
                    "je loopt verder door de gang",
                }
            }
        }
    },
    "je vind een geheime doorgang achter een schilderij",
    ". . .",
    "je denk dat je veilig ben",
    "je loopt door de geheime doorgang en komt in een geheime kamer terecht",
    "er ligt overal goud en juwelen",
    {
        dialog = "neem je goud en juwelen mee?",
        options = {
            ["neem wat goud en juwelen mee"] = {
                messages = {
                    "*je neemt wat goud en juwelen mee*",
                    ". . .",
                    "de juwelen zijn erg zwaar, maar je wil ze wel heel graag mee nemen",
                    ". . .",
                    "we nemen ze toch wel mee!",
                    "*doet schilerij terug*"
                },
                item = "juwelen",
            },
            ["laat de goud en juwelen liggen"] = {
                "vaarwel permanente fincaniele onafhankelijkheid",
                "*zucht*",
                "*doet schilderij terug*",
                ". . ."
            },
        }
    },
    "je loopt verder en vind een kluisdeur, wat zou hierin kunnen zijn?",
    ". . .",
    "naast de kluisdeur staat een cijferslot, weet jij de code?",
    {
        dialog = "welke code ga je proberen?",
        options = {
            ["probeer 3850"] = {
                ending = "boem",
                messages = {
                    "*je toetst de 4 nummers in*",
                    ". . .",
                    "explosieven ontploffen in de kluis",
                    "*je ziet opeens niets meer*",
                    ". . ."
                }
            },
            ["probeer 5736"] = {
                ending = "boem",
                messages = {
                    "*je toetst de 4 nummers in*",
                    ". . .",
                    "explosieven ontploffen in de kluis",
                    "*je ziet opeens niets meer*",
                    ". . ."
                }
            },
            ["probeer 5385"] = {
                ending = "gepakt bij kluis",
                messages = {
                    "*je toetst de 4 nummers in*",
                    ". . .",
                    "pling! de kluisdeur gaat open",
                    "bewaker achter je: 'hey! wat doe jij hier?'",
                }
            },
            ["loop verder"] = {
                "*je toetst de 4 nummers in*",
                ". . .",
                "explosieven ontploffen in de kluis",
                "*je ziet opeens niets meer*",
                ". . ."
            },
        },
    },
    "je heb nog een deur gevonden! zou dit de uitgang kunnen zijn?",
    {
        dialog = "open de deur?",
        options = {
            ["open de deur"] = {
                required = "sleutelbos",
                messages = {
                    {
                        "*duwt sleutel in de deur*",
                        ". . .",
                        "*klik* de deur is ontgrendeld!",
                    },
                    {
                        "*je opent de deur*",
                        ". . ."
                    }
                }
            }
        }
    },
    {
        dialog = "hoe ga je de deur open maken?",
        options = {
            ["trap de deur open"] = {
                "*je trapt de deur open met all jouw kracht*",
                ". . .",
                "de deur vliegt open, maar maakt opvallend weinig geluid",
            },
            ["duw de deur zachtjes open"] = {
                ending = "gepakt bij deur",
                messages = {
                    "*Je duwt de deur zachtjes open.*",
                    ". . .",
                    "het alarm gaat af!",
                    "er zit in een bewaker achter je aan!",
                    "relaxde bewaker: 'stop! in naam van de wet!'",
                    "*je blijf rennen*",
                    "de bewaker ontlaad zijn volledige magazine in je rug",
                    "*je valt dood neer door bloed verlies*"
                }
            }
        }
    },
    "je ziet een bewaker naast een boot in de verte",
}