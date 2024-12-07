% PUNTO 1
vive(juan, casa(120)).
vive(nico, departamento(3,2)).
vive(alf, departamento(3,1)).
vive(julian, loft(2000)).
vive(vale, departamento(4,1)).
vive(fer, casa(110)).

barrio(alf, almagro).
barrio(juan, almagro).
barrio(nico, almagro).
barrio(julian, almagro).
barrio(vale, flores).
barrio(fer, flores).

% PUNTO 2
esBarrioCopado(Barrio):-
    barrio(_, Barrio),
    forall(barrio(Persona, Barrio), tienePropiedadCopada(Persona)).

tienePropiedadCopada(Persona):-
    vive(Persona, casa(MetrosCuadrados)),
    MetrosCuadrados > 100.
tienePropiedadCopada(Persona):-
    vive(Persona, departamento(Ambientes, _)),
    Ambientes > 3.
tienePropiedadCopada(Persona):-
    vive(Persona, departamento(_, Banios)),
    Banios > 1.
tienePropiedadCopada(Persona):-
    vive(Persona, loft(AnioDeConstruccion)),
    AnioDeConstruccion > 2015.

% PUNTO 3
esBarrioCaro(Barrio):-
    barrio(_, Barrio),
    not((barrio(Persona, Barrio), tienePropiedadBarata(Persona))).

tienePropiedadBarata(Persona):-
    vive(Persona, loft(AnioDeConstruccion)),
    AnioDeConstruccion < 2005.
tienePropiedadBarata(Persona):-
    vive(Persona, casa(MetrosCuadrados)),
    MetrosCuadrados < 90.
tienePropiedadBarata(Persona):-
    vive(Persona, departamento(Ambientes, _)),
    Ambientes < 3.

% PUNTO 4
tasacion(juan, 150000).
tasacion(nico, 80000).
tasacion(alf, 75000).
tasacion(julian, 140000).
tasacion(vale, 95000).
tasacion(fer, 60000).

sublista([],[]).
sublista([_|Cola], Sublista):-sublista(Cola,Sublista).
sublista([Cabeza|Cola],[Cabeza|Sublista]):-sublista(Cola,Sublista).

opcionesDeCompra(Dinero, DueniosDePropiedades, Resto):-
    posiblesPropiedades(DueniosDePropiedades),
    valorDeLasPropiedades(DueniosDePropiedades, ValorTotal),
    Dinero > ValorTotal,
    Resto is Dinero - ValorTotal.
    
posiblesPropiedades(CombinacionesDeDuenios):-       
    findall(Persona, vive(Persona, _), TodosLosDuenios),
    sublista(TodosLosDuenios, CombinacionesDeDuenios).
    
valorDeLasPropiedades(DueniosDePropiedades, ValorTotal):-
    findall(Valor, valorDeCadaPropiedad(DueniosDePropiedades, Valor), ValorPorPropiedad),
    sum_list(ValorPorPropiedad, ValorTotal).

valorDeCadaPropiedad(Duenios, ValorPorPropiedad):-
    member(Duenio, Duenios), 
    tasacion(Duenio, ValorPorPropiedad).