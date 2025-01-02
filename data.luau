return {
    "*je word wakker*",
    ". . .",
    "het lijkt net alsof je in een gevangenis cel zit",
    "je ziet een cel deur, een raam en een bed om je heen",
    {
        dialog = "wat ga je doen?",
        options = {
            ["proberen cel deur openen"] = {
                required = "cel sleutel",
                flag = true,
                messages = {
                    {
                        "*je probeert de cel deur te openen*",
                        ". . .",
                        "de cel deur zit op slot",
                        "je kan de cel deur niet openen",
                    },
                    {
                        "*je gebruikt de cel sleutel*",
                        ". . .",
                        "de cel deur gaat open"
                    }
                }
            },
            ["door het raam kijken"] = {
                "*je kijkt door het raam*",
                ". . .",
                "je ziet een paar bewakers lopen",
                "ze hebben een opvallende sleutelbos bij zich, misschien moet ik dat onthouden",
            },
            ["op het bed gaan liggen"] = {
                item = "cel sleutel",
                messages = {
                    {
                        "*je gaat op bed liggen*",
                        ". . .",
                        "je vind een envelop onder jouw kussen",
                        "*je doet hem open*",
                        ". . .",
                        "er zit een sleutel in!",
                    },
                    {
                        "*je gaat op bed liggen*",
                        ". . ."
                    }
                }
            }
        }
    },
    "*opent deur met sleutel*",
    ". . .",
}