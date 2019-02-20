padece(manuel, gripe)
padece(manuel, hepatitis)
padece(ana, gripe)

# Pregunta que padece manuel: padece(manuel, E)
# padece(P1, E), padece(P2, E), devuelve ana y manuel

# Sintomas
# S es sintoma de E
# sintoma(S, E)
sintoma(fiebre, gripe)
sintoma(cansancio, hepatitis)
sintoma(diarrea, intoxicacion)

# Medicamentos
# M suprime el sintoma S
# suprime(S, E)
suprime(aspirina, fiebre)
suprime(lomotil, diarrea)


# En el enunciado * no son hechos sino relaciones
# Vamos a definir dichas relaciones
# Primero obtenemos el sintoma de E y lo guardamos en S
# Luego comprobamos si el medicamento(M) suprime al sintoma(S)
# Ojo a la coma y el punto
alivio(M, E) :-
    sintoma(S, E),
    suprime(M, S).

# Segunda relacion
# P es el nombre de la persona
debe_tomar(P, M) :-
    alivio(M, E),
    padece(P, E).

# Ahora podemos preguntar que medicamentos alivia la hepatitis, gripe...:
# alivia(M, hepatitis) -> devuelve no === No hay ningun medicamento
# alivia(M, gripe) -> devuelve aspirina
# Tmb podemos preguntar por la intoxicaion. Que medicamento alivia eso?
# alivia(M, intoxicacion)
# Podemos preguntar si:
# alivia(lomotil, intoxicacion) -> devuelve si
# alivia(ibuprofeno, fiebre) -> No, porque no hay reglas con ibuprofeno


# primera pregunta. Asumimos que dolecia === enfermedad
# padece(manuel, X).
# padece(ana, X).

# segunda pregunta
# padece(P, gripe).

# tercera pregunta
# padece(jose, E), sintoma(S, E).

# cuarta pregunta. Se prodía hacer al reves. Primero padece y luego sintoma
# sintoma(diarrea, E), padece(P, E).

# quinta pregunta
# sintoma(cansado, E), padece(P, E).

# sexta pregunta
# padece(manuel, E), sintoma(S, E), alivio(M, E)!!No se si esta bien
# Respuesta oficial: alivia(M, E), produce(manuel, E). 
# O bien:            debe_tomar(manuel, M).

# septima pregunta
# Posible respuesta: padece(Ignacio, E), padece(ana, E), sintoma(S, E).
# se asume que una enfermedad esta asociada a un solo sintoma, y eso no es correcto
# Para evitar eso: 
# padece(Ignacio, E1), padece(ana, E2), sintoma(S, E1), sintoma(S, E2).


# conclusion
# Hay dividir el codigo en: base de hechos y relaciones