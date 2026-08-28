# Documentación de la Práctica 2

Esta carpeta centraliza la documentación y las evidencias de la práctica.

## Contenido

- `Manual.pdf`: manual final de carga y consultas.
- `Manual.md` y `Manual.tex`: fuentes editables del manual.
- `Guia_Desarrollo_Practica_2.md`: guía de desarrollo y verificación.
- `Enunciado_Oficial_Practica_2.md` y `SBD1_Practica2_2S2026.pdf`: enunciado de la práctica.
- `evidencias/`: capturas de estructura, importación y consultas.
- `assets/`: recursos gráficos auxiliares.
- `compilar_manual.bat`: recompila `Manual.tex` con Tectonic.

## Compilar el manual

Desde PowerShell o el Explorador de archivos, ejecuta:

```powershell
.\compilar_manual.bat
```

El archivo generado queda en esta misma carpeta como `Manual.pdf`. El script utiliza
el ejecutable de Tectonic ubicado en `../.tools/tectonic/` y toma los scripts SQL
desde la raíz de `Práctica 2`.
