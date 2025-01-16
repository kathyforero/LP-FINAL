package com.miapp.mi_servidor.Enums;

import java.util.ArrayList;

public enum MarcaDeAuto {
    AUDI("Audi", new ArrayList<String>() {
        {
            addLast("A1");
            addLast("A3");
            addLast("A4");
            addLast("Q3");
            addLast("Q5");
            addLast("Q7");
        }
    }),
    BMW("BMW", new ArrayList<String>() {
        {
            addLast("Series 1");
            addLast("Series 3");
            addLast("Series 5");
            addLast("X1");
            addLast("X3");
            addLast("X5");
        }
    }),
    CHEVROLET("Chevrolet", new ArrayList<String>() {
        {
            addLast("Spark");
            addLast("Aveo");
            addLast("Cruze");
            addLast("Sail");
            addLast("Captiva");
            addLast("Tracker");
        }
    }),
    FERRARI("Ferrari", new ArrayList<String>() {
        {
            addLast("488");
            addLast("F8");
            addLast("Roma");
            addLast("Portofino");
            addLast("SF90");
        }
    }),
    FORD("Ford", new ArrayList<String>() {
        {
            addLast("F-150");
            addLast("Ranger");
            addLast("Explorer");
            addLast("Escape");
            addLast("Mustang");
        }
    }),
    HONDA("Honda", new ArrayList<String>() {
        {
            addLast("Civic");
            addLast("CR-V");
            addLast("HR-V");
            addLast("Accord");
            addLast("Pilot");
        }
    }),
    HYUNDAI("Hyundai", new ArrayList<String>() {
        {
            addLast("Elantra");
            addLast("Tucson");
            addLast("Santa Fe");
            addLast("Kona");
            addLast("Accent");
        }
    }),
    JEEP("Jeep", new ArrayList<String>() {
        {
            addLast("Wrangler");
            addLast("Cherokee");
            addLast("Grand Cherokee");
            addLast("Compass");
            addLast("Renegade");
        }
    }),
    KIA("Kia", new ArrayList<String>() {
        {
            addLast("Rio");
            addLast("Sportage");
            addLast("Sorento");
            addLast("Seltos");
            addLast("Picanto");
        }
    }),
    LAND_ROVER("Land Rover", new ArrayList<String>() {
        {
            addLast("Range Rover");
            addLast("Discovery");
            addLast("Defender");
            addLast("Evoque");
        }
    }),
    MASERATI("Maserati", new ArrayList<String>() {
        {
            addLast("Ghibli");
            addLast("Levante");
            addLast("Quattroporte");
            addLast("GranTurismo");
            addLast("GranCabrio");
        }
    }),
    MAZDA("Mazda", new ArrayList<String>() {
        {
            addLast("Mazda2");
            addLast("Mazda3");
            addLast("Mazda6");
            addLast("CX-3");
            addLast("CX-5");
            addLast("CX-9");
        }
    }),
    MERCEDES_BENZ("Mercedes-Benz", new ArrayList<String>() {
        {
            addLast("A-Class");
            addLast("C-Class");
            addLast("E-Class");
            addLast("S-Class");
            addLast("GLA");
            addLast("GLC");
            addLast("GLE");
        }
    }),
    NISSAN("Nissan", new ArrayList<String>() {
        {
            addLast("Versa");
            addLast("Sentra");
            addLast("Altima");
            addLast("Maxima");
            addLast("Pathfinder");
            addLast("Frontier");
        }
    }),
    PEUGEOT("Peugeot", new ArrayList<String>() {
        {
            addLast("208");
            addLast("308");
            addLast("3008");
            addLast("5008");
        }
    }),
    RENAULT("Renault", new ArrayList<String>() {
        {
            addLast("Kwid");
            addLast("Duster");
            addLast("Captur");
            addLast("Logan");
            addLast("Sandero");
        }
    }),
    SOUEAST("Soueast", new ArrayList<String>() {
        {
            addLast("DX3");
            addLast("DX7");
            addLast("V5");
        }
    }),
    TOYOTA("Toyota", new ArrayList<String>() {
        {
            addLast("Corolla");
            addLast("Hilux");
            addLast("Fortuner");
            addLast("Yaris");
            addLast("Prado");
        }
    }),
    VOLKSWAGEN("Volkswagen", new ArrayList<String>() {
        {
            addLast("Polo");
            addLast("Golf");
            addLast("Passat");
            addLast("Tiguan");
            addLast("Touareg");
        }
    }),
    VOLVO("Volvo", new ArrayList<String>() {
        {
            addLast("S60");
            addLast("S90");
            addLast("XC40");
            addLast("XC60");
            addLast("XC90");
        }
    });

    private String name;
    private ArrayList<String> models;

    MarcaDeAuto(String name, ArrayList<String> models) {
        this.name = name;
        this.models = models;
    }

    public String getName() {
        return name;
    }

    public ArrayList<String> getModels() {
        return models;
    }

    @Override
    public String toString() {
        return name + " models: " + models.toString();
    }

}