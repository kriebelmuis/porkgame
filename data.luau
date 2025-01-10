return {
    "Je zit vast in John Pork's gevangenis",
    {
        dialog = "Ontsnap?",
        options = {
            ["Ja"] = {
                messages = {
                    "Je besluit te ontsnappen en begint te planen."
                }
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
    "Je bent in de gevangeniscel",
    {
        dialog = "Hoe ontsnap je?",
        options = {
            ["Slot kraken"] = {
                messages = {
                    "Je probeert het slot te kraken, maar het lukt niet. Einde."
                }
            },
            ["Gat graven"] = {
                messages = {
                    "Je begint een gat te graven onder de muur heen. . ."
                }
            }
        }
    },
    "Je ontsnapte door het gat en zit nu in John Pork's villa",
    {
        dialog = "Ontmoet je een medegevangene?",
        options = {
            ["Ja, ik ga kijken hoe het met hem gaat"] = {
                item = "bacon",
                messages = {
                    ". . .",
                    "Je ontmoet Chopped Chin!",
                    "Je gaat met hem om en ontvangt een stuk bacon als beloning!"
                }
            },
            ["Nee, ik ga alleen"] = {
                messages = {
                    "Je besluit het alleen te doen",
                    ". . ."
                },
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
                    "Je trapt de deur open, maar wordt gepakt. Einde."
                }
            },
            ["Trap de deur open"] = {
                ending = "epic win",
                messages = {
                    "Je opent de deur zonder problemen. Je bent vrij! Einde."
                }
            }
        }
    },
    "Je ziet een paar bewakers om de hoek",
    "Hoe ga je hun afleiden om verder te komen?",
    {
        dialog = "Hoe gebruik je de bacon?",
        options = {
            ["Leid bewakers af"] = {
                messages = {
                    {
                        "*je zet wat bacon midden in de kamer van de bewakers neer*",
                        "een bewaker: 'hey kijk daar is wat bacon'",
                        "een bewaker: 'wat is dat bacon?'",
                        "*je sluipt verder*"
                    },
                    {
                        "je heb geen bacon om de bewakers af te leiden"
                    }
                }
            },
            ["Verkoop aan bewakers"] = {
                required = "bacon",
                messages = {
                    {
                        "*je loop naar de bewakers*",
                        "wilt u wat bacon",
                        "hier is de bacon",
                        "oke vriend succes ermee"
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
                dead = true,
                messages = {
                    "je ben gepakt"
                }
            }
        }
    },
    "Je bent bij de kluis",
    {
        dialog = "Pak je de sleutel?",
        options = {
            ["Ja"] = {
                messages = {
                    "Je opent de kluis en vindt de masterkey."
                },
                item = "masterkey"
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
                messages = {
                    "Je gaat naar de boot. . ."
                }
            },
            ["Nee"] = {
                ending = "gevangen in villa",
                messages = {
                    "Je wordt teruggevangen. Einde."
                }
            }
        }
    },
    "Je bent bij de boot",
    {
        dialog = "Ontmoet je John Pork?",
        options = {
            ["Ja, ik praat met hem"] = {
                messages = {
                    "Je onderhandelt met Pork en krijgt toestemming om te vertrekken."
                },
                next = 12
            },
            ["Nee, ik ga direct naar de boot"] = {
                messages = {
                    "Je sprint naar de boot en slaagt erin te ontsnappen."
                },
                next = 13
            }
        }
    },
    "Je praat met John Pork",
    {
        dialog = "Hoe onderhandel je met Pork?",
        options = {
            ["Bied hem bacon aan"] = {
                messages = {
                    "Pork accepteert de bacon en laat je gaan."
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
    {
        dialog = "Neem je extra pork producten mee?",
        options = {
            ["Ja, ik neem een ham mee"] = {
                messages = {
                    "De ham zorgt voor een smakelijke reis."
                }
            },
            ["Nee, ik ga met lege handen"] = {
                ending = "pork rich",
                messages = {
                    "Je gaat met lege handen, maar bent vrij."
                }
            }
        }
    },
    "Je zet koers naar de vrijheid",
    {
        dialog = "Hoevaar je de boot?",
        options = {
            ["Snel wegvoeren"] = {
                messages = {
                    "Je vaart snel weg en ontsnappt definitief."
                }
            },
            ["Rustig wegvoeren"] = {
                messages = {
                    "Je vaart rustig weg en geniet van je vrijheid."
                }
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
                messages = {
                    "Je verkoopt de ham en bent rijk geworden, daarmee koop je een property in Egypte."
                },
                next = 17
            }
        }
    },
    "Je leeft gelukkig",
    "Made with ❤️ by the NegroTech team and executive personnel of the NegroTech company.",
}
