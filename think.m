% Script de Comparación de Algoritmos: Binaria vs Fibonacci
clear; clc;

% 1. Ingreso de datos por teclado
fprintf("--- CONFIGURACIÓN DEL EXPERIMENTO ---\n");
n = input("Ingrese el tamaño del arreglo (N): ");
objetivo = input("Ingrese el valor que desea buscar: ");

% Generar el arreglo ordenado (del 1 al N)
datos = 1:n;

fprintf("\nIniciando procesamiento...\n");

% ---------------------------------------------------------
% 2. BÚSQUEDA BINARIA
% ---------------------------------------------------------
bajo = 1;
alto = n;
pasos_bin = 0;
pos_bin = -1;

while bajo <= alto
    pasos_bin = pasos_bin + 1;
    medio = floor((bajo + alto) / 2);
    
    if datos(medio) == objetivo
        pos_bin = medio;
        break;
    elseif datos(medio) < objetivo
        bajo = medio + 1;
    else
        alto = medio - 1;
    end
end

% ---------------------------------------------------------
% 3. BÚSQUEDA DE FIBONACCI
% ---------------------------------------------------------
% Preparar números de Fibonacci
f2 = 0; 
f1 = 1; 
fm = f2 + f1; 

while (fm < n)
    f2 = f1;
    f1 = fm;
    fm = f2 + f1;
end

offset = 0;
pasos_fibo = 0;
pos_fibo = -1;

while (fm > 1)
    pasos_fibo = pasos_fibo + 1;
    % Cálculo del índice usando el número de Fibonacci menor
    i = min(offset + f2, n);
    if i <= 0; i = 1; end % Paracaídas para índice 0
    
    if (datos(i) < objetivo)
        % Desplazar rango a la derecha
        fm = f1;
        f1 = f2;
        f2 = fm - f1;
        offset = i;
    elseif (datos(i) > objetivo)
        % Reducir rango a la izquierda
        fm = f2;
        f1 = f1 - f2;
        f2 = fm - f1;
    else
        pos_fibo = i;
        break;
    end
end

% ---------------------------------------------------------
% 4. PRESENTACIÓN DE RESULTADOS
% ---------------------------------------------------------
fprintf("\n==========================================\n");
fprintf("         RESULTADOS DE LA BÚSQUEDA         \n");
fprintf("==========================================\n");
fprintf("Objetivo buscado: %d\n", objetivo);
fprintf("Tamaño del arreglo: %d\n", n);
fprintf("------------------------------------------\n");

if pos_bin != -1
    fprintf("BÚSQUEDA BINARIA:\n");
    fprintf("  - Estado: ENCONTRADO\n");
    fprintf("  - Posición: %d\n", pos_bin);
    fprintf("  - Iteraciones: %d\n", pasos_bin);
else
    fprintf("BÚSQUEDA BINARIA: No encontrado.\n");
end

fprintf("------------------------------------------\n");

if pos_fibo != -1
    fprintf("BÚSQUEDA FIBONACCI:\n");
    fprintf("  - Estado: ENCONTRADO\n");
    fprintf("  - Posición: %d\n", pos_fibo);
    fprintf("  - Iteraciones: %d\n", pasos_fibo);
else
    fprintf("BÚSQUEDA FIBONACCI: No encontrado.\n");
end
fprintf("==========================================\n");