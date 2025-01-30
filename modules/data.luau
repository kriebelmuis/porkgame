return {
    "Word wakker %s...",
    "Je zit vast in John Pork's gevangenis",
    {
        dialog = "Ontsnap?",
        options = {
            ["Ja"] = {
                "Je besluit te ontsnappen en begint te planen."
            },
            ["Nee"] = {
                ending = "gevangen blijven",
                messages = {
                    "Je blijft in de gevangenis ongevoed voor jaren lang.",
                    "John Pork is een duistere man en je moet hem niet vergeten."
                }
            }
        }
    },
    "Je bent in een gevangeniscel",
    {
        dialog = "Hoe ontsnap je?",
        options = {
            ["Slot kraken"] = {
                ending = "gepakt slot",
                messages = {
                    "Je probeert het slot te kraken, maar een bewaker betrapt je."
                }
            },
            ["Gat graven"] = {
                "Je begint een gat te graven onder de muur heen. . ."
            }
        }
    },
    "Je ontsnapte door het gat en zit nu in John Pork's villa",
    {
        dialog = "Ontmoet je een medegevangene?",
        options = {
            ["Ja"] = {
                item = "bacon",
                messages = {
                    ". . .",
                    "Je ontmoet Chopped Chin!",
                    "Je gaat met hem om en ontvangt een stuk bacon als beloning!"
                }
            },
            ["Nee"] = {
                "Je besluit het alleen te doen",
                ". . ."
            }
        }
    },
    "Je bent in de villa",
    {
        dialog = "Waar ga je als eerst heen?",
        options = {
            ["De keuken"] = {
                item = "sleutelbos",
                messages = {
                    "Je vindt een sleutel in de keuken, bij de ham."
                }
            },
            ["Een slaapkamer"] = {
                ending = "gepakt slapende pork",
                messages = {
                    "*je doet de deur op een kier open*",
                    "Je hoort iemand snurken?",
                    "Is het de legende John Pork?",
                    "Je de deur open en sluipt door de slaapkamer.",
                    "*pakt rustig de sleutel in de slaapkamer*",
                    "*knor*",
                    "*je draait jezelf rustig om*",
                    "John Pork: 'En wat doe jij hier knul?'"
                }
            }
        }
    },
    "Je bent bij de voordeur",
    {
        dialog = "Hoe open je de deur?",
        options = {
            ["Sloom deur openen"] = {
                ending = "gepakt bij deur",
                messages = {
                    "Je doet sloom de deur open maar het alarm gaat af en kort daarna ben je gepakt. Einde."
                }
            },
            ["Trap de deur open"] = {
                "Je opent de deur zonder problemen. Je bent eindelijk buiten!",
                "Maar je ben nog niet van John Pork eiland af!"
            }
        }
    },
    "Je ziet een paar bewakers om de hoek",
    {
        dialog = "Hoe ga je hun afleiden om verder te komen?",
        options = {
            ["Leid bewakers af door bacon"] = {
                required = "bacon",
                ending = "fail afleiding bacon",
                messages = {
                    {
                        "*je zet wat bacon midden in de kamer van de bewakers neer*",
                        "een bewaker: 'hey kijk daar is wat bacon'",
                        "een bewaker: 'wat is dat bacon?'",
                        "*je sluipt verder*"
                    },
                    {
                        "je heb geen bacon om de bewakers af te leiden",
                        "je word snel terug in je cel gezet"
                    }
                }
            },
            ["Verkoop bacon aan bewakers"] = {
                required = "bacon",
                ending = "fail verkopen bacon",
                messages = {
                    {
                        "*je loop naar de bewakers*",
                        "jij: wilt u wat bacon",
                        "hier is de bacon",
                        "bewaker: oke vriend, succes met je ontsnapping"
                    },
                    {
                        "*je loop naar de bewakers*",
                        "wilt u wat bacon",
                        "waar is de bacon dan?",
                        ". . .",
                        "*je ben dood*"
                    }
                }
            },
            ["Sluip verder"] = {
                ending = "de sluiper",
                messages = {
                    "je ben gepakt door de bewakers"
                }
            }
        }
    },
    "Je bent bij de kluis",
    {
        dialog = "Pak je de sleutel?",
        options = {
            ["Ja"] = {
                item = "masterkey",
                messages = {
                    "Je opent de kluis en vindt de masterkey."
                }
            },
            ["Nee"] = {
                ending = "geen sleutel",
                messages = {
                    "Zonder sleutel kom je niet verder. Einde."
                }
            }
        }
    },
    "Je hebt de masterkey",
    {
        dialog = "Ga je naar de boot?",
        options = {
            ["Ja"] = {
                "Je gaat naar de boot. . ."
            },
            ["Nee"] = {
                ending = "gevangen in villa",
                messages = {
                    "Je wordt teruggevangen. Einde."
                }
            }
        }
    },
    "Je vind meer pork in de boot!",
    {
        dialog = "Neem je extra pork producten mee?",
        options = {
            ["Ja, ik neem een ham mee"] = {
                item = "bacon",
                messages = {
                    "De ham zorgt voor een smakelijke reis!"
                }
            },
            ["Nee, ik ga met lege handen"] = {
                "Je gaat met lege handen."
            }
        }
    },
    {
        dialog = "Wil je met DE John Pork onderhandelen?",
        options = {
            ["Ja, onderhandel met hem"] = {
                "Je gaat naar John Pork toe op het andere eiland met je boot"
            },
            ["Nee, ontsnap met de boot"] = {
                ending = "no talk",
                messages = {
                    "John Pork vond dat geen goed plan. Bewakers hebben je weer gevangen genomen."
                }
            }
        }
    },
    {
        dialog = "Hoe onderhandel je met Pork?",
        options = {
            ["Bied hem bacon aan"] = {
                required = "bacon",
                ending = "no porky",
                messages = {
                    {
                        "Pork accepteert de bacon en laat je gaan."
                    },
                    {
                        "Je heb geen pork!",
                        "Pork vermoord je"
                    }
                }
            },
            ["Dreig hem met de masterkey"] = {
                ending = "pork is bang",
                messages = {
                    "Pork is boos omdat je zijn sleutel hem en maakt je dood."
                }
            }
        }
    },
    "Je bent aan boord van de boot",
    "Je zet koers naar de vrijheid",
    {
        dialog = "Hoevaar je de boot?",
        options = {
            ["Snel wegvoeren"] = {
                "Je vaart snel weg en ontsnapt definitief."
            },
            ["Rustig wegvoeren"] = {
                "Je vaart rustig weg en geniet van je vrijheid."
            }
        }
    },
    "Je bent succesvol ontsnapt",
    {
        dialog = "Hoe gebruik je de ham?",
        options = {
            ["Maak een maaltijd"] = {
                ending = "cursed",
                messages = {
                    "Je eet de ham",
                    "je ben vervloekt door de JP"
                }
            },
            ["Verkoop aan de eerste de beste"] = {
                "Je verkoopt de ham en bent rijk geworden, daarmee koop je een property in Egypte."
            }
        }
    },
    "Je leeft gelukkig",
    "Made with ❤️ by the NegroTech team and executive personnel of the NegroTech company.",
}
