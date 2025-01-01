return {
    "*je kijk om je heen*",
    ". . .",
    "het lijkt net alsof je in een gevangenis cel zit",
    "je ziet een cel deur, een raam en een bed om je heen",
    {
        dialog = "wat wil je doen?",
        options = {
            {
                option = "proberen cel deur openen",
                required = "cel sleutel",
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
            {
                option = "door het raam kijken",
                messages = {
                    "*je kijkt door het raam*",
                    ". . .",
                    "je ziet een gang met een paar zwaar bewapende bewakers lopen",
                    "je kan niet naar buiten",
                }
            },
            {
                option = "op het bed gaan liggen",
                item = "cel sleutel",
                messages = {
                    "*je gaat op bed liggen*",
                    ". . .",
                    "je vind een envelop onder jouw kussen",
                    "*je doet hem open*",
                    ". . .",
                    "er zit een sleutel in!",
                }
            },
        }
    }
}