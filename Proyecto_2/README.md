# Circuito sumador

## 1. Abreviaturas y definiciones
- **FPGA**: Field Programmable Gate Arrays


## 2. Resumen
En este documento se expone la implementación de un diseño digital en FPGA de un circuito sumador de 2 números decimales de 3 dígitos. Para esto, se utilizaron principalmente 3 subsistemas, que a su vez pueden estar compuestos por 1 o más módulos: 1. Subsistema de lectura de los datos, 2.  Subsistema de suma aritmética de los dos datos, 3. Subsistema de despliegue de código decodificado en display de 7 segmentos.

## 3. Introducción


## 3. Desarrollo

### 3.0 Descripción general del sistema



### 3.1 Subsistema de lectura y decodificación de código Gray

### 3.2  Subsistema de despliegue de código ingresado traducido a formato binario en luces LED
#### 1. Encabezado del módulo


#### 2. Entradas y salidas:


#### 3. Criterios de diseño

 

#### 4. Testbench

### 3.3  Subsistema de despliegue de código decodificado en display de 7 segmentos.
#### 1. Encabezado del módulo



#### 2. Entradas y salidas:




#### 4. Testbench


## 4. Consumo de recursos


## 5. Conclusiones


## 6. Problemas encontrados durante el proyecto


## 7. Recomendaciones

## 6. Referencias
[0] David Harris y Sarah Harris. *Digital Design and Computer Architecture. RISC-V Edition.* Morgan Kaufmann, 2022. ISBN: 978-0-12-820064-3
